abstract class AuthBlocEvent {}

class EmailSignInEvent extends AuthBlocEvent {
  EmailSignInEvent({required this.email, required this.password});
  String email;
  String password;
}

class EmailSignUpEvent extends AuthBlocEvent {
  EmailSignUpEvent({required this.email, required this.password});
  String email;
  String password;
}

class GoogleSignUpEvent extends AuthBlocEvent {}

class LogOutEvent extends AuthBlocEvent {}
