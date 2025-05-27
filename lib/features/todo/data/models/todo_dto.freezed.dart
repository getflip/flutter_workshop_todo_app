// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TodoDTO _$TodoDTOFromJson(Map<String, dynamic> json) {
  return _TodoDTO.fromJson(json);
}

/// @nodoc
mixin _$TodoDTO {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;
  int? get createdAtSeconds => throw _privateConstructorUsedError;

  /// Serializes this TodoDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoDTOCopyWith<TodoDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoDTOCopyWith<$Res> {
  factory $TodoDTOCopyWith(TodoDTO value, $Res Function(TodoDTO) then) =
      _$TodoDTOCopyWithImpl<$Res, TodoDTO>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String imageUrl,
    bool isDone,
    int? createdAtSeconds,
  });
}

/// @nodoc
class _$TodoDTOCopyWithImpl<$Res, $Val extends TodoDTO>
    implements $TodoDTOCopyWith<$Res> {
  _$TodoDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? isDone = null,
    Object? createdAtSeconds = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            imageUrl:
                null == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String,
            isDone:
                null == isDone
                    ? _value.isDone
                    : isDone // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdAtSeconds:
                freezed == createdAtSeconds
                    ? _value.createdAtSeconds
                    : createdAtSeconds // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TodoDTOImplCopyWith<$Res> implements $TodoDTOCopyWith<$Res> {
  factory _$$TodoDTOImplCopyWith(
    _$TodoDTOImpl value,
    $Res Function(_$TodoDTOImpl) then,
  ) = __$$TodoDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String imageUrl,
    bool isDone,
    int? createdAtSeconds,
  });
}

/// @nodoc
class __$$TodoDTOImplCopyWithImpl<$Res>
    extends _$TodoDTOCopyWithImpl<$Res, _$TodoDTOImpl>
    implements _$$TodoDTOImplCopyWith<$Res> {
  __$$TodoDTOImplCopyWithImpl(
    _$TodoDTOImpl _value,
    $Res Function(_$TodoDTOImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? isDone = null,
    Object? createdAtSeconds = freezed,
  }) {
    return _then(
      _$TodoDTOImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        imageUrl:
            null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        isDone:
            null == isDone
                ? _value.isDone
                : isDone // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdAtSeconds:
            freezed == createdAtSeconds
                ? _value.createdAtSeconds
                : createdAtSeconds // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoDTOImpl extends _TodoDTO {
  const _$TodoDTOImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.isDone,
    this.createdAtSeconds,
  }) : super._();

  factory _$TodoDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoDTOImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String imageUrl;
  @override
  final bool isDone;
  @override
  final int? createdAtSeconds;

  @override
  String toString() {
    return 'TodoDTO(id: $id, title: $title, description: $description, imageUrl: $imageUrl, isDone: $isDone, createdAtSeconds: $createdAtSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isDone, isDone) || other.isDone == isDone) &&
            (identical(other.createdAtSeconds, createdAtSeconds) ||
                other.createdAtSeconds == createdAtSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    imageUrl,
    isDone,
    createdAtSeconds,
  );

  /// Create a copy of TodoDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDTOImplCopyWith<_$TodoDTOImpl> get copyWith =>
      __$$TodoDTOImplCopyWithImpl<_$TodoDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoDTOImplToJson(this);
  }
}

abstract class _TodoDTO extends TodoDTO {
  const factory _TodoDTO({
    required final String id,
    required final String title,
    required final String description,
    required final String imageUrl,
    required final bool isDone,
    final int? createdAtSeconds,
  }) = _$TodoDTOImpl;
  const _TodoDTO._() : super._();

  factory _TodoDTO.fromJson(Map<String, dynamic> json) = _$TodoDTOImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  bool get isDone;
  @override
  int? get createdAtSeconds;

  /// Create a copy of TodoDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoDTOImplCopyWith<_$TodoDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
