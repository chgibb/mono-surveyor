// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surveys.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_$SurveysCtor _$_$_$SurveysCtorFromJson(Map<String, dynamic> json) {
  return _$_$SurveysCtor(
    surveys: (json['surveys'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          (e as List)
              ?.map((e) => e == null
                  ? null
                  : SurveyStep.fromJson(e as Map<String, dynamic>))
              ?.toList()),
    ),
  );
}

Map<String, dynamic> _$_$_$SurveysCtorToJson(_$_$SurveysCtor instance) =>
    <String, dynamic>{
      'surveys': instance.surveys,
    };
