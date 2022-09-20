import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable()
class TextSummaryRequest {
  final String text;

  @JsonKey(name: 'sentence_count')
  final int sentenceCount;

  factory TextSummaryRequest.fromJson(Map<String, dynamic> json) =>
      _$TextSummaryRequestFromJson(json);

  const TextSummaryRequest(this.text, this.sentenceCount);

  Map<String, dynamic> toJson() => _$TextSummaryRequestToJson(this);
}

@JsonSerializable()
class UrlSummaryRequest {
  final String url;

  @JsonKey(name: 'sentence_count')
  final int sentenceCount;

  factory UrlSummaryRequest.fromJson(Map<String, dynamic> json) =>
      _$UrlSummaryRequestFromJson(json);

  const UrlSummaryRequest(this.url, this.sentenceCount);

  Map<String, dynamic> toJson() => _$UrlSummaryRequestToJson(this);
}
