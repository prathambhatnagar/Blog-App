abstract class AuthBlocEvent {}

class EmailSignInEvent extends AuthBlocEvent {
  EmailSignInEvent({required this.email, required this.password});
  String email;
  String password;
}

class EmailSignUpEvent extends AuthBlocEvent {
  EmailSignUpEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
  String email;
  String password;
  String name;
  String phone;
}

class AuthCheckRequested extends AuthBlocEvent {}

class GoogleSignUpEvent extends AuthBlocEvent {}

class LogOutEvent extends AuthBlocEvent {}
