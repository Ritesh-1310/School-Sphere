import 'package:flutter/material.dart';
import 'package:school_management_app/backend_integration/models/student_model.dart';
import 'package:school_management_app/constants/constants.dart';
import '../../../backend_integration/services/student_service.dart';

class AdminStudentScreen extends StatefulWidget {
  const AdminStudentScreen({Key? key}) : super(key: key);
  static const routeName = 'AdminStudentScreen';

  @override
  _AdminStudentScreenState createState() => _AdminStudentScreenState();
}

class _AdminStudentScreenState extends State<AdminStudentScreen> {
  late Future<List<StudentRegister>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = StudentAPIService().fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Students List",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<StudentRegister>>(
          future: _studentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return StudentCard(student: snapshot.data![index]);
                },
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final StudentRegister student;

  const StudentCard({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: kPrimaryColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        title: Text(
          '${student.fname} ${student.lname}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        children: [
          ListTile(
            title: Text(
              'Date of Birth: ${student.dateOfBirth}',
              style: const TextStyle(fontSize: 16, color: Colors.white,),
            ),
          ),
          ListTile(
            title: Text(
              'Email: ${student.email}',
              style: const TextStyle(fontSize: 16, color: Colors.white,),
            ),
          ),
          ListTile(
            title: Text(
              'Contact: ${student.contact}',
              style: const TextStyle(fontSize: 16, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
