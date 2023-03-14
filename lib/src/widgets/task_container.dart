import 'package:app/src/resources/theme/colors.dart';
import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer(
      {super.key,
      required this.title,
      required this.description,
      required this.startTime,
      required this.endTime,
      required this.delete,
      required this.edit,
      required this.tagDelete,
      required this.tagEdit});
  final String? title;
  final String? description;
  final String? startTime;
  final String? endTime;
  final VoidCallback delete;
  final VoidCallback edit;
  final String tagDelete;
  final String tagEdit;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: LightColors.kDarkBlue,
              borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          startTime!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            'to',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Text(
                          endTime!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  )),
              Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: SizedBox(
                      width: 2,
                      child: Text(
                        '||||',
                        style: TextStyle(color: Colors.white, letterSpacing: 1),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title == null ? 'Project A' : title.toString(),
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          description == null
                              ? 'Description'
                              : description.toString(),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 35,
                  width: 35,
                  child: FloatingActionButton(
                    heroTag: tagDelete,
                    onPressed: delete,
                    backgroundColor: Colors.grey,
                    child: const Icon(Icons.delete),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 35,
                  width: 35,
                  child: FloatingActionButton(
                    heroTag: tagEdit,
                    onPressed: edit,
                    backgroundColor: Colors.grey,
                    child: const Icon(Icons.edit),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
