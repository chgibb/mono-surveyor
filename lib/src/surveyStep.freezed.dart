// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'surveyStep.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
SurveyStep _$SurveyStepFromJson(Map<String, dynamic> json) {
  return _$SurveyStepCtor.fromJson(json);
}

/// @nodoc
class _$SurveyStepTearOff {
  const _$SurveyStepTearOff();

// ignore: unused_element
  _$SurveyStepCtor call({@required String cmd, @required List<String> args}) {
    return _$SurveyStepCtor(
      cmd: cmd,
      args: args,
    );
  }

// ignore: unused_element
  SurveyStep fromJson(Map<String, Object> json) {
    return SurveyStep.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $SurveyStep = _$SurveyStepTearOff();

/// @nodoc
mixin _$SurveyStep {
  String get cmd;
  List<String> get args;

  Map<String, dynamic> toJson();
  $SurveyStepCopyWith<SurveyStep> get copyWith;
}

/// @nodoc
abstract class $SurveyStepCopyWith<$Res> {
  factory $SurveyStepCopyWith(
          SurveyStep value, $Res Function(SurveyStep) then) =
      _$SurveyStepCopyWithImpl<$Res>;
  $Res call({String cmd, List<String> args});
}

/// @nodoc
class _$SurveyStepCopyWithImpl<$Res> implements $SurveyStepCopyWith<$Res> {
  _$SurveyStepCopyWithImpl(this._value, this._then);

  final SurveyStep _value;
  // ignore: unused_field
  final $Res Function(SurveyStep) _then;

  @override
  $Res call({
    Object cmd = freezed,
    Object args = freezed,
  }) {
    return _then(_value.copyWith(
      cmd: cmd == freezed ? _value.cmd : cmd as String,
      args: args == freezed ? _value.args : args as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$$SurveyStepCtorCopyWith<$Res>
    implements $SurveyStepCopyWith<$Res> {
  factory _$$SurveyStepCtorCopyWith(
          _$SurveyStepCtor value, $Res Function(_$SurveyStepCtor) then) =
      __$$SurveyStepCtorCopyWithImpl<$Res>;
  @override
  $Res call({String cmd, List<String> args});
}

/// @nodoc
class __$$SurveyStepCtorCopyWithImpl<$Res>
    extends _$SurveyStepCopyWithImpl<$Res>
    implements _$$SurveyStepCtorCopyWith<$Res> {
  __$$SurveyStepCtorCopyWithImpl(
      _$SurveyStepCtor _value, $Res Function(_$SurveyStepCtor) _then)
      : super(_value, (v) => _then(v as _$SurveyStepCtor));

  @override
  _$SurveyStepCtor get _value => super._value as _$SurveyStepCtor;

  @override
  $Res call({
    Object cmd = freezed,
    Object args = freezed,
  }) {
    return _then(_$SurveyStepCtor(
      cmd: cmd == freezed ? _value.cmd : cmd as String,
      args: args == freezed ? _value.args : args as List<String>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_$SurveyStepCtor implements _$SurveyStepCtor {
  const _$_$SurveyStepCtor({@required this.cmd, @required this.args})
      : assert(cmd != null),
        assert(args != null);

  factory _$_$SurveyStepCtor.fromJson(Map<String, dynamic> json) =>
      _$_$_$SurveyStepCtorFromJson(json);

  @override
  final String cmd;
  @override
  final List<String> args;

  @override
  String toString() {
    return 'SurveyStep(cmd: $cmd, args: $args)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _$SurveyStepCtor &&
            (identical(other.cmd, cmd) ||
                const DeepCollectionEquality().equals(other.cmd, cmd)) &&
            (identical(other.args, args) ||
                const DeepCollectionEquality().equals(other.args, args)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(cmd) ^
      const DeepCollectionEquality().hash(args);

  @override
  _$$SurveyStepCtorCopyWith<_$SurveyStepCtor> get copyWith =>
      __$$SurveyStepCtorCopyWithImpl<_$SurveyStepCtor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_$SurveyStepCtorToJson(this);
  }
}

abstract class _$SurveyStepCtor implements SurveyStep {
  const factory _$SurveyStepCtor(
      {@required String cmd, @required List<String> args}) = _$_$SurveyStepCtor;

  factory _$SurveyStepCtor.fromJson(Map<String, dynamic> json) =
      _$_$SurveyStepCtor.fromJson;

  @override
  String get cmd;
  @override
  List<String> get args;
  @override
  _$$SurveyStepCtorCopyWith<_$SurveyStepCtor> get copyWith;
}
