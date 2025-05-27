import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  const TodoModel._();

  const factory TodoModel({required String id, required String title, DateTime? createdAt, String? imageUrl, String? description, required bool isDone}) =
      _TodoModel;

  DateTime get effectiveCreatedAt => createdAt ?? DateTime.now();

  String get formattedDate {
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    return dateFormat.format(effectiveCreatedAt);
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);
}
