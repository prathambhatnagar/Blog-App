import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Auth  Failures
class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure() : super("Invalid email or password.");
}

class EmailAlreadyInUseFailure extends Failure {
  const EmailAlreadyInUseFailure() : super("This email is already registered.");
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure() : super("The password provided is too weak.");
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super("No internet connection detected.");
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Internal server error."]);
}

class DataBaseFailure extends Failure {
  const DataBaseFailure([
    super.message = "Failed to retrive data from Data base.",
  ]);
}
