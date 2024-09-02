class AddScheduleCommand {
  final String content;
  final int notificationTime;
  final DateTime deadline;
  final DateTime createdAt;

  AddScheduleCommand({
    required this.content,
    required this.notificationTime,
    required this.deadline,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "content": content,
      "notificationTime": notificationTime,
      "deadline": deadline,
      "createdAt": createdAt,
    };
  }
}
