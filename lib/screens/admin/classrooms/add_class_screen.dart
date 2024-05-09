import 'package:flutter/material.dart';
import 'package:school_management_app/backend_integration/models/class_model.dart';
import 'package:school_management_app/backend_integration/models/student_model.dart';
import 'package:school_management_app/backend_integration/services/class_service.dart';
import 'package:school_management_app/backend_integration/models/teacher_model.dart';
import 'package:school_management_app/backend_integration/services/teacher_sevice.dart';
import '../../../backend_integration/services/student_service.dart';
import '../../../constants/constants.dart';
import 'classroom_screen.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({Key? key}) : super(key: key);
  static const routeName = 'AdminAddClassRoomScreen';

  @override
  _AddClassScreenState createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  TextEditingController _classNameController = TextEditingController();
  String? _selectedTeacherId;
  List<String> _selectedStudentIds = [];
  final ClassService _classService = ClassService();
  final StudentAPIService _studentAPIService = StudentAPIService();

  late Future<List<TeacherRegister>> _teachersFuture;
  late Future<List<StudentRegister>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _teachersFuture = APIService.fetchTeachers();
    _studentsFuture = _studentAPIService.fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Class', style: TextStyle(color: Colors.white,),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _classNameController,
              style: const TextStyle(
                color: kTextBlackColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                labelText: "Class Name",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                isDense: true,
              ),
              // style: const TextStyle(color: Colors.black),
              // decoration: const InputDecoration(
              // labelText: 'Class Name',
              // ),
            ),
            const SizedBox(height: 20.0),
            // Widget for selecting teacher
            FutureBuilder<List<TeacherRegister>>(
              future: _teachersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<TeacherRegister>? teachers = snapshot.data;
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ExpansionTile(
                      title: const Text(
                        'Select teacher',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      children: teachers!.map((teacher) {
                        return ListTile(
                          title: Text(
                            '${teacher.fname} ${teacher.lname}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedTeacherId = teacher.id;
                            });
                          },
                          // Add trailing icon to indicate selected teacher
                          trailing: _selectedTeacherId == teacher.id
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20.0),
            // Widget for selecting students
            FutureBuilder<List<StudentRegister>>(
              future: _studentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<StudentRegister>? students = snapshot.data;
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ExpansionTile(
                      title: const Text(
                        'Select students',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      children: students!.map((student) {
                        return ListTile(
                          title: Text(
                            '${student.fname} ${student.lname}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_selectedStudentIds.contains(student.id)) {
                                _selectedStudentIds.remove(student.id);
                              } else {
                                _selectedStudentIds.add(student.id);
                              }
                            });
                          },
                          // Add trailing icon to indicate selected student
                          trailing: _selectedStudentIds.contains(student.id)
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20.0),
            // Widget for create button
            // ElevatedButton(
            //   onPressed: () {
            //     _createClass();
            //   },
            //   child: const Text('Create Class'),
            // ),
            ElevatedButton(
              onPressed: () {
                _createClass();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Create Class',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.blue,
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createClass() async {
    try {
      String className = _classNameController.text;
      // Validate class name, teacher, and students
      if (className.isNotEmpty &&
          _selectedTeacherId != null &&
          _selectedStudentIds.isNotEmpty) {
        // Assuming you have a method to get the current date and time
        String currentDateTime =
            getCurrentDateTime(); // Implement getCurrentDateTime method

        Class newClass = Class(
          id: '', // Assigning an empty string for now, assuming the backend generates the ID
          className: className,
          teacherID: _selectedTeacherId!,
          studentIDs: _selectedStudentIds,
          createdAt: currentDateTime,
          updatedAt: currentDateTime,
          v: 0,
        );

        dynamic response = await _classService.addClass(newClass.toJson());
        print('Add class response: $response');
        Navigator.pushNamed(context,
            AdminClassRoomScreen.routeName); // Return to previous screen
      } else {
        // Show error message if any field is empty
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Please select a teacher, students, and fill all fields'),
          ),
        );
      }
    } catch (e) {
      print('Error creating class: $e');
      // Show error message if any exception occurs
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create class'),
        ),
      );
    }
  }

  // Method to get the current date and time
  String getCurrentDateTime() {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Format the date and time as per your requirement
    String formattedDateTime =
        '${now.year}-${_addZeroPrefix(now.month)}-${_addZeroPrefix(now.day)} '
        '${_addZeroPrefix(now.hour)}:${_addZeroPrefix(now.minute)}:${_addZeroPrefix(now.second)}';

    return formattedDateTime;
  }

  String _addZeroPrefix(int value) {
    // Add a zero prefix if the value is less than 10
    return value < 10 ? '0$value' : '$value';
  }
}
