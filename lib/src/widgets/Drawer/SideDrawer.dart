import 'package:flutter/material.dart';
import 'package:app/src/resources/theme/colors.dart';
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
   return ClipRRect(
    borderRadius: const BorderRadius.only(topRight: Radius.circular(40),bottomRight: Radius.circular(40)),
    child: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children:  <Widget>[
         DrawerHeader(
         decoration: const BoxDecoration(
          color: LightColors.kDarkYellow,
         ),
         child: Align(alignment: Alignment.centerLeft,
         child: Row(
          children: [
            const CircleAvatar(backgroundColor: Colors.blue,radius: 35.0,backgroundImage: AssetImage('lib/src/resources/assets/images/avatar.png', ),),
            const SizedBox(width: 10,),
             Expanded(child: Column(mainAxisAlignment:MainAxisAlignment.center ,crossAxisAlignment: CrossAxisAlignment.start,
             children:  [Container(padding: const EdgeInsets.symmetric(horizontal: 10),
             child:    const Text('Ab Jho',style:TextStyle(fontSize: 20,color: LightColors.kDarkBlue,fontWeight: FontWeight.w800),textAlign: TextAlign.start,),),
             Container(padding: const EdgeInsets.symmetric(horizontal: 10),
             child:  Text('App Developer',style:TextStyle(fontSize: 16,color: Colors.grey.shade800,fontWeight: FontWeight.w400),textAlign: TextAlign.start),)
           ],)
          ),
            ],),)
          
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
          const SizedBox(width: 10,),
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(text, style: const TextStyle(color: Colors.black,fontSize: 18),),
          )
        ],
      ),
      onTap: onTap,
    ),
  );
  }

}