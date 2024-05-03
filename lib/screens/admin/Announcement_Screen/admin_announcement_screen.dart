import 'package:flutter/material.dart';
import '../../../backend_integration/models/admin_announcement.dart';
import '../../../backend_integration/services/api_service.dart';
import '../../../components/custom_button.dart';
import '../../../constants/constants.dart';
import 'edit_announcement_screen.dart';

class AdminAnnouncementScreen extends StatefulWidget {
  const AdminAnnouncementScreen({Key? key}) : super(key: key);

  static const routeName = 'AdminAnnouncementScreen';

  @override
  _AdminAnnouncementScreenState createState() =>
      _AdminAnnouncementScreenState();
}

class _AdminAnnouncementScreenState extends State<AdminAnnouncementScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _announcementController = TextEditingController();
  // final TextEditingController _authorController = TextEditingController();
  final APIService _apiService = APIService();
  late Future<List<AdminAnnouncement>> _announcementsFuture;

  @override
  void initState() {
    super.initState();
    _announcementsFuture = _apiService.fetchAllAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Announcements',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildAnnouncementForm(),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<AdminAnnouncement>>(
                future: _announcementsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final announcements = snapshot.data!;
                    return ListView.builder(
                      itemCount: announcements.length,
                      itemBuilder: (context, index) {
                        final announcement = announcements[index];
                        return _buildAnnouncementCard(announcement);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(_titleController, 'Title'),
        const SizedBox(height: 10),
        _buildTextField(_announcementController, 'Announcement',
            maxLines: null,),
        const SizedBox(height: 10),
        // _buildTextField(_authorController, 'Author'),
        CustomButton(
          onPress: _postAnnouncement,
          title: "Post Announcement",
          iconData: Icons.post_add_outlined,
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {int? maxLines}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
        ), // Set label color to red
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ), // Set user input color to red
      maxLines: maxLines,
    );
  }

  Widget _buildAnnouncementCard(AdminAnnouncement announcement) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Set border radius
      ),
      color: kPrimaryColor.withOpacity(0.5),
      child: ListTile(
        title: Text(
          'Announcer: ${announcement.author}',
          style: const TextStyle(
            color: kTextBlackColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${_formatDate(announcement.dateTime)}',
              style: const TextStyle(
                color: kTextBlackColor,
                fontSize: 16,
              ),
            ),
            Text(
              'Time: ${_formatTime(announcement.dateTime)}',
              style: const TextStyle(
                color: kTextBlackColor,
                fontSize: 16,
              ),
            ),
            kHalfSizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Announcement:',
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  announcement.content,
                  style: const TextStyle(
                    color: kTextBlackColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: announcement.author == "Admin"
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editAnnouncement(context, announcement);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _confirmDeleteAnnouncement(context, announcement.id);
                    },
                  ),
                ],
              )
            : null,
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${_formatTwoDigits(dateTime.day)}/${_formatTwoDigits(dateTime.month)}/${dateTime.year} ';
  }

  String _formatTime(DateTime dateTime) {
    return '${_formatTwoDigits(dateTime.hour)}:${_formatTwoDigits(dateTime.minute)}';
  }

  String _formatTwoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  void _postAnnouncement() async {
    String title = _titleController.text;
    String content = _announcementController.text;
    // String author = _authorController.text;
    String author = "Admin";

    if (title.isNotEmpty && content.isNotEmpty && author.isNotEmpty) {
      await _apiService.postAnnouncement(title, content, author);
      setState(() {
        _announcementsFuture = _apiService.fetchAllAnnouncements();
        _titleController.clear();
        _announcementController.clear();
        // _authorController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
    }
  }

  void _confirmDeleteAnnouncement(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
            'Are you sure you want to delete this announcement?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                _deleteAnnouncement(id);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAnnouncement(String id) async {
    await _apiService.deleteAnnouncement(id);
    setState(() {
      _announcementsFuture = _apiService.fetchAllAnnouncements();
    });
  }

  void _editAnnouncement(BuildContext context, AdminAnnouncement announcement) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) =>
            EditAnnouncementScreen(announcement: announcement),
      ),
    )
        .then((value) {
      if (value == true) {
        // Reload announcements if the update was successful
        setState(() {
          _announcementsFuture = _apiService.fetchAllAnnouncements();
        });
      }
    });
  }
}
