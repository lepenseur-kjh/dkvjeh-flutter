class ScheduleEntity {
  final String content;
  final DateTime deadline;
  final int notificationTime;
  final DateTime createdAt;
  final String id;

  ScheduleEntity({
    required this.content,
    required this.deadline,
    required this.notificationTime,
    required this.createdAt,
    required this.id,
  });
}
