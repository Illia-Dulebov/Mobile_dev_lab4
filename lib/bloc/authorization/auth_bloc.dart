import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:edu_books_flutter/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/network_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<UserRegistration>(_onUserRegistration);
    on<UserLogin>(_onUserLogin);
    on<DeleteErrors>(_onDeleteErrors);
    on<LoadUser>(_onLoadUser);
    on<Logout>(_onLogout);
    on<UserInfoUpdate>(_onUserInfoUpdate);
    on<UploadAvatar>(_onUploadAvatar);
  }

  void _onLogout(
    Logout event,
    Emitter<AuthState> emit,
  ) async {
    await NetworkRepository().logout();
    await NetworkRepository().removeToken();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    emit(state.copyWith(
        user: null,
        userStatus: UserStatus.unauthenticated,
        errorMessages: null,
        authRequestStatus: Status.initial));
  }

  void _onLoadUser(
    LoadUser event,
    Emitter<AuthState> emit,
  ) async {
    bool haveToken = await NetworkRepository().isTokenExist();
    final prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');
    if (haveToken && userString != null) {
      emit(state.copyWith(
          user: UserModel.fromJson(jsonDecode(userString)),
          userStatus: UserStatus.authenticated,
          errorMessages: null,
          authRequestStatus: Status.initial));

      var user = await NetworkRepository().loadUser();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(user.toJson()));

      emit(state.copyWith(
        user: user,
      ));
    } else {
      emit(state.copyWith(
          user: null,
          userStatus: UserStatus.unauthenticated,
          errorMessages: null,
          authRequestStatus: Status.initial));
    }
  }

  _onUserInfoUpdate(
    UserInfoUpdate event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      updateUserStatus: Status.loading,
      errorMessages: [],
    ));

    try {
      await NetworkRepository().updateUserInfo(event.email, event.name);
      var user = await NetworkRepository().loadUser();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(user.toJson()));

      emit(state.copyWith(
        updateUserStatus: Status.success,
        errorMessages: [],
        user: user,
      ));
    } on ResponseError catch (_) {
      emit(state.copyWith(
        updateUserStatus: Status.failure,
        errorMessages: ['Введіть валідний емеіл'],
      ));
    }
  }

  _onUploadAvatar(
    UploadAvatar event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      updateUserStatus: Status.loading,
      errorMessages: [],
    ));

    try {
      await NetworkRepository().uploadAvatar(event.file);
      var user = await NetworkRepository().loadUser();

      user = user.copyWith(
        avatar: user.avatar + '?v=${Random().nextInt(1000)}',
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(user.toJson()));

      emit(state.copyWith(
        updateUserStatus: Status.success,
        errorMessages: [],
        user: user,
      ));
    } on ResponseError catch (_) {
      emit(state.copyWith(
        updateUserStatus: Status.failure,
        errorMessages: ['Не вдалося завантажити фото'],
      ));
    }
  }

  void _onDeleteErrors(
    DeleteErrors event,
    Emitter<AuthState> emit,
  ) async {
    emit(
        state.copyWith(errorMessages: null, authRequestStatus: Status.initial));
  }

  void _onUserRegistration(
    UserRegistration event,
    Emitter<AuthState> emit,
  ) async {
    try {
      Map<String, dynamic> data = await NetworkRepository().signUp({
        'name': event.name,
        'email': event.email,
        'password': event.password,
        'password_confirmation': event.passwordConfirm
      });

      if (data['status'] == 'success') {
        UserModel newUser = UserModel.fromJson(data['data']['user']);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(newUser.toJson()));

        emit(state.copyWith(
            authRequestStatus: Status.success,
            userStatus: UserStatus.authenticated,
            user: newUser,
            errorMessages: null));
      } else if (data['status'] == 'error') {
        emit(state.copyWith(
            authRequestStatus: Status.failure,
            userStatus: UserStatus.unauthenticated,
            user: null,
            errorMessages: Map.from(data['data']['errors'])
                .values
                .map((e) => List.from(e))
                .expand((element) => element)
                .toList()));
      } else {
        throw Exception('Get unexpected response in registration');
      }
    } catch (_) {
      emit(state.copyWith(
          authRequestStatus: Status.failure,
          userStatus: UserStatus.unauthenticated,
          user: null,
          errorMessages: ['Не вдалось виконати реєстрацію. Спробуйте знову.']));
    }
  }

  void _onUserLogin(
    UserLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      Map<String, dynamic> data = await NetworkRepository().login({
        'email': event.email,
        'password': event.password,
      });
      if (data['status'] == 'success') {
        UserModel newUser = UserModel.fromJson(data['data']['user']);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(newUser.toJson()));

        emit(state.copyWith(
            authRequestStatus: Status.success,
            userStatus: UserStatus.authenticated,
            user: newUser,
            errorMessages: null));
      } else if (data['status'] == 'error') {
        emit(state.copyWith(
            authRequestStatus: Status.failure,
            userStatus: UserStatus.unauthenticated,
            user: null,
            errorMessages: [
              data['data']['message'].toString().replaceAll(
                  'wrong email or password', 'Неправильний email або пароль')
            ]));
      } else {
        throw Exception('Get unexpected response in login');
      }
    } catch (_) {
      emit(state.copyWith(
          authRequestStatus: Status.failure,
          userStatus: UserStatus.unauthenticated,
          user: null,
          errorMessages: ['Не вдалось виконати вхід. Спробуйте знову.']));
    }
  }
}
