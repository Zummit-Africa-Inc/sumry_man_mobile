import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import 'dto/response.dart';
import 'dto/request.dart';

part 'api_client.g.dart';

final apiClient = Provider.autoDispose((ref) {
  return ApiClient(
    Dio()
      ..options = BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 5000,
        followRedirects: false,
        validateStatus: (status) => (status ?? 0) <= 500,
        responseType: ResponseType.json,
      )
      ..interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      ),
  );
});

class ApiEndpoints {
  static const baseUrl =
      'https://summaryer-api.pk25mf6178910.eu-west-3.cs.amazonlightsail.com';

  static const text = '/text';
  static const url = '/url';
  static const file = '/upload_file';
}

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(ApiEndpoints.text)
  Future<SummaryResponse> summarizeText(@Body() TextSummaryRequest request);

  @POST(ApiEndpoints.url)
  Future<SummaryResponse> summarizeUrl(@Body() UrlSummaryRequest request);

  @MultiPart()
  @POST(ApiEndpoints.file)
  Future<SummaryResponse> summarizeFile(
    @Header("Content-Type") String contentType,
    @Part(name: "file_upload", contentType: 'text/plain') File fileUpload,
  );
}
