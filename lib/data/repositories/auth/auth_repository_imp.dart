import 'dart:developer';

import 'package:blog_assignment/core/failure/failure.dart';
import 'package:blog_assignment/data/models/auth/user_model.dart';
import 'package:blog_assignment/data/services/auth/firebase_auth_service.dart';
import 'package:blog_assignment/domain/entities/auth/user_entity.dart';
import 'package:blog_assignment/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImp extends AuthRepository {
  AuthRepositoryImp({required this.firebaseAuthService});
  FirebaseAuthService firebaseAuthService;

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await firebaseAuthService.signIn(
        email: email,
        password: password,
      );
      return right(userModel.toUserEntity());
    } on FirebaseAuthException catch (e) {
      switch (e.toString()) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return const Left(InvalidCredentialsFailure());
        case 'network-request-failed':
          return const Left(NetworkFailure());
        default:
          return Left(ServerFailure(e.message ?? "Authentication failed"));
      }
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
  }) async {
    log('SignUP');
    try {
      final userModel = await firebaseAuthService.signUp(
        email: email,
        password: password,
      );

      return Right(userModel.toUserEntity());
    } catch (e) {
      switch (e.toString()) {
        case 'email-already-in-use':
          return Left(EmailAlreadyInUseFailure());
        case 'weak-password':
          return const Left(WeakPasswordFailure());
        case 'network-request-failed':
          return const Left(NetworkFailure());
        default:
          return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, UserEntity>> googleSignIn() async {
    try {
      final user = await firebaseAuthService.googleSignIn();
      final userEntity = UserEntity(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
      );

      return Right(userEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      final result = await firebaseAuthService.logOut();
      return (right(result));
    } catch (e) {
      return left(ServerFailure());
    }
  }
}
