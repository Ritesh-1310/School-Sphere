
class TeacherAnnouncement {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime dateTime;

  TeacherAnnouncement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.dateTime,
  });

  factory TeacherAnnouncement.fromJson(Map<String, dynamic> json) {
    return TeacherAnnouncement(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      author: json['by'],
      dateTime: DateTime.parse(json['createdAt']),
    );
  }
}
