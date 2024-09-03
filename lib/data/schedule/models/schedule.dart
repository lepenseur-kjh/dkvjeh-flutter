import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dkejvh/domain/schedule/entities/schedule.dart';

class ScheduleModel {
  final String content;
  final Timestamp deadline;
  final int notificationTime;
  final Timestamp createdAt;
  final String id;

  ScheduleModel({
    required this.content,
    required this.deadline,
    required this.notificationTime,
    required this.createdAt,
    required this.id,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      content: map["content"] as String,
      deadline: map["deadline"] as Timestamp,
      notificationTime: map["notificationTime"] as int,
      createdAt: map["createdAt"] as Timestamp,
      id: map["id"] as String,
    );
  }
}

extension ScheduleXModel on ScheduleModel {
  ScheduleEntity toEntity() {
    return ScheduleEntity(
      content: content,
      deadline: deadline.toDate(),
      notificationTime: notificationTime,
      createdAt: createdAt.toDate(),
      id: id,
    );
  }
}
