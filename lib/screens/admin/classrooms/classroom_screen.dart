import 'package:flutter/material.dart';
import 'package:school_management_app/constants/constants.dart';
import '../../../backend_integration/models/class_model.dart';
import '../../../backend_integration/services/class_service.dart';
import '../Home_Screen/admin_home_screen.dart';
import 'add_class_screen.dart';
import 'class_details_screen.dart';

class AdminClassRoomScreen extends StatefulWidget {
  const AdminClassRoomScreen({Key? key}) : super(key: key);

  static const routeName = 'AdminClassRoomScreen';

  @override
  _AdminClassRoomScreenState createState() => _AdminClassRoomScreenState();
}

class _AdminClassRoomScreenState extends State<AdminClassRoomScreen> {
  TextEditingController _classNameController = TextEditingController();
  final ClassService _classService = ClassService();
  List<Class> classNames = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAllClasses(); // Fetch classes when screen initializes
  }

  Future<void> _fetchAllClasses() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final List<Class> classes = await _classService.fetchAllClasses();
      setState(() {
        classNames = classes;
      });
    } catch (e) {
      print("Error fetching classes: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addClass(String className) async {
    try {
      final String response =
          await _classService.addClass(className as Map<String, dynamic>);
      print("Add class response: $response");
      _fetchAllClasses();
    } catch (e) {
      print("Error adding class: $e");
    }
  }

  Future<void> _editClass(String id, String className, String teacherID,
      List<String> studentIDs) async {
    try {
      final String response =
          await _classService.updateClass(id, className, teacherID, studentIDs);
      print("Edit class response: $response");
      _fetchAllClasses();
    } catch (e) {
      print("Error editing class: $e");
    }
  }

  Future<void> _deleteClass(String id) async {
    try {
      final String response = await _classService.deleteClass(id);
      print("Delete class response: $response");
      _fetchAllClasses();
    } catch (e) {
      print("Error deleting class: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AdminHomeScreen.routeName);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text('Class Rooms', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: kOtherColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildClassList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddClassScreen(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildClassList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: classNames.length,
            itemBuilder: (context, index) {
              return Card(
                color: kPrimaryColor,
                child: ListTile(
                  title: Text(
                    classNames[index].className,
                    style: const TextStyle(fontSize: 25, color: Colors.black54),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ClassDetailScreen(classDetails: classNames[index]),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black54),
                        onPressed: () {
                          _showEditClassDialog(context, index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.black54),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showAddClassDialog(BuildContext context) {
    _classNameController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Class"),
          content: classNameField(),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                _addClass(_classNameController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditClassDialog(BuildContext context, int index) {
    _classNameController.text = classNames[index].className;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Class"),
          content: classNameField(),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                _editClass(
                  classNames[index].id,
                  _classNameController.text,
                  classNames[index].teacherID,
                  classNames[index].studentIDs,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text(
            "Are you sure you want to delete this class?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                _deleteClass(classNames[index].id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextFormField classNameField() {
    return TextFormField(
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
      controller: _classNameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This Field cannot be empty";
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _classNameController.dispose();
    super.dispose();
  }
}
