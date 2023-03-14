import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/src/models/task.dart';
import 'package:app/src/screens/update_task.dart';
import 'package:app/src/widgets/task_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../resources/theme/colors.dart';
import 'package:app/src/widgets/calendar_dates.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.email});
  final String email;
  @override
  State<CalendarPage> createState() => CalendarP();
}

class CalendarP extends State<CalendarPage> {
  String selectedDate = '';
  String todayDate = DateFormat('d').format(DateTime.now()).toString();
  late List<Task> list = [];
  final dates = <DateTime>[];
  final dayList = <String>[];
  final nextDayList = <String>[];
  final List<String> dateList = [];
  final firstDates = <String>[];
  final lastDates = <String>[];
  final _currentDate = DateTime.now();
  final _dateFormatter = DateFormat('d');
  final _dayFormatter = DateFormat('EEE');
  String month = DateFormat('d MMMM, y').format(DateTime.now());
  String currentDay = DateFormat('d').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    init();
    String a = DateFormat('d').format(DateTime.now());
    selectedDate = a;
  }

  void init() {
    for (int j = 7; j > 0; j--) {
      final last = _currentDate.subtract(Duration(days: j));
      dateList.add(_dateFormatter.format(last));
      dayList.add(_dayFormatter.format(last));
    }
    for (int i = 0; i < 7; i++) {
      final date = _currentDate.add(Duration(days: i));
      nextDayList.add(_dayFormatter.format(date));
      lastDates.add(_dateFormatter.format(date));
    }
    dateList.addAll(lastDates);
    dayList.addAll(nextDayList);
  }

  Widget dashLine() {
    return const Center(
        child: FittedBox(
      child: Text(
        '----------------------------',
        style: TextStyle(fontSize: 15, color: Colors.black26, letterSpacing: 5),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          color: LightColors.kLightYellow,
          child: Column(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 25,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Today',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w800)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/addTask');
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                          color: LightColors.kDarkBlue,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        'Add Task',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Calender
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  month,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,
                ),
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                height: 68,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dayList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = dateList[index];
                          });
                          print("Selected Date::$selectedDate");
                        },
                        child: CalendarDates(
                            day: dayList[index],
                            date: dateList[index],
                            dayColor: dateList[index] == currentDay
                                ? LightColors.kRed
                                : Colors.black54,
                            dateColor: dateList[index] == currentDay
                                ? LightColors.kRed
                                : LightColors.kDarkBlue),
                      );
                    }),
              ),
              //Time && Schedule
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('projects')
                            .doc(widget.email)
                            .collection('project')
                            .where('date', isEqualTo: selectedDate)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasData) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.docs.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            TaskContainer(
                                              title: snapshot.data?.docs[index]
                                                  ['title'],
                                              description: snapshot.data
                                                  ?.docs[index]['description'],
                                              startTime: snapshot.data
                                                  ?.docs[index]['startTime'],
                                              endTime: snapshot
                                                  .data?.docs[index]['endTime'],
                                              delete: () {
                                                DocumentReference users =
                                                    FirebaseFirestore.instance
                                                        .collection('projects')
                                                        .doc(widget.email)
                                                        .collection('project')
                                                        .doc(snapshot.data
                                                                ?.docs[index]
                                                            ['title']);
                                                users.delete();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Project Deleted Successfully",
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              },
                                              edit: () {
                                                String coma = ',';
                                                String date =
                                                    '${snapshot.data?.docs[index]['day']}$coma ${snapshot.data?.docs[index]['date']} ${snapshot.data?.docs[index]['year']}';
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateTask(
                                                      title: snapshot
                                                              .data?.docs[index]
                                                          ['title'],
                                                      category: snapshot
                                                              .data?.docs[index]
                                                          ['category'],
                                                      date: date,
                                                      description: snapshot
                                                              .data?.docs[index]
                                                          ['description'],
                                                      eTime: snapshot
                                                              .data?.docs[index]
                                                          ['endTime'],
                                                      progress: snapshot
                                                              .data?.docs[index]
                                                          ['progress'],
                                                      sTime: snapshot
                                                              .data?.docs[index]
                                                          ['startTime'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              tagDelete: snapshot
                                                  .data?.docs[index]['title'],
                                              tagEdit: snapshot.data
                                                  ?.docs[index]['description'],
                                            ),
                                            dashLine(),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            );
                          }
                          return const Text('');
                        },
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
