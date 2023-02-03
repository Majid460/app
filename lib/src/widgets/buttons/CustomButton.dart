import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key,required this.onPressed,required this.title,required this.color,required this.font});
  final VoidCallback onPressed;
   final String title;
   final MaterialColor color;
    final double font;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(color.value)),
        padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(20, 10, 20, 10)),
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: font)),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
    
  }}