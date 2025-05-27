// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoModelImpl _$$TodoModelImplFromJson(Map<String, dynamic> json) =>
    _$TodoModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      isDone: json['isDone'] as bool,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$TodoModelImplToJson(_$TodoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'isDone': instance.isDone,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
