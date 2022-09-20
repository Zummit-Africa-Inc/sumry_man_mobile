import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumry_man/data/remote/dto/request.dart';

import '../../utils/result.dart';
import '../remote/api_client.dart';

final summaryRepository = Provider.autoDispose((ref) {
  return SummaryRepository(ref.watch(apiClient));
});

class SummaryRepository {
  final ApiClient remote;

  const SummaryRepository(this.remote);

  Future<Result<String>> summarize(String text, int sentenceCount) async {
    var validUrl = false;
    if (text.length > 1000) {
      validUrl = false;
    } else {
      validUrl = Uri.parse(text).isAbsolute;
    }
    return (validUrl)
        ? _summarizeUrl(text, sentenceCount)
        : _summarizeText(text, sentenceCount);
  }

  Future<Result<String>> _summarizeText(String text, int sentenceCount) async {
    return remote
        .summarizeText(TextSummaryRequest(text, sentenceCount))
        .then((response) => Result.success(response.summary))
        .onError((e, _) => Result.failure(_errorText(e)));
  }

  Future<Result<String>> _summarizeUrl(String url, int sentenceCount) async {
    return remote
        .summarizeUrl(UrlSummaryRequest(url, sentenceCount))
        .then((response) {
      if (response.summary.isEmpty) {
        return Result.failure<String>('The url ($url) does not have a summary');
      } else {
        return Result.success(response.summary);
      }
    }).onError((e, _) => Result.failure(_errorText(e)));
  }

  Future<Result<String>> summarizeFile(File file, int sentenceCount) async {
    final extension = file.path.split('.').last;
    final contentType = extension == 'txt'
        ? 'text/plain'
        : 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';

    return remote
        .summarizeFile(contentType, file)
        .then((response) => Result.success(response.summary))
        .onError((e, _) => Result.failure(_errorText(e)));
  }

  static String _errorText(dynamic e) {
    if (e is DioError) {
      if (e.response == null) {
        return 'Please check your internet connection and try again';
      } else {
        return e.message;
      }
    }
    return 'Failed to summarize the requested content';
  }
}
