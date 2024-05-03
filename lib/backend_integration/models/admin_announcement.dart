
class AdminAnnouncement {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime dateTime;

  AdminAnnouncement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.dateTime,
  });

  factory AdminAnnouncement.fromJson(Map<String, dynamic> json) {
    return AdminAnnouncement(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      author: json['by'],
      dateTime: DateTime.parse(json['createdAt']),
    );
  }
}
