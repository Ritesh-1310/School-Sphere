import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_management_app/constants/constants.dart';
import 'package:school_management_app/screens/login_screen/login_screen.dart';
import 'package:school_management_app/screens/students/announcement_screen/view_announcement_screen.dart';
import 'package:school_management_app/screens/students/assignment_screen/assignment_screen.dart';
import 'package:school_management_app/screens/students/attendance/attendance.dart';
import 'package:school_management_app/screens/students/event_screen/event_screen.dart';
import 'package:school_management_app/screens/students/fee_screen/fee_screen.dart';
import 'package:school_management_app/screens/students/gallery_screen/gallery_screen.dart';
import 'package:school_management_app/screens/students/holidays_screen/holiday_screen.dart';
import 'package:school_management_app/screens/students/home_screen/widgets/student_data.dart';
import 'package:school_management_app/screens/students/marks_screen/marks_post_screen.dart';
import 'package:school_management_app/screens/students/profile/student_profile.dart';
import 'package:school_management_app/screens/students/time_table_screen/students_time_table_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);
  static const routeName = 'StudentHomeScreen';

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  late String studentName;
  late int regNo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic>? userData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    studentName = "${userData?['fname']} ${userData?['lname']}";
    String reg = userData?['email'];
    regNo = int.tryParse(reg.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    regNo %= 20000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StudentName(studentName: studentName),
                        const SizedBox(height: kDefaultPadding / 2),
                        StudentClass(
                            studentClass: "Class X-II A | Reg No $regNo"),
                        const SizedBox(height: kDefaultPadding / 2),
                        StudentYear(session: "2020-24"),
                      ],
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    StudentPicture(
                      picLocation: 'assets/images/profile_placeholder.jpeg',
                      onPress: () {
                        Navigator.pushNamed(
                            context, StudentProfileScreen.routeName);
                      },
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     StudentDataCard(
                //       title: "Attendance",
                //       value: "90.2%",
                //       onPress: () {
                //         Navigator.pushNamed(
                //             context, StudentAttendaceScreen.routeName);
                //       },
                //     ),
                //     StudentDataCard(
                //       title: "Fee Dues",
                //       value: "Rs 6000",
                //       onPress: () {
                //         Navigator.pushNamed(context, FeeScreen.routeName);
                //       },
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: kOtherColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding * 3),
                    topRight: Radius.circular(kDefaultPadding * 3),
                  ),
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            // Navigator.pushNamed(context, StudentChatHomeScreen.routeName);
                          },
                          icon: 'assets/icons/ask.svg',
                          title: 'Ask',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, AssignmentScreen.routeName);
                          },
                          icon: 'assets/icons/assignment.svg',
                          title: 'Assignments',
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     // HomeCard(
                    //     //   onPress: () {
                    //     //     Navigator.pushNamed(
                    //     //         context, MarksPostScreen.routeName);
                    //     //   },
                    //     //   icon: 'assets/icons/result.svg',
                    //     //   title: 'Marks',
                    //     // ),
                    //     HomeCard(
                    //       onPress: () {
                    //         Navigator.pushNamed(
                    //             context, StudentsAnnouncementScreen.routeName);
                    //       },
                    //       icon: 'assets/icons/announcement.svg',
                    //       title: 'View Announcements',
                    //     ),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, HolidayScreen.routeName);
                          },
                          icon: 'assets/icons/holiday.svg',
                          title: 'Holidays',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, StudentsTimeTableScreen.routeName);
                          },
                          icon: 'assets/icons/timetable.svg',
                          title: 'Time Table',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(context, EventScreen.routeName);
                          },
                          icon: 'assets/icons/event.svg',
                          title: 'Events',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, GalleryScreen.routeName);
                          },
                          icon: 'assets/icons/gallery.svg',
                          title: 'Gallery',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // HomeCard(
                        //   onPress: () {},
                        //   icon: 'assets/icons/lock.svg',
                        //   title: 'Change Password',
                        // ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, StudentsAnnouncementScreen.routeName);
                          },
                          icon: 'assets/icons/announcement.svg',
                          title: 'View Announcements',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              LoginScreen.routeName,
                              (Route<dynamic> route) => false,
                            );
                          },
                          icon: 'assets/icons/logout.svg',
                          title: 'Logout',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.onPress,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final VoidCallback onPress;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(top: kDefaultPadding / 2),
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 40,
              width: 40,
              color: kOtherColor,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: kDefaultPadding / 3,
            )
          ],
        ),
      ),
    );
  }
}
