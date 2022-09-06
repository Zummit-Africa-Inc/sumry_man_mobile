import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository/user_repository.dart';

class UserImage extends ConsumerWidget {
  const UserImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = ref.watch(userRepository)?.photoURL;
    return CircleAvatar(
      backgroundColor:
          imageUrl == null ? Theme.of(context).colorScheme.primary : null,
      child: imageUrl == null
          ? const Icon(
              Icons.person,
              color: Colors.white,
            )
          : Image.network(imageUrl!),
    );
  }
}
