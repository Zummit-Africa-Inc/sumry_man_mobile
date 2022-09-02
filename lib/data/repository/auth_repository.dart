import 'package:firebase_auth/firebase_auth.dart';
class AuthRepository{
  User? get user {
    return FirebaseAuth.instance.currentUser;
  }

 Future <String?> login(String email, String password) async {
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
       return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch(e){
      return e.toString();
    }

  }

  Future<String?> register(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {

      return e.toString();
    }

}
}
