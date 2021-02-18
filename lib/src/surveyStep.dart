import 'package:freezed_annotation/freezed_annotation.dart';

part 'surveyStep.g.dart';
part 'surveyStep.freezed.dart';

@freezed
abstract class SurveyStep with _$SurveyStep {
  const factory SurveyStep({
    @required String cmd,
    @required List<String> args,
  }) = _$SurveyStepCtor;

  factory SurveyStep.fromJson(Map<String, dynamic> json) => _$SurveyStepFromJson(json);
}
