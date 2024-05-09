// teacher_model.dart
class TeacherRegister {
  String id;
  String email;
  String password;
  String fname;
  String lname;
  String contact;
  String className;

  TeacherRegister({
    required this.id,
    required this.email,
    required this.password,
    required this.fname,
    required this.lname,
    required this.contact,
    required this.className,
  });

  factory TeacherRegister.fromJson(Map<String, dynamic> json) {
    return TeacherRegister(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      fname: json['fname'],
      lname: json['lname'],
      contact: json['contact'],
      className: json['class'],
    );
  }
}
