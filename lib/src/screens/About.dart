import 'package:flutter/material.dart';
import 'package:app/src/widgets/Drawer/SideDrawer.dart';
import 'package:app/src/widgets/buttons/CustomButton.dart';
import 'package:app/src/widgets/TextInput/TextInputField.dart';

class About extends StatelessWidget{
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
     leading:Builder(builder:(context)=>IconButton(onPressed: () {
      Scaffold.of(context).openDrawer();
     }, icon: const Icon(Icons.menu),tooltip: 'Drawer',)) ,
    title: const Text('About'),automaticallyImplyLeading: false,),
      drawer: const SideDrawer(),
      body: Column(
       children: [
        const SizedBox(height: 20,),
         Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
               Center(
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration:  BoxDecoration(
                   color: Colors.blue,
                   border: Border.all(color: Colors.blue, width: 4.0),
                   borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                 ),
                 child: 
               const Text('About Us',style: TextStyle(fontSize: 22,color: Colors.white,backgroundColor: Colors.blue,),) ,
            ),),
          ],),
          const SizedBox(height: 10,),
               Center(
                child:Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                ,style: TextStyle(fontStyle: FontStyle.normal,fontSize: 16),textAlign: TextAlign.center,
                ),
                ),
              ),
              SizedBox(height: 1,child: Container(color: Colors.blue[400],margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),),),
              const SizedBox(height: 20,),
                Center(
                  child:   Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration:  BoxDecoration(
                   color: Colors.blue,
                   border: Border.all(color: Colors.blue, width: 4.0),
                   borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                 ),
                 child: 
               const Text('Contact Us',style: TextStyle(fontSize: 22,color: Colors.white,backgroundColor: Colors.blue,),) ,
            ),),
               const SizedBox(height: 10,),
               //Contact Us
             Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Column(
                  children: [
                 TextInput(hint: 'Email', textColor: Colors.grey, fontSize: 16, onChanged: (value){
                    },expands: false,icon: Icons.email,iconColor: Colors.blue,),
                   const SizedBox(height: 10,),
                  TextInput(hint: 'Comment', textColor: Colors.grey, fontSize: 16, onChanged: (value){
                  },expands: true,icon:Icons.comment,iconColor: Colors.blue,),
                  const SizedBox(height: 20,),
                  Button(onPressed: () {}, title: 'Save', color: Colors.blue, font: 15),
                   ],),),

              ),
             ],
      ),
       bottomNavigationBar:BottomAppBar (
          notchMargin: 4,
          clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
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