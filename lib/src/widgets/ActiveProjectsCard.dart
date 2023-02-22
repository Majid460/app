import 'package:app/src/resources/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ActiveProjectsCard extends StatelessWidget{
  const ActiveProjectsCard ({super.key,required this.cardColor,required this.cardTitle,required this.cardSubtitle,required this.cardPercent});
  final Color cardColor;
  final String cardTitle;
  final String cardSubtitle;
  final double cardPercent;
  @override
  Widget build(BuildContext context) {
   return Expanded(
    flex: 1,
    child: Container(margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: cardColor,borderRadius: BorderRadius.circular(20.0),),
    child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
          Padding(padding: const EdgeInsets.all(15),
          child: CircularPercentIndicator(
            radius: 60
          ,percent: cardPercent,
          circularStrokeCap: CircularStrokeCap.round,
          lineWidth: 5.0,
          backgroundColor: Colors.white10,
          progressColor: Colors.white,
          animation: true,
          center: Text(
          '${(cardPercent*100).round()}%',
                  style:const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),),
              
          )),
           Align(alignment: Alignment.center,child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  cardTitle,
                  style:const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  cardSubtitle,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          ],
    ),)
    );
  }}