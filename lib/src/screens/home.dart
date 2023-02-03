import 'package:flutter/material.dart';
import 'package:app/src/widgets/bottomNavigation/BottomBar.dart';
import 'package:app/src/widgets/Drawer/SideDrawer.dart';
class HomePage extends StatefulWidget{
  const HomePage({super.key});
  
  @override
  State createState() => _BottomAppBarPage();
 
}
class _BottomAppBarPage extends State<HomePage>{

   bool _showNotch=true;
   bool _showFab=true; 
  FloatingActionButtonLocation _fabLocation=FloatingActionButtonLocation.centerDocked;
 
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
  @override
  Widget build(BuildContext context) {
   return Scaffold(
   appBar: AppBar(
     leading:Builder(builder:(context)=>IconButton(onPressed: () {
      Scaffold.of(context).openDrawer();
     }, icon: const Icon(Icons.menu),tooltip: 'Drawer',)) ,
    title: const Text('Home'),automaticallyImplyLeading: false,),
     body: ListView(
         padding: const EdgeInsets.only(bottom: 88),
         children: <Widget>[
              SwitchListTile(
              title: const Text("Floating Action Button"),
              value: _showFab,
              onChanged: onShowFabChanged,
              ),
              SwitchListTile(
                title: const Text('Notch'),
                value: _showNotch,
                onChanged: onShowNotchChanged,
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Floating Action Button Position'),
              ),
              RadioListTile<FloatingActionButtonLocation>
              ( title: const Text('Docked - Center'),
                value: FloatingActionButtonLocation.centerDocked,
               groupValue: _fabLocation,
                onChanged: onFabLocationChange
              ),
             RadioListTile<FloatingActionButtonLocation>
              ( title: const Text('Docked - End'),
                value: FloatingActionButtonLocation.endDocked,
               groupValue: _fabLocation,
                onChanged: onFabLocationChange
              ),
              RadioListTile<FloatingActionButtonLocation>
              ( title: const Text('Float - Center'),
                value: FloatingActionButtonLocation.centerFloat,
               groupValue: _fabLocation,
                onChanged: onFabLocationChange
              ),
              RadioListTile<FloatingActionButtonLocation>
              ( title: const Text('Float - End'),
                value: FloatingActionButtonLocation.endFloat,
                groupValue: _fabLocation,
                onChanged: onFabLocationChange
              ),
           ],
        ),
        floatingActionButton:_showFab ? FloatingActionButton(
           onPressed: () {},
           tooltip: 'create',
           child: const Icon(Icons.add)):null,
       floatingActionButtonLocation: _fabLocation,
       bottomNavigationBar: BottomBar(floatingActionButtonLocation: _fabLocation,
       shape: _showNotch ? const CircularNotchedRectangle() : null,),
       drawer: const SideDrawer(),
   );
  }

}