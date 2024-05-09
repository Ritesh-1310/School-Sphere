import 'package:flutter/material.dart';
import 'package:school_management_app/backend_integration/models/class_model.dart';
import 'package:school_management_app/backend_integration/services/class_service.dart';

class ClassDetailScreen extends StatefulWidget {
  final Class classDetails;

  const ClassDetailScreen({Key? key, required this.classDetails})
      : super(key: key);

  @override
  _ClassDetailScreenState createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  String teacherName = '';
  List<String> studentNames = [];

  @override
  void initState() {
    super.initState();
    fetchTeacherName(widget.classDetails.teacherID);
    fetchStudentNames(widget.classDetails.studentIDs);
  }

  Future<void> fetchTeacherName(String teacherID) async {
    final response = await ClassService().fetchTeacherName(teacherID);
    setState(() {
      teacherName = response;
    });
  }

  Future<void> fetchStudentNames(List<String> studentIDs) async {
    List<String> names = [];
    for (String studentID in studentIDs) {
      final response = await ClassService().fetchStudentName(studentID);
      names.add(response);
    }
    setState(() {
      studentNames = names;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Class Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue, 
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      widget.classDetails.className,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // Add spacing between cards
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue, 
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Teacher: $teacherName',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16), // Add spacing between cards
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue, 
                child: ExpansionTile(
                  title: const Text(
                    'Students',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: studentNames.map((studentName) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            studentName,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
