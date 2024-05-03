import 'package:flutter/material.dart';
import '../../../backend_integration/models/admin_announcement.dart';
import '../../../backend_integration/services/api_service.dart';
import '../../../components/custom_button.dart';

class EditAnnouncementScreen extends StatefulWidget {
  final AdminAnnouncement announcement;

  const EditAnnouncementScreen({Key? key, required this.announcement})
      : super(key: key);

  @override
  _EditAnnouncementScreenState createState() => _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _announcementController = TextEditingController();
  // final TextEditingController _authorController = TextEditingController();
  final APIService _apiService = APIService();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.announcement.title;
    _announcementController.text = widget.announcement.content;
    // _authorController.text = widget.announcement.author;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Edit Announcement',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_titleController, 'Title'),
            const SizedBox(height: 16.0),
            _buildTextField(_announcementController, 'Content', maxLines: null),
            const SizedBox(height: 16.0),
            // _buildTextField(_authorController, 'Author'),
            // const SizedBox(height: 16.0),
            CustomButton(
              onPress: _updateAnnouncement,
              title: "Update Announcement",
              iconData: Icons.post_add_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {int? maxLines}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 24,
        ), // Set label color to black
      ),
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 18,
      ), // Set user input color to black
      maxLines: maxLines,
    );
  }

  void _updateAnnouncement() async {
    String title = _titleController.text;
    String content = _announcementController.text;
    String author = "Admin";

    if (title.isNotEmpty && content.isNotEmpty && author.isNotEmpty) {
      await _apiService.updateAnnouncement(
          widget.announcement.id, title, content, author);
      Navigator.pop(context, true); // Return true to indicate successful update
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
    }
  }
}
