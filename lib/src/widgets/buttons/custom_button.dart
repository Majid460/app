import 'package:flutter/material.dart';


class Button extends StatelessWidget{
  const Button({super.key,required this.onPressed,required this.title,required this.color,required this.font,required this.paddingH,required this.paddingV});
  final VoidCallback onPressed;
   final String title;
   final MaterialColor color;
    final double font;
    final double paddingH;
    final double paddingV;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: const BorderSide(color: Colors.red),
    )
  ),
        backgroundColor: MaterialStateProperty.all(Color(color.value)),
        padding: MaterialStateProperty.all( EdgeInsets.symmetric(horizontal: paddingH,vertical: paddingV)),
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: font)),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
    
  }}