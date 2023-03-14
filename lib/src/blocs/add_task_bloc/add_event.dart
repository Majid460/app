import 'package:equatable/equatable.dart';

abstract class AddEvent extends Equatable {
  const AddEvent();
  @override
  List<Object> get props => [];
}

class SaveUser extends AddEvent {}

class AddTaskEvent extends AddEvent {
  final DateTime selectedDate;
  final String sTimeFinal;
  final String eTimeFinal;
  final String title;
  final String description;
  final String email;
  final String category;
  final int progress;
  const AddTaskEvent(
      {required this.selectedDate,
      required this.sTimeFinal,
      required this.eTimeFinal,
      required this.title,
      required this.description,
      required this.email,
      required this.category,
      required this.progress});
}

class UpdateTaskEvent extends AddEvent {
  final DateTime selectedDate;
  final String sTimeFinal;
  final String eTimeFinal;
  final String title;
  final String description;
  final String email;
  final String category;
  final int progress;
  const UpdateTaskEvent(
      {required this.selectedDate,
      required this.sTimeFinal,
      required this.eTimeFinal,
      required this.title,
      required this.description,
      required this.email,
      required this.category,
      required this.progress});
}
