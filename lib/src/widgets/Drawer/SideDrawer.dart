import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget{
  const SideDrawer({super.key});

  @override
  State createState() =>  _SideDrawerState();

}
int selectedIndex=0;
class _SideDrawerState extends State<SideDrawer>
{
  
  @override
  Widget build(BuildContext context) {
   return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children:  <Widget>[
        const DrawerHeader(
         decoration: BoxDecoration(
          color: Colors.blue,
         ),
         child: Center(
          child: Text(
          'My Drawer',
          style: TextStyle(color: Colors.white,fontSize: 24),
         ),
         )
         
        ),
        DrawerItem(
         icon: Icons.home,
                text: 'Home',
                isSelected: selectedIndex == 1,
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });

                  Navigator.pushReplacementNamed(context, "/home");
                }
        ),
        DrawerItem(
         icon: Icons.info_outline,
                text: 'About',
                isSelected: selectedIndex == 2,
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });

                  Navigator.pushReplacementNamed(context, "/about");
                }
        ),
        DrawerItem(
         icon: Icons.person,
                text: 'Profile',
                isSelected: selectedIndex == 3,
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });

                  Navigator.pushReplacementNamed(context, "/profile");
                }
        ),
      ],
    ),
   );
  }
  
}
class DrawerItem extends StatelessWidget{
  const DrawerItem({super.key,required  this.icon, required this.text, required this.onTap, required this.isSelected});
    
    final IconData icon;
    final String text;
    final GestureTapCallback onTap;
    final bool isSelected;
   
  @override
  Widget build(BuildContext context) {
   return Ink(
    color: isSelected ? Colors.blue[100] : Colors.transparent,
    child: ListTile(
      selected: true,
      hoverColor: Colors.white,
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(text, style: const TextStyle(color: Colors.black,fontSize: 16),),
          )
        ],
      ),
      onTap: onTap,
    ),
  );
  }

}