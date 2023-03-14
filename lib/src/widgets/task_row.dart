import 'package:flutter/material.dart';

import '../resources/theme/colors.dart';

class TaskRow extends StatelessWidget{
  const TaskRow({super.key,required this.icon,required this.taskTitle,required this.taskDescription,required this.taskIconColor});
  final IconData icon;
  final String taskTitle;
  final String taskDescription;
  final Color taskIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
                    CircleAvatar(
                    radius: 25.0,backgroundColor: taskIconColor,
                    child: Icon(icon,size: 29.0,
                    color: Colors.white,)),
                    Expanded(child: Column(
                    mainAxisAlignment:MainAxisAlignment.center ,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child:    Text(taskTitle,style:const TextStyle(fontSize: 16,color: LightColors.kDarkBlue,fontWeight: FontWeight.w800),textAlign: TextAlign.start,),),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:  Text(taskDescription,style:const TextStyle(fontSize: 13,color: Colors.black87,fontWeight: FontWeight.w400),textAlign: TextAlign.start),)
                    ],)),
        ],
      ),
    );
  }}