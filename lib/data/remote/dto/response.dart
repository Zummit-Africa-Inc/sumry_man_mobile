import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class SummaryResponse {
  final String summary;

  factory SummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$SummaryResponseFromJson(json);

  const SummaryResponse(this.summary);

  Map<String, dynamic> toJson() => _$SummaryResponseToJson(this);
}
