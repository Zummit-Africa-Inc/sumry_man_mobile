import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final userRepository = StateNotifierProvider<UserRepository, User?>((ref) {
  return UserRepository(FirebaseAuth.instance.currentUser);
});

class UserRepository extends StateNotifier<User?> {
  UserRepository(super.state);

  final _google = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  bool get authenticated {
    return _auth.currentUser != null;
  }

  Future<String?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        state = result.user;
        return null;
      }
      return 'An error occured when logging in to your account';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An error occured when logging in to your account';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        await result.user?.updateDisplayName(username);
        state = result.user;
        return null;
      }
      return 'An error occured when creating your account';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An error occured when creating your account';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signInWithGoogle() async {
    final account = await _google.signIn();

    if (account == null) {
      return 'An error occured when creating your account';
    }

    final auth = await account.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );

    try {
      final result = await _auth.signInWithCredential(credential);
      if (result.user != null && result.user?.isAnonymous == false) {
        state = result.user;
        return null;
      }
      return 'An error occured when creating your account';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An error occured when creating your account';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    state = null;
  }
}
