import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';

enum Status {
  initial,
  loading,
  success,
  failure,
}

enum UserStatus {
  authenticated,
  unauthenticated,
  loading,
}

class AuthState extends Equatable {
  final Status authRequestStatus;
  final Status updateUserStatus;
  final UserStatus userStatus;
  final UserModel? user;
  final List<dynamic>? errorMessages;

  const AuthState({
    this.authRequestStatus = Status.initial,
    this.userStatus = UserStatus.loading,
    this.updateUserStatus = Status.initial,
    this.user,
    this.errorMessages
  });

  AuthState copyWith({
    Status? authRequestStatus,
    Status? updateUserStatus,
    UserStatus? userStatus,
    UserModel? user,
    List<dynamic>? errorMessages
    }) {
    return AuthState(
      authRequestStatus: authRequestStatus ?? this.authRequestStatus,
      userStatus: userStatus ?? this.userStatus,
      user: user ?? this.user,
      updateUserStatus: updateUserStatus ?? this.updateUserStatus,
      errorMessages: errorMessages ?? this.errorMessages,
    );
  }

  @override
  List<Object?> get props => [user, authRequestStatus, userStatus, updateUserStatus, errorMessages];
}
