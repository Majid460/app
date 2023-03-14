import 'package:app/src/blocs/add_task_bloc/add_event.dart';
import 'package:app/src/blocs/add_task_bloc/add_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final firebase = FirebaseAuth.instance;
  final firebaseStore = FirebaseFirestore.instance;

  AddBloc() : super(LoadingData()) {
    on<SaveUser>((event, emit) async {
      emit(Request());
    });
    on<AddTaskEvent>((event, emit) async {
      try {
        String date = DateFormat('d').format(event.selectedDate).toString();
        String month =
            DateFormat.M('en_US').format(event.selectedDate).toString();
        String day = DateFormat('EEE').format(event.selectedDate).toString();
        String year = DateFormat('y').format(event.selectedDate).toString();
        var y = int.parse(year);
        DocumentReference users = FirebaseFirestore.instance
            .collection('projects')
            .doc(event.email)
            .collection('project')
            .doc(event.title);
        await users.set(
          {
            'title': event.title,
            'description': event.description,
            'date': date,
            'month': month,
            'day': day,
            'year': y,
            'category': event.category,
            'startTime': event.sTimeFinal,
            'endTime': event.eTimeFinal,
            'progress': event.progress,
          },
        ).then((value) {
          emit(const Success(status: 'Project Added Successfully'));
        }).catchError((error) {
          emit(Error(error: error.toString()));
        });
      } on Exception catch (e) {
        emit(Error(error: e.toString()));
      }
    });
    on<UpdateTaskEvent>((event, emit) async {
      try {
        String date = DateFormat('d').format(event.selectedDate).toString();
        String month =
            DateFormat.M('en_US').format(event.selectedDate).toString();
        String day = DateFormat('EEE').format(event.selectedDate).toString();
        String year = DateFormat('y').format(event.selectedDate).toString();
        var y = int.parse(year);
        DocumentReference users = FirebaseFirestore.instance
            .collection('projects')
            .doc(event.email)
            .collection('project')
            .doc(event.title);
        await users.update(
          {
            'title': event.title,
            'description': event.description,
            'date': date,
            'month': month,
            'day': day,
            'year': y,
            'category': event.category,
            'startTime': event.sTimeFinal,
            'endTime': event.eTimeFinal,
            'progress': event.progress,
          },
        ).then((value) {
          emit(const Success(status: 'Project Updated Successfully'));
        }).catchError((error) {
          emit(Error(error: error.toString()));
        });
      } on Exception catch (e) {
        emit(Error(error: e.toString()));
      }
    });
  }
}
