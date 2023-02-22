import 'package:app/src/blocs/Register_bloc/Register_state.dart';
import 'package:app/src/blocs/Register_bloc/Register_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent,SignUpState>{
 
  final firebase=FirebaseAuth.instance;
  final firebaseStore=FirebaseFirestore.instance;
  
  SignUpBloc():super(LoadingUser()){
    on<SaveUser>((event, emit) async{

    });
    on<RegisterEvent>((event, emit) async{
       try {
       final credential = await firebase.createUserWithEmailAndPassword(
         email: event.email,
         password: event.password,
            );
            if(credential.user!=null){
           emit(Success(email: credential.user!.email));
           DocumentReference users=FirebaseFirestore.instance.collection('user').doc(event.email);
           await users.set ({
              'name':event.name,
              'email':event.email,
               'phone':event.phone
             }).then((value) {
              print('User Added');
             }).catchError((error){ print('failed to add: $error');});
             
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