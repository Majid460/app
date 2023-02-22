import 'package:app/src/blocs/login_bloc/login_event.dart';
import 'package:app/src/blocs/login_bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  
  LoginBloc():super(LoadingUser()){
    on<SaveUser>((event, emit) async{

    });
    on<VerifyEvent>((event, emit) async{
       try {
       UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email, password: event.password);
       if(result.user!=null){
        emit(Success(email: result.user!.email));
       }
    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        emit(EmailNotExist());
      } else if (e.code == 'wrong-password') {
       emit(PasswordNotMatch());
 }
}
});
 }
}
