import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthService {
  Future<User?> signUp({required String email, required String password});
  Future<User?> signIn({required String email, required String password});
  Future<User?> googleSignIn();

  Future<void> logOut();
}

class FirebaseAuthServiceImpl extends FirebaseAuthService {
  final firebase = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await firebase.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  @override
  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await firebase
        .createUserWithEmailAndPassword(email: email, password: password);

    if (!userCredential.user!.emailVerified) {
      userCredential.user!.sendEmailVerification();
    }

    return userCredential.user;
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<User?> googleSignIn() async {
    try {
      await _googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebase.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      return null; // or throw if you prefer
    }
  }
}
