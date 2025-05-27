// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoDTOImpl _$$TodoDTOImplFromJson(Map<String, dynamic> json) =>
    _$TodoDTOImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAtSeconds: (json['createdAtSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TodoDTOImplToJson(_$TodoDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isDone': instance.isDone,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'createdAtSeconds': instance.createdAtSeconds,
    };
