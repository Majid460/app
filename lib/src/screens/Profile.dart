import 'package:app/src/screens/UpdateProfile.dart';
import 'package:flutter/material.dart';
import 'package:app/src/widgets/Drawer/SideDrawer.dart';
import  'package:app/src/widgets/buttons/CustomButton.dart';

import '../models/person_model.dart';
class Profile extends StatelessWidget{
  const Profile({super.key,required this.person});
  final Person person;

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
    appBar: AppBar(
     leading:Builder(builder:(context)=>IconButton(onPressed: () {
      Scaffold.of(context).openDrawer();
     }, icon: const Icon(Icons.menu),tooltip: 'Drawer',)) ,
    title: const Text('Profile'),automaticallyImplyLeading: false,),
      drawer: const SideDrawer(),
      body:  SingleChildScrollView(child: Column(
        children:  <Widget>[
         Padding(padding:const EdgeInsets.all(10.0),
         //Top Container
         child:Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
           child: Row(children: <Widget>[
             Container(padding: const EdgeInsets.all(1), 
             decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(48)),width: 80,height: 80,
             child: CircleAvatar(radius: 48,backgroundColor: Colors.transparent,child:Image.asset('lib/src/resources/assets/images/driver.png') ,),
             ),
             const SizedBox(width: 10,height: 50),
              Expanded(child: Text(person.name.isNotEmpty?person.name:'Your Name',style: const TextStyle(fontSize: 25,color: Colors.white),))
             ]
            ),
           )
          ),
    
         // Bottom Container
         const Align(
           alignment: Alignment.topLeft,
           child: Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),child: SizedBox(width: 60,height: 20,child:  Text('Email',style: TextStyle(fontSize: 20,color: Colors.grey),),),)
           ),
         Padding(padding: const EdgeInsets.all(10.0),
           child:Container(padding: const EdgeInsets.all(20.0),decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10))
           ,child: Row(children:  <Widget>[
            const Icon(Icons.email,color: Colors.white,),
           const SizedBox(width: 10,),
            Expanded(child:
            Text(person.email.isNotEmpty?person.email:'ABC@gmail.com',style: const TextStyle(color: Colors.white,fontSize: 20),)
           ),
           ],),
          ) ,
          ),
          //Other Container
          const Align(
           alignment: Alignment.topLeft,
           child: Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),child: SizedBox(width: 60,height: 20,
           child:  Text('Phone',style: TextStyle(fontSize: 20,color: Colors.grey),),),)
           ),
         Padding(padding: const EdgeInsets.all(10.0),
           child:Container(padding: const EdgeInsets.all(20.0),decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10))
           ,child: Row(children:  <Widget>[
           const Icon(Icons.phone,color: Colors.white,),
            const SizedBox(width: 10,),
            Expanded(child:
            Text(person.phone.isNotEmpty ?person.phone: '03XXXXXXX',style: const TextStyle(color: Colors.white,fontSize: 20),)
           ),
           ],),
          ) ,
          ),
          //Update Profile Button
           const SizedBox(height: 20,),
          Center(child: 
          Button(onPressed: () { 
              Navigator.push(context, MaterialPageRoute(
            builder: (context) => UpdateProfile(person: person,),),);
          }, title: 'Update Profile', color: Colors.blue, font: 15),)
          
        ],
      ),
      ),
       bottomNavigationBar:BottomAppBar (
          notchMargin: 4,
          clipBehavior: Clip.antiAlias,
          color: Colors.blue,
        shape: const CircularNotchedRectangle(),
        child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            Expanded(flex: 1,child:IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            ),
            Expanded(flex:1,child: IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),),
           Expanded(flex:2,child: IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),),
            
          ],
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

}