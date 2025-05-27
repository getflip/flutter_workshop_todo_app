import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_dto.freezed.dart';
part 'todo_dto.g.dart';

@freezed
class TodoDTO with _$TodoDTO {
  const TodoDTO._();

  const factory TodoDTO({
    required String id,
    required String title,
    int? createdAtSeconds,
    required bool isDone,
    required String description,
    required String imageUrl,
  }) = _TodoDTO;

  factory TodoDTO.fromJson(Map<String, dynamic> json) => _$TodoDTOFromJson(json);
}
