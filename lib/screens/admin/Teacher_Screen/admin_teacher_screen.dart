// admin_teacher_screen.dart
import 'package:flutter/material.dart';
import 'package:school_management_app/backend_integration/models/teacher_model.dart';
import 'package:school_management_app/constants/constants.dart';

import '../../../backend_integration/services/teacher_sevice.dart';

class AdminTeacherScreen extends StatefulWidget {
  const AdminTeacherScreen({Key? key}) : super(key: key);

  static const routeName = 'AdminTeacherScreen';

  @override
  _AdminTeacherScreenState createState() => _AdminTeacherScreenState();
}

class _AdminTeacherScreenState extends State<AdminTeacherScreen> {
  late Future<List<TeacherRegister>> _teachersFuture;

  @override
  void initState() {
    super.initState();
    _teachersFuture = APIService.fetchTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers List'),
        centerTitle: true,
      ),
      backgroundColor: kOtherColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<TeacherRegister>>(
          future: _teachersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return TeacherListScreen(teachers: snapshot.data!);
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

class TeacherListScreen extends StatelessWidget {
  final List<TeacherRegister> teachers;

  const TeacherListScreen({Key? key, required this.teachers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        return TeacherDetailsAccordion(teacher: teachers[index]);
      },
    );
  }
}

class TeacherDetailsAccordion extends StatelessWidget {
  const TeacherDetailsAccordion({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  final TeacherRegister teacher;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        title: Text(
          '${teacher.fname} ${teacher.lname}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        children: [
          // ListTile(
          //   title: Text(
          //     'Class: ${teacher.className}',
          //     style: const TextStyle(fontSize: 16, color: Colors.white,),
          //   ),
          // ),
          ListTile(
            title: Text(
              'Email: ${teacher.email}',
              style: const TextStyle(fontSize: 16, color: Colors.white,),
            ),
          ),
          ListTile(
            title: Text(
              'Contact: ${teacher.contact}',
              style: const TextStyle(fontSize: 16, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
