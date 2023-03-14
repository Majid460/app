import 'package:app/src/blocs/add_task_bloc/add_bloc.dart';
import 'package:app/src/blocs/add_task_bloc/add_event.dart';
import 'package:app/src/blocs/add_task_bloc/add_state.dart';
import 'package:app/src/models/task.dart';
import 'package:app/src/models/user.dart';
import 'package:app/src/resources/theme/colors.dart';
import 'package:app/src/screens/calendar_page.dart';
import 'package:app/src/widgets/custom_alert.dart';
import 'package:app/src/widgets/TextInput/text_field.dart';
import 'package:app/src/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => Add();
}

class Add extends State<AddTask> {
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;
  String email = '';
  Isar? isar;
  String title = '';
  String description = '';
  String category = '';
  String sTimeFinal = '';
  String eTimeFinal = '';
  int progress = 10;
  List<Task> tasks = <Task>[];
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String month = DateFormat.yMMMMd('en_US').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    instance();
  }

  void instance() async {
    isar = Isar.getInstance('USER');
    if (isar != null) {
      final us = await isar?.collection<User>().get(1);
      var e = us?.email;
      setState(() {
        email = e!;
      });
    }
  }

  void start(BuildContext context) {
    final AddBloc bloc = BlocProvider.of<AddBloc>(context);
    bloc.add(SaveUser());
  }

  addItem(BuildContext context) async {
    final AddBloc bloc = BlocProvider.of<AddBloc>(context);
    if (title != '' &&
        startTime != endTime &&
        description != '' &&
        category != '' &&
        eTimeFinal != '' &&
        sTimeFinal != '') {
      bloc.add(AddTaskEvent(
          selectedDate: selectedDate,
          sTimeFinal: sTimeFinal,
          eTimeFinal: eTimeFinal,
          title: title,
          description: description,
          email: email,
          category: category,
          progress: progress));
    } else {
      var dialog = CustomAlertDialog(
        icon: Icons.warning,
        title: 'Warning',
        message: 'All fields are required',
        onPositivePressed: () {
          Navigator.of(context).pop();
        },
        positiveBtnText: 'OK',
      );
      showDialog(context: context, builder: (BuildContext context) => dialog);
    }
  }

  void createTask(BuildContext context) {
    addItem(context);
  }

  void sTime(BuildContext context) async {
    TimeOfDay? start =
        await showTimePicker(context: context, initialTime: startTime);
    if (start != null) {
      if (startTime != endTime) {
        setState(() {
          startTime = start;
        });
        if (mounted) {
          String sT = TimeOfDay(hour: startTime.hour, minute: startTime.minute)
              .format(context);
          setState(() {
            sTimeFinal = sT;
          });
        }
      } else {
        setState(() {
          startTime = const TimeOfDay(hour: 00, minute: 00);
        });
      }
    }
  }

  void eTime(BuildContext context) async {
    TimeOfDay? end =
        await showTimePicker(context: context, initialTime: endTime);
    if (end != null) {
      if (endTime != startTime) {
        setState(() {
          endTime = end;
        });
        if (mounted) {
          String eT = TimeOfDay(hour: endTime.hour, minute: endTime.minute)
              .format(context);
          setState(() {
            eTimeFinal = eT;
          });
        }
      } else {
        setState(() {
          endTime = const TimeOfDay(hour: 00, minute: 00);
        });
      }
    }
  }

  void showDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    start(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: LightColors.kLightYellow,
          body: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            color: LightColors.kLightYellow,
            child: SingleChildScrollView(
                child: SizedBox(
              width: width,
              height: height,
              child: Column(
                children: [
                  //Back Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CalendarPage(
                                  email: email,
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 25,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  //Heading
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Create New Task',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  //Header
                  Container(
                    width: width,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: LightColors.kDarkYellow,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Title & Date',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextInput(
                            inputType: TextInputType.text,
                            hint: 'Title',
                            textColor: Colors.black,
                            fontSize: 16,
                            onChanged: (value) {
                              setState(() {
                                title = value;
                              });
                            },
                            expands: false,
                            icon: Icons.title_outlined,
                            iconColor: Colors.blue),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                              controller: TextEditingController()
                                ..text = DateFormat('EEE, d y')
                                    .format(selectedDate)
                                    .toString(),
                              minLines: null,
                              maxLines: null,
                              readOnly: true,
                              onTap: () {
                                showDate(context);
                              },
                              decoration: InputDecoration(
                                labelText: DateFormat.yMMMM('en_US')
                                    .format(selectedDate)
                                    .toString(),
                                prefixIcon:
                                    const Icon(Icons.calendar_month_outlined),
                                prefixIconColor: Colors.blue,
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelStyle: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              )),
                        )
                      ],
                    ),
                  ),
                  // Start And End Time
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                                controller: TextEditingController()
                                  ..text = TimeOfDay(
                                          hour: startTime.hour,
                                          minute: startTime.minute)
                                      .format(context),
                                minLines: null,
                                maxLines: null,
                                readOnly: true,
                                onTap: () {
                                  sTime(context);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Start Time',
                                  prefixIcon:
                                      const Icon(Icons.calendar_month_outlined),
                                  prefixIconColor: Colors.blue,
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  labelStyle: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )),
                          )),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                                controller: TextEditingController()
                                  ..text = TimeOfDay(
                                          hour: endTime.hour,
                                          minute: endTime.minute)
                                      .format(context),
                                minLines: null,
                                maxLines: null,
                                readOnly: true,
                                onTap: () {
                                  eTime(context);
                                },
                                decoration: InputDecoration(
                                  labelText: 'End Time',
                                  prefixIcon:
                                      const Icon(Icons.calendar_month_outlined),
                                  prefixIconColor: Colors.blue,
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  labelStyle: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )),
                          )),
                    ],
                  ),
                  //Description
                  const SizedBox(
                    height: 10,
                  ),
                  TextInput(
                      inputType: TextInputType.text,
                      hint: 'Comment',
                      textColor: Colors.black,
                      fontSize: 16,
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      expands: false,
                      icon: Icons.comment,
                      iconColor: Colors.blue),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Task Progress',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 21)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'Progress: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      progress.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ]),

                  const SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Slider(
                        label: 'Set Progress',
                        value: progress.toDouble(),
                        activeColor: Colors.amber,
                        inactiveColor: Colors.grey,
                        min: 5.0,
                        max: 100.0,
                        onChanged: (value) {
                          setState(() {
                            progress = value.toInt();
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Category',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 21)),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        direction: Axis.horizontal,
                        spacing: 5.0,
                        children: [
                          Button(
                            onPressed: () {
                              setState(() {
                                category = 'Sports App';
                                selected1 = true;
                                selected2 = false;
                                selected3 = false;
                                selected4 = false;
                                selected5 = false;
                              });
                            },
                            title: 'Sports App',
                            color: selected1 ? Colors.deepPurple : Colors.grey,
                            font: 15,
                            paddingH: 10,
                            paddingV: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Button(
                            onPressed: () {
                              setState(() {
                                category = 'Clothing App';
                                selected1 = false;
                                selected2 = true;
                                selected3 = false;
                                selected4 = false;
                                selected5 = false;
                              });
                            },
                            title: 'Clothing App',
                            color: selected2 ? Colors.deepPurple : Colors.grey,
                            font: 15,
                            paddingH: 10,
                            paddingV: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Button(
                            onPressed: () {
                              setState(() {
                                category = 'Health App';
                                selected1 = false;
                                selected2 = false;
                                selected3 = true;
                                selected4 = false;
                                selected5 = false;
                              });
                            },
                            title: 'Health App',
                            color: selected3 ? Colors.deepPurple : Colors.grey,
                            font: 15,
                            paddingH: 10,
                            paddingV: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Button(
                            onPressed: () {
                              setState(() {
                                category = 'Other App';
                                selected1 = false;
                                selected2 = false;
                                selected3 = false;
                                selected4 = true;
                                selected5 = false;
                              });
                            },
                            title: 'Other App',
                            color: selected4 ? Colors.deepPurple : Colors.grey,
                            font: 15,
                            paddingH: 10,
                            paddingV: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Button(
                            onPressed: () {
                              setState(() {
                                category = 'Rent App';
                                selected1 = false;
                                selected2 = false;
                                selected3 = false;
                                selected4 = false;
                                selected5 = true;
                              });
                            },
                            title: 'Rent App',
                            color: selected5 ? Colors.deepPurple : Colors.grey,
                            font: 15,
                            paddingH: 10,
                            paddingV: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.white),
                        )),
                        backgroundColor: MaterialStateProperty.all(
                            title != '' &&
                                    startTime != endTime &&
                                    description != '' &&
                                    category != ''
                                ? LightColors.kDarkBlue
                                : LightColors.kBlue),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(30, 15, 30, 15)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 20)),
                      ),
                      onPressed: () {
                        createTask(context);
                      },
                      child: const Text(
                        'Create Task',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<AddBloc, AddState>(
                    builder: (context, state) {
                      if (state is Success) {
                        Fluttertoast.showToast(
                            msg: "Project Added Successfully",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return Center(
                            child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: const BoxDecoration(
                              color: LightColors.kDarkBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Text(
                            'Task Created Successfully',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ));
                      }
                      if (state is Error) {
                        return Center(
                            child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: const BoxDecoration(
                              color: LightColors.kDarkBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Text(
                            'Error in creating new Task',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ));
                      }
                      if (state is Request) {
                        const Center(
                          child: Text(""),
                        );
                      }
                      return const Center(
                        child: Text(""),
                      );
                    },
                  )
                ],
              ),
            )),
          )),
    );
  }
}
