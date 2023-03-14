import 'package:app/src/blocs/register_bloc/register_state.dart';
import 'package:app/src/blocs/register_bloc/register_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final firebase = FirebaseAuth.instance;
  final firebaseStore = FirebaseFirestore.instance;

  SignUpBloc() : super(LoadingUser()) {
    on<SaveUser>((event, emit) async {});
    on<RegisterEvent>((event, emit) async {
      try {
        final credential = await firebase.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        if (credential.user != null) {
          emit(Success(email: credential.user!.email));
          DocumentReference users =
              FirebaseFirestore.instance.collection('user').doc(event.email);
          await users
              .set({
                'name': event.name,
                'email': event.email,
                'phone': event.phone
              })
              .then((value) {})
              .catchError((error) {
                emit(Error());
              });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(WeakPassword());
        } else if (e.code == 'email-already-in-use') {
          emit(EmailInUse());
        }
      } catch (e) {
        emit(Error());
      }
    });
  }
}
