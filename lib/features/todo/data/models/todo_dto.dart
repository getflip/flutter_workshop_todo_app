import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_dto.freezed.dart';
part 'todo_dto.g.dart';

@freezed
class TodoDTO with _$TodoDTO {
  const TodoDTO._();

  const factory TodoDTO({
    required String id,
    required String title,
    String? description,
    String? imageUrl,
    bool? isDone,
    int? createdAtSeconds,
  }) = _TodoDTO;

  factory TodoDTO.fromJson(Map<String, dynamic> json) => _$TodoDTOFromJson(json);
}
