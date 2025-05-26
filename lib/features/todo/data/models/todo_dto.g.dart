// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoDTOImpl _$$TodoDTOImplFromJson(Map<String, dynamic> json) =>
    _$TodoDTOImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAtSeconds: (json['createdAtSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TodoDTOImplToJson(_$TodoDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAtSeconds': instance.createdAtSeconds,
    };
