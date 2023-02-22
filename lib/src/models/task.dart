import 'package:hive/hive.dart';
@HiveType(typeId: 0)
class Task {

  String? month='';

  int? year=2023;
  
  String? date='';
  
  String? day='';
  
  String? startTimeH='01:00 PM';
 
  String? endTimeH='02:00 PM';
  
  String? title='';

  String? description='';

  Task();
  Task.named(this.title,this.description, this.date,this.month,this.day,this.year,this.startTimeH,this.endTimeH);

}