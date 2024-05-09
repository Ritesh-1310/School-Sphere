import 'package:flutter/material.dart';
import 'package:school_management_app/constants/constants.dart';
import '../../../backend_integration/models/class_model.dart';
import '../../../backend_integration/services/class_service.dart';

class TeacherClassRoomScreen extends StatefulWidget {
  const TeacherClassRoomScreen({Key? key}) : super(key: key);

  static const routeName = 'TeacherClassRoomScreen';

  @override
  _TeacherClassRoomScreenState createState() => _TeacherClassRoomScreenState();
}

class _TeacherClassRoomScreenState extends State<TeacherClassRoomScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Rooms', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: kOtherColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildClassList(),
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
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
