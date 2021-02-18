import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mono_surveyor/src/surveyStep.dart';

part 'surveys.g.dart';
part 'surveys.freezed.dart';

@freezed
abstract class Surveys with _$Surveys {
  const factory Surveys({
    @required Map<String, List<SurveyStep>> surveys,
  }) = _$SurveysCtor;

  factory Surveys.fromJson(Map<String, dynamic> json) =>
      _$SurveysFromJson(json);
}
