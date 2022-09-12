import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/app_bar.dart';
import '../components/buttons.dart';
import '../components/copyright.dart';
import '../components/drawer.dart';
import '../components/images.dart';
import '../components/input_field.dart';
import '../components/spacers.dart';
import '../utils/designs/dimens.dart';
import '../utils/res/res_profile.dart';
import '../data/repository/user_repository.dart';



class CommentScreen extends ConsumerStatefulWidget {
   const CommentScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {

   TextEditingController nameController = TextEditingController();

   TextEditingController emailController = TextEditingController();

   TextEditingController commentController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();


  @override
  Widget build(BuildContext context) {

    final repo = ref.read(userRepository.notifier);
    final user = ref.watch(userRepository);

    final theme = Theme.of(context);

    if(repo.authenticated){
      setState(() {
        nameController.text = user?.displayName as String;
        emailController.text = user?.email as String;

      });
    }


    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const DefaultAppBar(
        trailing: UserImage(),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(sPadding, sPadding, sPadding, 0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Text(
                  ResCommentScreen.leaveUsAComment,
                  style: theme.textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            vSpace(sPadding + sPadding / 2),
            InputField(
              state: InputFieldState(
                controller: nameController,
                label: ResCommentScreen.fullName,
              ),
            ),
            vSpace(sPadding),
            InputField(
              state: InputFieldState(
                controller: emailController,
                label: ResCommentScreen.emailAddress,
              ),
            ),
            vSpace(sPadding),
            Expanded(
              flex: 2,
              child: InputField(
                state: InputFieldState(
                  controller: commentController,
                  label: ResCommentScreen.commentHere,
                  expands: true,
                ),
              ),
            ),
            vSpace(sPadding),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                text: ResCommentScreen.leaveComment,
                backgroundColor: theme.colorScheme.primary,
                onPressed: () {
                  if (emailController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      commentController.text.isNotEmpty) {
                    addComment(nameController.text ,emailController.text,
                        commentController.text);
                  }

                  if(repo.authenticated){
                    commentController.clear();
                  }else{
                    emailController.clear();
                    nameController.clear();
                    commentController.clear();
                  }
                },
              ),
            ),
            const Spacer(),
            const Copyright(),
          ],
        ),
      ),
    );
  }
  void addComment (String name, String email, String comment) {
    databaseRef.child(nameController.text).push().set({
      'name': name,
      'email': email,
      'comment': comment,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: const Text('Comment Submitted')
      ),
    );

  }
}
