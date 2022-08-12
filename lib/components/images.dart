import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String? imageUrl;

  const UserImage(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
