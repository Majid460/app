import 'package:app/src/models/user.dart';
import 'package:app/src/resources/theme/colors.dart';
import 'package:app/src/widgets/ActiveProjectsCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/src/widgets/bottomNavigation/BottomBar.dart';
import 'package:app/src/widgets/Drawer/SideDrawer.dart';
import 'package:app/src/widgets/TaskRow.dart';
import 'package:isar/isar.dart';
class HomePage extends StatefulWidget{
   const HomePage({super.key});
  @override
  State createState() => _BottomAppBarPage();
  
}
class _BottomAppBarPage extends State<HomePage>{

   bool _showNotch=true;
   bool _showFab=true;
   String name=''; 
   Isar? isar;
   String email='';
  FloatingActionButtonLocation _fabLocation=FloatingActionButtonLocation.centerDocked;
   void instance()async {
    isar = await Isar.getInstance('USER');
     print(Isar.instanceNames);
      final us=await isar?.collection<User>().get(1);
      var e=us?.email;
      setState(() {
        email=e!;
      });
      fetchIsar();
  }
  void onShowNotchChanged(bool value)
  {
    setState(() {
      _showNotch=value;
    });
  }
  void onShowFabChanged(bool value)
  {
    setState(() {
      _showFab=value;
    });
  }
  void onFabLocationChange(FloatingActionButtonLocation? value)
  {
    setState(() {
      _fabLocation= value ?? FloatingActionButtonLocation.centerDocked;
    });
  }
 void fetchIsar() async{
     print("Email $email");
      final docRef = FirebaseFirestore.instance.collection('user').doc(email);
      docRef.get().then(
     (DocumentSnapshot doc) {
     final data = doc.data() as Map<String, dynamic>;
     setState(() {
       name=data['name'];
     });
    }, onError: (e) => print("Error getting document: $e"),);
 }
  @override
  void initState() {
    instance();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   return SafeArea(
      child: Scaffold(
        backgroundColor: LightColors.kLightYellow,
        body: Builder(builder: (BuildContext context) {
          return Column(
        children: <Widget>[
         Container( height: 200,width: width,padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0), 
         decoration: const BoxDecoration(
            color: LightColors.kDarkYellow,
            borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: () {
                Scaffold.of(context).openDrawer();
              },child: const Icon(Icons.menu,color: LightColors.kDarkBlue,size: 30,),),
            
            const Icon(Icons.search,color:LightColors.kDarkBlue,size: 25,),],),
              //Profile
              Expanded(
                child: Container(margin: const  EdgeInsets.fromLTRB(0, 10, 0, 10),alignment: Alignment.center,
                child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                      const CircleAvatar(backgroundColor: Colors.blue,radius: 35.0,backgroundImage: AssetImage('lib/src/resources/assets/images/avatar.png', ),),
                            // Name
                           const SizedBox(width: 10,),
                           Expanded(child: Column(mainAxisAlignment:MainAxisAlignment.center ,crossAxisAlignment: CrossAxisAlignment.start,
                           children:  [Container(padding: const EdgeInsets.symmetric(horizontal: 10),
                           child:    Text(name,style:const TextStyle(fontSize: 20,color: LightColors.kDarkBlue,fontWeight: FontWeight.w800),textAlign: TextAlign.start,),),
                           Container(padding: const EdgeInsets.symmetric(horizontal: 10),
                           child:  Text('App Developer',style:TextStyle(fontSize: 16,color: Colors.grey.shade800,fontWeight: FontWeight.w400),textAlign: TextAlign.start),)
                         ],)
                        ),
                ],),
                )
              ),
              ], 
          ) ,
         ),
         //Bottom My Tasks
          
          Expanded(
            child: SingleChildScrollView(
            child: Column(children: [
              //My Task
              Container(color: Colors.transparent,padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
                     children:  [
                     const Text('My Tasks',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),),
                     GestureDetector(onTap: () {
                      Navigator.pushReplacementNamed(context, '/calenderPage');
                     },child:const CircleAvatar(
                      radius: 25.0,backgroundColor: LightColors.kGreen,
                      child: Icon(Icons.calendar_month_outlined, size: 25.0,color: Colors.white,)) ,),
              ],),
              ),
              // List of Tasks

             const TaskRow(icon: Icons.timer_sharp, taskTitle: 'To Do ', taskDescription: '5 Tasks Now ',taskIconColor:LightColors.kGreen),
              const TaskRow(icon: Icons.blur_circular_outlined, taskTitle: 'In Progress ', taskDescription: '5 Tasks Now and 1 Started',taskIconColor:LightColors.kDarkYellow),
               const TaskRow(icon: Icons.done, taskTitle: 'Completed ', taskDescription: '5 Tasks ',taskIconColor:LightColors.kBlue),
             //Bottom Container
             Container(color: Colors.transparent,padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
             child:Column(crossAxisAlignment: CrossAxisAlignment.start,
             children:  [
             const  Align(alignment: Alignment.topLeft,
              child: Text('Active Projects',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700),),),
           
             Row(children: const [
             ActiveProjectsCard(cardColor: LightColors.kDarkBlue, cardTitle: 'Flutter App', 
             cardSubtitle: '9 Hour Progress', cardPercent: 0.25),
             ActiveProjectsCard(cardColor: LightColors.kDarkBlue, cardTitle: 'Delivery App', 
             cardSubtitle: '100 Hour work progress ', cardPercent: 0.75),
             ],),
            Row(children: const [
             ActiveProjectsCard(cardColor: LightColors.kDarkBlue, cardTitle: 'Flutter App', 
             cardSubtitle: '9 Hour Progress', cardPercent: 0.25),
             ActiveProjectsCard(cardColor: LightColors.kDarkBlue, cardTitle: 'Delivery App', 
             cardSubtitle: '100 Hour work progress ', cardPercent: 0.25),
             ],),
             ],))
            
            ],)
            )
          )
        ],);
        }),
   
        floatingActionButton:_showFab ? FloatingActionButton(
          backgroundColor: Colors.grey[600],
           onPressed: () {Navigator.pushReplacementNamed(context, '/addTask');},
           tooltip: 'Add Task',
           child: const Icon(Icons.add)):null,
       floatingActionButtonLocation: _fabLocation,
       bottomNavigationBar: BottomBar(floatingActionButtonLocation: _fabLocation,
       shape: _showNotch ? const CircularNotchedRectangle() : null,),
       drawer: const SideDrawer(),
   ));
  }

}