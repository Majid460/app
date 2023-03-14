import 'package:app/src/blocs/profile_bloc/profile_event.dart';
import 'package:app/src/blocs/profile_bloc/profile_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileStateUpdate> {
  final firebase = FirebaseAuth.instance;
  final firebaseStore = FirebaseFirestore.instance;

  ProfileBloc() : super(LoadingUser()) {
    on<SaveUser>((event, emit) async {
      emit(Request());
    });
    on<UpdateEvent>((event, emit) async {
      try {
        print(event.phone);
        DocumentReference users =
            FirebaseFirestore.instance.collection('user').doc(event.email);
        await users.update(
          {
            'email': event.email,
            'name': event.name,
            'phone': event.phone,
          },
        ).then((value) {
          emit(Success());
        }).catchError((error) {
          print('ERROR $error');
          emit(Error(error: error.toString()));
        });
      } on Exception catch (e) {
        emit(Error(error: e.toString()));
      }
    });
  }
}
