import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepository = StateNotifierProvider<UserRepository, User?>((ref) {
  return UserRepository(FirebaseAuth.instance.currentUser);
});

class UserRepository extends StateNotifier<User?> {
  UserRepository(super.state);

  bool get authenticated {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<String?> login(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        state = result.user;
        return null;
      }
      return 'An error occured when logging in to your account';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    state = null;
  }
}
