import 'package:blog_assignment/domain/entities/auth/user_entity.dart';

abstract class AuthBlocState {
  const AuthBlocState();
}

class AuthenticatedState extends AuthBlocState {
  AuthenticatedState({required this.userEntity});
  UserEntity userEntity;
}

class UnAuthenticatedState extends AuthBlocState {}

class AuthLoadingState extends AuthBlocState {}

class AuthErrorState extends AuthBlocState {
  AuthErrorState({required this.message});
  String message;
}
