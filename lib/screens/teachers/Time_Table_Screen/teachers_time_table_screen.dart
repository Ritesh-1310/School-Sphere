// import 'package:flutter/material.dart';
// import 'package:school_management_app/constants/constants.dart';
// import 'package:school_management_app/screens/teachers/Time_Table_Screen/data/teachers_time_table_data.dart';

// class TeachersTimeTableScreen extends StatelessWidget {
//   static const routeName = 'TeachersTimeTableScreen';

//   const TeachersTimeTableScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Timetable', style: TextStyle(color: Colors.white,),),
//         centerTitle: true,
//         backgroundColor: kPrimaryColor,
//       ),
//       backgroundColor: kOtherColor,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Display the days at the top with app's primary color
//             Container(
//               decoration: BoxDecoration(
//                 color: kPrimaryColor,
//                 border: Border.all(color: kPrimaryColor),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Row(
//                 children: [
//                   for (var day in TeachersTimeTableData[0])
//                     Expanded(
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             day,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.white, // Set text color to white
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Display the timetable in a tabular structure
//             Expanded(
//               child: ListView.builder(
//                 itemCount:
//                     TeachersTimeTableData.length - 1, // Exclude the first row
//                 itemBuilder: (context, rowIndex) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       children: [
//                         // Display time in the first column with primary color background
//                         Container(
//                           decoration: BoxDecoration(
//                             color: kPrimaryColor,
//                             border: Border.all(color: kPrimaryColor),
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           width: 60,
//                           // color: kPrimaryColor,
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 TeachersTimeTableData[rowIndex + 1][0],
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                   color: kOtherColor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Display class names in the remaining columns
//                         for (var colIndex = 1;
//                             colIndex <
//                                 TeachersTimeTableData[rowIndex + 1].length;
//                             colIndex++)
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: kPrimaryColor.withOpacity(0.1),
//                                 border: Border.all(color: kPrimaryColor),
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   TeachersTimeTableData[rowIndex + 1][colIndex],
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                       color: kTextBlackColor, fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//----------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:school_management_app/constants/constants.dart';
// import 'package:school_management_app/screens/teachers/Time_Table_Screen/data/teachers_time_table_data.dart';

// class TeachersTimeTableScreen extends StatelessWidget {
//   static const routeName = 'TeachersTimeTableScreen';

//   const TeachersTimeTableScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Timetable',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: kPrimaryColor,
//       ),
//       backgroundColor: kOtherColor,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//             columns: [
//               // Display time in the first column with primary color background
//               DataColumn(
//                 label: Container(
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: kPrimaryColor,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   padding: const EdgeInsets.all(8.0),
//                   child: const Center(
//                     child: Text(
//                       'Time',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: kOtherColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Display class names in the remaining columns
//               for (var day in TeachersTimeTableData[0].sublist(1))
//                 DataColumn(
//                   label: Container(
//                     width: 100, // Adjust the width as needed
//                     decoration: BoxDecoration(
//                       color: kPrimaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: Text(
//                         day,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: kTextBlackColor,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//             rows: List.generate(
//               TeachersTimeTableData.length - 1,
//               (index) => DataRow(
//                 cells: [
//                   // Display time in the first cell
//                   DataCell(
//                     Container(
//                       width: 100,
//                       padding: const EdgeInsets.all(8.0),
//                       child: Center(
//                         child: Text(
//                           TeachersTimeTableData[index][0],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: kOtherColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Display class names in the remaining cells
//                   for (var i = 1;
//                       i < TeachersTimeTableData[index + 1].length;
//                       i++)
//                     DataCell(
//                       Container(
//                         width: 100, // Adjust the width as needed
//                         padding: const EdgeInsets.all(8.0),
//                         child: Center(
//                           child: Text(
//                             TeachersTimeTableData[index + 1][i],
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               color: kTextBlackColor,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:school_management_app/constants/constants.dart';
import 'package:school_management_app/screens/teachers/Time_Table_Screen/data/teachers_time_table_data.dart';

class TeachersTimeTableScreen extends StatelessWidget {
  static const routeName = 'TeachersTimeTableScreen';

  const TeachersTimeTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Timetable',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: kOtherColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              // Display time in the first column with primary color background
              DataColumn(
                label: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      TeachersTimeTableData[0][0], // Display 'Time'
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kOtherColor,
                      ),
                    ),
                  ),
                ),
              ),
              // Display days in remaining columns
              for (var day in TeachersTimeTableData[0].sublist(1))
                DataColumn(
                  label: Container(
                    width: 100, // Adjust the width as needed
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
            rows: List.generate(
              TeachersTimeTableData.length - 1,
              (index) => DataRow(
                cells: [
                  // Display time in the first cell
                  DataCell(
                    Container(
                      width: 100,
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          TeachersTimeTableData[index + 1][0], // Display time slots
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: kOtherColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Display class names in the remaining cells
                  for (var i = 1; i < TeachersTimeTableData[index + 1].length; i++)
                    DataCell(
                      Container(
                        width: 100, // Adjust the width as needed
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            TeachersTimeTableData[index + 1][i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
