import 'package:app/src/blocs/login_bloc/login_bloc.dart';
import 'package:app/src/blocs/login_bloc/login_event.dart';
import 'package:app/src/blocs/login_bloc/login_state.dart';
import 'package:app/src/models/user.dart';
import 'package:app/src/resources/theme/colors.dart';
import 'package:app/src/screens/home.dart';
import 'package:app/src/widgets/CustomAlert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

import '../widgets/TextInput/TextInputField.dart';
import '../widgets/buttons/CustomButton.dart';

class Login extends StatefulWidget{
  const Login({super.key});
  @override
  State<Login> createState() =>_Login();
}
class _Login extends State<Login>{
  
    String email='';
    String password='';
    bool pressed=false;
    Isar? isar;
    @override
  void initState(){
    super.initState();
    instance();
   
  }
  void instance()async {
    isar = await Isar.open(name:'USER',[UserSchema]);
  }
    bool validateEmail(String value) {
     RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return (!regex.hasMatch(value)) ? false : true;
    }
    void validate(BuildContext context) async{
      final LoginBloc bloc=BlocProvider.of<LoginBloc>(context);
      if(email==''){
         setState(() {
            pressed=false;
          });
         var dialog=CustomAlertDialog(icon: Icons.warning,title: 'Warning',message: 'Email is required', onPositivePressed: (){ Navigator.of(context).pop(); }, positiveBtnText: 'OK',);
          showDialog(context: context, builder: (BuildContext context) => dialog);
      }
      else if(password==''){
         setState(() {
            pressed=false;
          });
        var dialog=CustomAlertDialog(icon: Icons.warning,title: 'Warning',message: 'Password is required', onPositivePressed: (){ Navigator.of(context).pop(); }, positiveBtnText: 'OK',);
          showDialog(context: context, builder: (BuildContext context) => dialog);
      }
      else if(email!=''&&password!=''){
      if(validateEmail(email)==true ){
          bloc.add(VerifyEvent(email: email, password: password));
         
           Future.delayed(const Duration(milliseconds:3000),(){
             if(mounted){
            setState(() {
            pressed=false;
          });
             }
         });
          //
          } 
      else {
        var dialog=CustomAlertDialog(icon: Icons.warning,title: 'Warning',message: 'Please check the formate of email', onPositivePressed: (){ Navigator.of(context).pop(); }, positiveBtnText: 'OK',);
          showDialog(context: context, builder: (BuildContext context) => dialog);
        
      }
      }
      else{
        var dialog=CustomAlertDialog(icon: Icons.warning,title: 'Warning',message: 'All Fields are required please fill them', onPositivePressed: (){ Navigator.of(context).pop(); }, positiveBtnText: 'OK',);
          showDialog(context: context, builder: (BuildContext context) => dialog);
        
      }
     
    } 
    void saveInIsar(String e,BuildContext context) async{
     final user=User()
     ..id=1
     ..email=e;
     await isar?.writeTxn(() async{
      await isar?.collection<User>().put(user);
       if(mounted){
       Navigator.pushReplacementNamed(context, '/home');
       }
     });
    }
    @override
  void dispose() {
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(child: 
    Scaffold(
    //App Bar
     appBar: AppBar(
      backgroundColor: LightColors.kDarkBlue,
     title: const Text('Login'),automaticallyImplyLeading: false,),
   //Body
    body: Align(alignment:Alignment.center ,
    child:  Container( width: width,
          
         constraints: BoxConstraints(
           maxHeight: MediaQuery.of(context).size.height * .60
         ),
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          decoration: BoxDecoration(color: LightColors.kDarkBlue,borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [

        const SizedBox(height: 10,),
        const Center(child: Text('Welcome Back',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w800),),),
         const Center(child: Text('Login to continue',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),),
      // Email
       const SizedBox(height: 20,),
         Padding(padding: const EdgeInsets.all(10.0),
           child: Row(children:  <Widget>[
            Expanded(child:
           TextInput(hint:'ABC@gmail.com', textColor: Colors.white, fontSize: 16, onChanged: (value){setState(() => email=value);},expands: false,icon:Icons.email,iconColor: Colors.blue,),
           ),
           ],),
          ),
          // Phone
      const SizedBox(height: 10,),
        Padding(padding: const EdgeInsets.all(10.0),
           child: Row(children:  <Widget>[
             Expanded(child:
                Container(
                     padding: const EdgeInsets.symmetric(horizontal: 10),
                     child:  TextField(
                      obscureText: true,
                      onChanged: (value) {
                      setState(() {
                        password=value;
                      });
                    },
                    style: const TextStyle(color:Colors.white),
                     decoration: InputDecoration(labelText: 'Password',prefixIcon:const Icon(Icons.lock),prefixIconColor: Colors.blue ,alignLabelWithHint: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                     labelStyle: const TextStyle(fontSize: 16,color: Colors.grey),
                    )
                     ),
                   )
           ),
           ],),
          ),
          
         const SizedBox(height: 10,),
          Center(child:  Container(child: 
           !pressed?
           Button(onPressed: () {setState(() {
             pressed=true;
           },);validate(context);}, title: 'Login', color: Colors.green, font: 18,paddingH: 40,paddingV: 15,)
            : const SizedBox(width: 60,height: 60,child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.red),backgroundColor: Colors.amber,)))
          ),
           const SizedBox(height: 17,),
          Center(child: 
          Button(onPressed: () {Navigator.pushReplacementNamed(context, '/signUp');}, title: 'CREATE ACCOUNT', color: Colors.green, font: 16,paddingH: 30,paddingV: 10,),),
          
          BlocConsumer<LoginBloc,LoginState>(
            builder: (context,state){
            if(state is Success){
            return Center(child:Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: const BoxDecoration(color: LightColors.kDarkBlue,borderRadius: BorderRadius.all(Radius.circular(10))),
            child:const Text('Login Successfully',style: TextStyle(color: Colors.white,fontSize: 17),),
           ));
            }
            if(state is EmailNotExist){
             return  Center(child:Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: const BoxDecoration(color: LightColors.kDarkBlue,borderRadius: BorderRadius.all(Radius.circular(10))),
            child:const Text('Email not exists',style: TextStyle(color: Colors.white,fontSize: 17),),
           ));
            }
            if(state is PasswordNotMatch){
            return  Center(child:Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: const BoxDecoration(color: LightColors.kDarkBlue,borderRadius: BorderRadius.all(Radius.circular(10))),
            child:const Text('Wrong Password',style: TextStyle(color: Colors.white,fontSize: 17),),
           ));
            }
            if(state is Error){
              return  Center(child:Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: const BoxDecoration(color: LightColors.kDarkBlue,borderRadius: BorderRadius.all(Radius.circular(10))),
              child:const Text('Error while login',style: TextStyle(color: Colors.white,fontSize: 17),),
           ));
            }
           return const Text('');
          },
           listener:(context,state){
            if(state is Success){
                saveInIsar(state.email!,context);
             
              
            }
           }
          )

    ]),
          ),)
   
  
  )
    );
  }

}
