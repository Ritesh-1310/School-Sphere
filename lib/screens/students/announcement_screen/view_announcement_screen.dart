import 'package:flutter/material.dart';
import 'package:school_management_app/constants/constants.dart';
import '../../../backend_integration/models/admin_announcement.dart';
import '../../../backend_integration/services/announcement_service.dart';

class StudentsAnnouncementScreen extends StatefulWidget {
  static const routeName = 'StudentsAnnouncementScreen';

  const StudentsAnnouncementScreen({super.key});

  @override
  State<StudentsAnnouncementScreen> createState() =>
      _StudentsAnnouncementScreenState();
}

class _StudentsAnnouncementScreenState
    extends State<StudentsAnnouncementScreen> {
  final AnnouncementService _announcementService = AnnouncementService();
  late Future<List<AdminAnnouncement>> _announcementsFuture;
  @override
  void initState() {
    super.initState();
    _announcementsFuture = _announcementService.fetchAllAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: kOtherColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kDefaultPadding),
            topRight: Radius.circular(kDefaultPadding),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
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
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Set border radius
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
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
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
}
