import 'dart:developer';

import 'package:blog_assignment/core/usecase/usecase.dart';
import 'package:blog_assignment/domain/repositories/auth/auth_repository.dart';
import 'package:blog_assignment/domain/usecases/auth/email_sign_in_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/email_sign_up_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/google_sign_in_usecase.dart';
import 'package:blog_assignment/domain/usecases/auth/log_out_usecase.dart';
import 'package:blog_assignment/presentation/auth/bloc/auth_bloc_event.dart';
import 'package:blog_assignment/presentation/auth/bloc/auth_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final EmailSignInUsecase emailSignInUsecase;
  final EmailSignUpUsecase emailSignUpUsecase;
  final LogOutUsecase logOutUsecase;
  final GoogleSignInUsecase googleSignInUsecase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.emailSignInUsecase,
    required this.emailSignUpUsecase,
    required this.googleSignInUsecase,
    required this.logOutUsecase,
    required this.authRepository,
  }) : super(UnAuthenticatedState()) {
    on<EmailSignInEvent>((event, emit) => _onEmailSignInEvent(event, emit));
    on<EmailSignUpEvent>((event, emit) => _onEmailSignUpEvent(event, emit));
    on<GoogleSignUpEvent>((event, emit) => _onGoogleSignInEvent(event, emit));
    on<LogOutEvent>((event, emit) => _onLogOut(event, emit));
    on<AuthCheckRequested>((event, emit) => _onAuthCheckRequested(event, emit));
  }

  Future<void> _onEmailSignInEvent(
    EmailSignInEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    log('Sign in Event thown');
    emit(AuthLoadingState());
    final result = await emailSignInUsecase.call(
      param: SignInParam(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        log(failure.message);
        emit(AuthErrorState(message: failure.message));
      },
      (userEntity) {
        log(userEntity.email);
        emit(AuthenticatedState(userEntity: userEntity));
      },
    );
  }

  Future<void> _onEmailSignUpEvent(
    EmailSignUpEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    log('SignUp Event thown');

    emit(AuthLoadingState());
    final result = await emailSignUpUsecase.call(
      param: SignUpParam(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        log(failure.message);

        emit(AuthErrorState(message: failure.message));
      },
      (userEntity) {
        log(userEntity.email);

        emit(AuthenticatedState(userEntity: userEntity));
      },
    );
  }

  Future<void> _onGoogleSignInEvent(
    GoogleSignUpEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await googleSignInUsecase.call(param: NoParam());

    result.fold(
      (failure) {
        emit(AuthErrorState(message: failure.message));
      },
      (userEntity) {
        emit(AuthenticatedState(userEntity: userEntity));
      },
    );
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthBlocState> emit,
  ) async {
    final user = authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthenticatedState(userEntity: user));
    } else {
      emit(UnAuthenticatedState());
    }
  }

  Future<void> _onLogOut(LogOutEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState());
    final result = await logOutUsecase.call(param: NoParam());
    result.fold((failure) {
      emit(AuthErrorState(message: failure.message));
    }, (_) => emit(UnAuthenticatedState()));
  }
}
