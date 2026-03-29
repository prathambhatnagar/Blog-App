import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/data/services/auth/firebase_auth_service.dart';
import 'package:blog_assignment/domain/entities/auth/user_entity.dart';
import 'package:blog_assignment/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepositoryImp extends AuthRepository {
  AuthRepositoryImp({required this.firebaseAuthService});
  FirebaseAuthService firebaseAuthService;

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      User? user = await firebaseAuthService.signIn(
        email: email,
        password: password,
      );
      if (user != null) {
        return right(user);
      }
    } catch (e) {
      return left();
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
  });

  @override
  Future<Either<Failure, UserEntity>> googleSignIn() async {
    try{
      final GoogleSignInAccount googleAccount = await firebaseAuthService.googleSignIn();
    }
    

  }
}
