import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_repository.dart';

final commentRepository = Provider.autoDispose((ref) {
  return CommentRepository(ref.watch(userRepository));
});

class CommentRepository {
  final User? _user;
  final _comments = FirebaseDatabase.instance.ref('comments');

  CommentRepository(this._user);

  Future<void> addComment({
    required String name,
    required String email,
    required String comment,
  }) async {
    await _comments.push().set({
      'user': _user?.uid,
      'name': name,
      'email': email,
      'comment': comment,
    });
  }
}
