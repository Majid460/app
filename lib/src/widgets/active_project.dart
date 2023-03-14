import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ActiveProjectsCard extends StatelessWidget {
  const ActiveProjectsCard(
      {super.key,
      required this.cardColor,
      required this.cardTitle,
      required this.cardSubtitle,
      required this.cardPercent});
  final Color cardColor;
  final String cardTitle;
  final String cardSubtitle;
  final int cardPercent;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: CircularPercentIndicator(
                      radius: 60,
                      percent: cardPercent / 100,
                      circularStrokeCap: CircularStrokeCap.round,
                      lineWidth: 5.0,
                      backgroundColor: Colors.white10,
                      progressColor: Colors.white,
                      animation: true,
                      center: Text(
                        '${(cardPercent).round()}%',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        cardTitle,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        cardSubtitle,
                        textAlign: TextAlign.justify,
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
            ),
          ),
        ));
  }
}
