import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumry_man/utils/extensions.dart';

import '../../data/repository/summary_repository.dart';

final homeViewModel = Provider.autoDispose((ref) {
  return HomeViewModel(ref.watch(summaryRepository));
});

class HomeViewModel {
  final SummaryRepository _repository;

  const HomeViewModel(this._repository);

  void copyToClipboard(String text, BuildContext context) async {
    Clipboard.setData(ClipboardData(text: text)).then((value) {
      context.showSnackMessage(
        text.isEmpty ? 'Nothing to copy' : 'Copied to clipboard',
      );
    });
  }
}
