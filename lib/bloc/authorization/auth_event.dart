import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class UserRegistration extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirm;

  const UserRegistration(
      {required this.name,
      required this.email,
      required this.password,
      required this.passwordConfirm});

  @override
  List<Object> get props => [name, email, password, passwordConfirm];
}

class LoadUser extends AuthEvent {}

class DeleteErrors extends AuthEvent {}

class Logout extends AuthEvent {}

class UserLogin extends AuthEvent {
  final String email;
  final String password;

  const UserLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class UserInfoUpdate extends AuthEvent {
  final String email;
  final String name;

  const UserInfoUpdate({required this.email, required this.name});

  @override
  List<Object> get props => [email, name];
}

class UploadAvatar extends AuthEvent {
  final File file;

  const UploadAvatar({
    required this.file,
  });

  @override
  List<Object> get props => [file];
}
