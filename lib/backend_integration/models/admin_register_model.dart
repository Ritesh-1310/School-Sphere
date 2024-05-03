// admin_model.dart
class AdminRegisgter {
  String email;
  String password;
  String fname;
  String lname;
  String contact;

  AdminRegisgter({
    required this.email,
    required this.password,
    required this.fname,
    required this.lname,
    required this.contact,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fname': fname,
      'lname': lname,
      'contact': contact,
    };
  }
}
