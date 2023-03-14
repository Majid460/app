import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Task {
  String? month = '';

  int? year = 2023;

  String? date = '';

  String? day = '';

  String? startTime = '01:00 PM';

  String? endTime = '02:00 PM';

  String? title = '';

  String? description = '';

  Task(
      {required description,
      required title,
      required month,
      required year,
      required date,
      required day,
      required startTime,
      required endTime});
  Task.named(this.title, this.description, this.date, this.month, this.day,
      this.year, this.startTime, this.endTime);
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      month: json['month'],
      year: json['year'],
      date: json['date'],
      day: json['day'],
      startTime: json['startTimeH'],
      endTime: json['endTimeH'],
    );
  }
}
