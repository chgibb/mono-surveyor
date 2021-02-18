// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'surveys.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Surveys _$SurveysFromJson(Map<String, dynamic> json) {
  return _$SurveysCtor.fromJson(json);
}

/// @nodoc
class _$SurveysTearOff {
  const _$SurveysTearOff();

// ignore: unused_element
  _$SurveysCtor call({@required Map<String, List<SurveyStep>> surveys}) {
    return _$SurveysCtor(
      surveys: surveys,
    );
  }

// ignore: unused_element
  Surveys fromJson(Map<String, Object> json) {
    return Surveys.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Surveys = _$SurveysTearOff();

/// @nodoc
mixin _$Surveys {
  Map<String, List<SurveyStep>> get surveys;

  Map<String, dynamic> toJson();
  $SurveysCopyWith<Surveys> get copyWith;
}

/// @nodoc
abstract class $SurveysCopyWith<$Res> {
  factory $SurveysCopyWith(Surveys value, $Res Function(Surveys) then) =
      _$SurveysCopyWithImpl<$Res>;
  $Res call({Map<String, List<SurveyStep>> surveys});
}

/// @nodoc
class _$SurveysCopyWithImpl<$Res> implements $SurveysCopyWith<$Res> {
  _$SurveysCopyWithImpl(this._value, this._then);

  final Surveys _value;
  // ignore: unused_field
  final $Res Function(Surveys) _then;

  @override
  $Res call({
    Object surveys = freezed,
  }) {
    return _then(_value.copyWith(
      surveys: surveys == freezed
          ? _value.surveys
          : surveys as Map<String, List<SurveyStep>>,
    ));
  }
}

/// @nodoc
abstract class _$$SurveysCtorCopyWith<$Res> implements $SurveysCopyWith<$Res> {
  factory _$$SurveysCtorCopyWith(
          _$SurveysCtor value, $Res Function(_$SurveysCtor) then) =
      __$$SurveysCtorCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, List<SurveyStep>> surveys});
}

/// @nodoc
class __$$SurveysCtorCopyWithImpl<$Res> extends _$SurveysCopyWithImpl<$Res>
    implements _$$SurveysCtorCopyWith<$Res> {
  __$$SurveysCtorCopyWithImpl(
      _$SurveysCtor _value, $Res Function(_$SurveysCtor) _then)
      : super(_value, (v) => _then(v as _$SurveysCtor));

  @override
  _$SurveysCtor get _value => super._value as _$SurveysCtor;

  @override
  $Res call({
    Object surveys = freezed,
  }) {
    return _then(_$SurveysCtor(
      surveys: surveys == freezed
          ? _value.surveys
          : surveys as Map<String, List<SurveyStep>>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_$SurveysCtor implements _$SurveysCtor {
  const _$_$SurveysCtor({@required this.surveys}) : assert(surveys != null);

  factory _$_$SurveysCtor.fromJson(Map<String, dynamic> json) =>
      _$_$_$SurveysCtorFromJson(json);

  @override
  final Map<String, List<SurveyStep>> surveys;

  @override
  String toString() {
    return 'Surveys(surveys: $surveys)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _$SurveysCtor &&
            (identical(other.surveys, surveys) ||
                const DeepCollectionEquality().equals(other.surveys, surveys)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(surveys);

  @override
  _$$SurveysCtorCopyWith<_$SurveysCtor> get copyWith =>
      __$$SurveysCtorCopyWithImpl<_$SurveysCtor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_$SurveysCtorToJson(this);
  }
}

abstract class _$SurveysCtor implements Surveys {
  const factory _$SurveysCtor(
      {@required Map<String, List<SurveyStep>> surveys}) = _$_$SurveysCtor;

  factory _$SurveysCtor.fromJson(Map<String, dynamic> json) =
      _$_$SurveysCtor.fromJson;

  @override
  Map<String, List<SurveyStep>> get surveys;
  @override
  _$$SurveysCtorCopyWith<_$SurveysCtor> get copyWith;
}
