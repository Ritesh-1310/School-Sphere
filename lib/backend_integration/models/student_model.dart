// student_model.dart
class StudentRegister {
  final String id;
  final String email;
  final String password;
  final String fname;
  final String lname;
  final String contact;
  final String dateOfBirth;
  final String classID;

  StudentRegister({
    required this.id,
    required this.email,
    required this.password,
    required this.fname,
    required this.lname,
    required this.contact,
    required this.dateOfBirth,
    required this.classID,
  });

  factory StudentRegister.fromJson(Map<String, dynamic> json) {
    return StudentRegister(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      fname: json['fname'],
      lname: json['lname'],
      contact: json['contact'],
      dateOfBirth: json['DateOfBirth'],
      classID: json['classID'],
    );
  }
}
