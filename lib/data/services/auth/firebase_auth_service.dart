import 'package:blog_assignment/data/models/auth/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthService {
  Future<UserModel> signUp({required String email, required String password});
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> googleSignIn();
  Future<void> logOut();
}

class FirebaseAuthServiceImpl extends FirebaseAuthService {
  final _firebase = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebase.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user == null) throw Exception('user-not-found');

    return UserModel(
      uid: user.uid,
      email: user.email!,
      profileUrl: user.photoURL,
      displayName: user.displayName,
    );
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebase
        .createUserWithEmailAndPassword(email: email, password: password);

    // if (!userCredential.user!.emailVerified) {
    //   userCredential.user!.sendEmailVerification();
    // }

    final user = userCredential.user!;
    return UserModel(
      uid: user.uid,
      email: user.email!,
      profileUrl: user.photoURL,
      displayName: user.displayName,
    );
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Future<UserModel> googleSignIn() async {
    await _googleSignIn.initialize();

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    final googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebase.signInWithCredential(credential);

    final user = userCredential.user!;
    return UserModel(
      uid: user.uid,
      email: user.email!,
      profileUrl: user.photoURL,
      displayName: user.displayName,
    );
  }
}
