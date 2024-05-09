class Class {
  final String id;
  final String className;
  final String teacherID;
  final List<String> studentIDs;
  final String createdAt;
  final String updatedAt;
  final int v;

  Class({
    required this.id,
    required this.className,
    required this.teacherID,
    required this.studentIDs,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['_id'],
      className: json['className'],
      teacherID: json['teacherID'],
      studentIDs: List<String>.from(json['studentIDs']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'className': className,
      'teacherID': teacherID,
      'studentIDs': studentIDs,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
