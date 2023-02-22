import 'package:app/src/blocs/Register_bloc/Register_bloc.dart';
import 'package:app/src/blocs/Register_bloc/Register_event.dart';
import 'package:app/src/blocs/Register_bloc/Register_state.dart';
import 'package:app/src/resources/theme/colors.dart';
import 'package:app/src/widgets/CustomAlert.dart';
import 'package:app/src/widgets/buttons/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/TextInput/TextInputField.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUp();

}
class _SignUp extends State<SignUp>{
    String name='';
    String password='';
    String email='';
    String phone='';
    String confirmPassword='';
    bool pressed=false;
    void validate(BuildContext context){
       final SignUpBloc bloc=BlocProvider.of<SignUpBloc>(context);
      if(name!='' && password!=''&&confirmPassword!=''&& email!=''&&phone!=''){
       if(validateEmail(email)==true)
       {
        if(password.length>=6 && confirmPassword.length>=6 && confirmPassword==password)
        {
         
         bloc.add(RegisterEvent(email: email, password: password,name: name,phone: phone));
         Future.delayed(const Duration(milliseconds:3000),(){
         setState(() {
            pressed=false;
          });
         });
        }
        else{
          setState(() {
            pressed=false;
          });
          var dialog=CustomAlertDialog(icon: Icons.warning,title: 'Warning',message: 'Passwords must match and length must be 6 or more', onPositivePressed: (){ Navigator.of(context).pop(); }, positiveBtnText: 'OK',);
          showDialog(context: context, builder: (BuildContext context) => dialog);
        }
       }
       else{
        setState(() {
            pressed=false;
          });
         var dialog=CustomAlertDialog(icon: Icons.warning,title: 'Warning',message: 'Please check the formate of email', onPositivePressed: (){ Navigator.of(context).pop(); }, positiveBtnText: 'OK',);
          showDialog(context: context, builder: (BuildContext context) => dialog);
        
       }
      }
      else{
        setState(() {
            pressed=false;
          });
         var dialog=CustomAlertDialog(icon: Icons.warning,title: 'Warning',message: 'All Fields are required please fill them', onPositivePressed: (){ Navigator.of(context).pop(); }, positiveBtnText: 'OK',);
          showDialog(context: context, builder: (BuildContext context) => dialog);
        
      }
    }
    bool validateEmail(String value) {
     RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return (!regex.hasMatch(value)) ? false : true;
    }
    
 
  @override
  Widget build(BuildContext context) {
   
  return SafeArea(child: 
 Scaffold(
    //App Bar
    appBar: AppBar(
      backgroundColor: LightColors.kDarkBlue,
     leading:Builder(builder:(context)=>IconButton(onPressed: () {Navigator.pushReplacementNamed(context, '/login');}, icon: const Icon(Icons.arrow_back_ios),tooltip: 'back',)) ,
    title: const Text('Sign up'),automaticallyImplyLeading: false,),
   //Body
   body: SingleChildScrollView(
    child: Column(children: [
      const SizedBox(height: 50,),
      const Center(child: Text('Create Account',style: TextStyle(color: Colors.black,fontSize: 22),),),
      //Name
      const SizedBox(height: 10,),
         Padding(padding: const EdgeInsets.all(10.0),
           child: Row(children:  <Widget>[
            Expanded(child:
           TextInput(hint: 'Your Name', textColor: Colors.black, fontSize: 16, onChanged: (value){setState(() {
             name=value;
           });},expands: false,icon:Icons.person_rounded,iconColor: Colors.blue,),
           ),
           ],),
          ),
      // Email
       const SizedBox(height: 10,),
         Padding(padding: const EdgeInsets.all(10.0),
           child: Row(children:  <Widget>[
            Expanded(child:
           TextInput(hint:'ABC@gmail.com', textColor: Colors.black, fontSize: 16, onChanged: (value){setState(() => email=value);},expands: false,icon:Icons.email,iconColor: Colors.blue,),
           ),
           ],),
          ),
          // Phone
      const SizedBox(height: 10,),
         Padding(padding: const EdgeInsets.all(10.0),
           child: Row(children:  <Widget>[
            Expanded(child:
           TextInput(hint: '03XXXXXXX', textColor: Colors.black, fontSize: 16, onChanged: (value){setState(() => phone=value);},expands: false,icon:Icons.phone,iconColor: Colors.blue,),
           ),
           ],),
          ),
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
                    style: const TextStyle(color: Colors.black),
                     decoration: InputDecoration(labelText: 'Password',prefixIcon:const Icon(Icons.lock),prefixIconColor: Colors.blue ,alignLabelWithHint: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                     labelStyle: const TextStyle(fontSize: 16,color: Colors.grey),
                    )
                     ),
                   )
           ),
           ],),
          ),
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
                        confirmPassword=value;
                      });
                    },
                     style: const TextStyle(color: Colors.black),
                     decoration: InputDecoration(labelText: 'Confirm Password',prefixIcon:const Icon(Icons.lock),prefixIconColor: Colors.blue ,alignLabelWithHint: true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                     labelStyle: const TextStyle(fontSize: 16,color: Colors.grey),
                    )
                     ),
                   )
           ),
           ],),
          ),
       const SizedBox(height: 20,),
          Center(child:
          Container(child: 
           !pressed?
            Button(onPressed: () {
            setState(() {
              pressed=true;
            });
            validate(context);}, title: 'Register', color: Colors.green, font: 18,paddingH: 60,paddingV: 15,)
            : const SizedBox(width: 60,height: 60,child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.red),backgroundColor: Colors.amber,)))
        ),
      const SizedBox(height: 20,),
      BlocBuilder<SignUpBloc,SignUpState>(
        builder: (context,state) {
          if(state is EmailInUse){
           return  Center(child:Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: const BoxDecoration(color: LightColors.kDarkBlue,borderRadius: BorderRadius.all(Radius.circular(10))),
            child:const Text('Email already in use',style: TextStyle(color: Colors.white,fontSize: 17),),
           ));
          }
          if( state is WeakPassword){
            return Center(child:Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: const BoxDecoration(color: LightColors.kDarkBlue,borderRadius: BorderRadius.all(Radius.circular(10))),
            child:const Text('Week password',style: TextStyle(color: Colors.white,fontSize: 17),),
           ));
          }
          if(state is Error){
            return Center(child:Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: const BoxDecoration(color: LightColors.kDarkBlue,borderRadius: BorderRadius.all(Radius.circular(10))),
            child:const Text('Error in creating user',style: TextStyle(color: Colors.white,fontSize: 17),),
           ));
          }
          if(state is Success){
         return Center(child:Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: const BoxDecoration(color: LightColors.kDarkBlue,borderRadius: BorderRadius.all(Radius.circular(10))),
            child:const Text('User Created Successfully',style: TextStyle(color: Colors.white,fontSize: 17),),
           ));
          }
         return const Center(child: Text(""),);
        }
        
        )

    ]),
   ),
  
  )
  );
  }

}