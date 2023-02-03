import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  const Button1({super.key,required this.onPressed,required this.title});
  final VoidCallback onPressed;
   final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.lightGreen[500]),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
        
      ),
      onPressed: onPressed,
      child: Text(title),
    );
    
  }}
  class DisplayCounter extends StatelessWidget{

  const DisplayCounter({required this.count,super.key});

    final int count;
  @override
  Widget build(BuildContext context) {
    return Center(
     child: Column(
      children:  <Widget>[
      Text('Count $count',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      ),
      ],
     ),
    );
  }

  }
  