import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumry_man/utils/extensions.dart';

import '../components/app_bar.dart';
import '../components/buttons.dart';
import '../components/copyright.dart';
import '../components/drawer.dart';
import '../components/images.dart';
import '../components/input_field.dart';
import '../components/spacers.dart';
import '../data/repository/comment_repository.dart';
import '../utils/designs/dimens.dart';
import '../utils/res/res_profile.dart';
import '../data/repository/user_repository.dart';

class CommentScreen extends ConsumerStatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _commentController = TextEditingController();
  var _initialized = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (!_initialized) {
      final user = ref.watch(userRepository);
      _nameController.text = user?.displayName ?? '';
      _emailController.text = user?.email ?? '';
      _initialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                controller: _nameController,
                label: ResCommentScreen.fullName,
              ),
            ),
            vSpace(sPadding),
            InputField(
              state: InputFieldState(
                controller: _emailController,
                label: ResCommentScreen.emailAddress,
              ),
            ),
            vSpace(sPadding),
            Expanded(
              flex: 2,
              child: InputField(
                state: InputFieldState(
                  controller: _commentController,
                  label: ResCommentScreen.commentHere,
                  expands: true,
                ),
              ),
            ),
            vSpace(sPadding),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                isLoading: _isLoading,
                text: ResCommentScreen.leaveComment,
                backgroundColor: theme.colorScheme.primary,
                onPressed: _addComment,
              ),
            ),
            const Spacer(),
            const Copyright(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  _addComment() async {
    if (_emailController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _commentController.text.isEmpty) {
      context.showSnackMessage('Kindly fill all fields');
    } else {
      setState(() {
        _isLoading = true;
      });
      final repo = ref.read(commentRepository);
      repo
          .addComment(
            name: _nameController.text,
            email: _emailController.text,
            comment: _commentController.text,
          )
          .then((_) => _commentSubmitted());
    }
  }

  _commentSubmitted() {
    setState(() {
      _isLoading = false;
    });
    context.showSnackMessage('Comment Submitted');
    _commentController.clear();
    final repo = ref.read(userRepository.notifier);
    if (!repo.authenticated) {
      _nameController.clear();
      _emailController.clear();
    }
  }
}
