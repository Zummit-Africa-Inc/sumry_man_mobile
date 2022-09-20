// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextSummaryRequest _$TextSummaryRequestFromJson(Map<String, dynamic> json) =>
    TextSummaryRequest(
      json['text'] as String,
      json['sentence_count'] as int,
    );

Map<String, dynamic> _$TextSummaryRequestToJson(TextSummaryRequest instance) =>
    <String, dynamic>{
      'text': instance.text,
      'sentence_count': instance.sentenceCount,
    };

UrlSummaryRequest _$UrlSummaryRequestFromJson(Map<String, dynamic> json) =>
    UrlSummaryRequest(
      json['url'] as String,
      json['sentence_count'] as int,
    );

Map<String, dynamic> _$UrlSummaryRequestToJson(UrlSummaryRequest instance) =>
    <String, dynamic>{
      'url': instance.url,
      'sentence_count': instance.sentenceCount,
    };
