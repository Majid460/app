import 'package:flutter/material.dart';
import 'package:app/src/models/person_model.dart';
import 'package:app/src/widgets/buttons/CustomButton.dart';
import 'package:app/src/widgets/TextInput/TextInputField.dart';
import 'package:app/src/screens/Profile.dart';

class UpdateProfile extends StatefulWidget{
  const UpdateProfile({super.key,required this.person});
  final Person person;
  @override
  State<UpdateProfile> createState() => _UpdateProfile();

}
class _UpdateProfile extends State<UpdateProfile>{
    String pName='';
    String pPhone='03XXXXXXXX';
    String pEmail='';
  @override
  Widget build(BuildContext context) {
    
   void updateData()
   {
    if(pName.isNotEmpty && pEmail.isNotEmpty && pPhone.isNotEmpty)
    {
     Person p= Person.name(pName, pEmail, pPhone);
     Navigator.push(context, MaterialPageRoute(
            builder: (context) => Profile(person: p,),),);
   
    }
    else{
      }
   }
   return Scaffold(
    //App Bar
    appBar: AppBar(
     leading:Builder(builder:(context)=>IconButton(onPressed: () {Navigator.pushReplacementNamed(context, '/profile');
     }, icon: const Icon(Icons.arrow_back_ios),tooltip: 'back',)) ,
    title: const Text('Update Profile'),automaticallyImplyLeading: false,),
   //Body
   body: SingleChildScrollView(
    child: Column(children: [
      //Name
      const SizedBox(height: 10,),
         Padding(padding: const EdgeInsets.all(10.0),
           child: Row(children:  <Widget>[
            Expanded(child:
           TextInput(hint: widget.person.name.isNotEmpty ?widget.person.name :'Your Name', textColor: Colors.grey, fontSize: 16, onChanged: (value){setState(() {
             pName=value;
           });},expands: false,icon:Icons.person_rounded,iconColor: Colors.blue,),
           ),
           ],),
          ),
      // Email
       const SizedBox(height: 10,),
         Padding(padding: const EdgeInsets.all(10.0),
           child: Row(children:  <Widget>[
            Expanded(child:
           TextInput(hint: widget.person.email.isNotEmpty ?widget.person.email :'ABC@gmail.com', textColor: Colors.grey, fontSize: 16, onChanged: (value){setState(() => pEmail=value);},expands: false,icon:Icons.email,iconColor: Colors.blue,),
           ),
           ],),
          ),
          // Phone
      const SizedBox(height: 10,),
         Padding(padding: const EdgeInsets.all(10.0),
           child: Row(children:  <Widget>[
            Expanded(child:
           TextInput(hint: widget.person.phone.isNotEmpty ? widget.person.phone:'03XXXXXXX', textColor: Colors.grey, fontSize: 16, onChanged: (value){setState(() => pPhone=value);},expands: false,icon:Icons.phone,iconColor: Colors.blue,),
           ),
           ],),
          ),
       const SizedBox(height: 20,),
          Center(child: 
          Button(onPressed: () {updateData();}, title: 'Save', color: Colors.blue, font: 16,paddingH: 0,paddingV: 0,),)
          

    ]),
   ),
  
   );
  }

}