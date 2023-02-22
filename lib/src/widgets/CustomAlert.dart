import 'package:flutter/material.dart';


class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String? positiveBtnText;
  final String? negativeBtnText;
  final Function onPositivePressed;
  final Function? onNegativePressed;
  final double circularBorderRadius;
  final IconData? icon;

  const CustomAlertDialog({super.key, 
    this.icon,
    required this.title,
    required this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
     this.positiveBtnText,
     this.negativeBtnText,
    required this.onPositivePressed,
     this.onNegativePressed,
     
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: 
       Row(
          children:[
            Icon(icon,color: Colors.blue,),
            const SizedBox(width: 10,),
            Expanded(child: Text(title),
            )
            ]
          ), 
      content:  Text(message) ,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
              if(negativeBtnText!=null )...[
               TextButton(
                style: const ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.black))),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNegativePressed != null) {
                    onNegativePressed!();
                  }
                },
                child: Text(negativeBtnText!),
               ),
              ]
              else const SizedBox(width:0,height:0),
            if(positiveBtnText != null)...[
             TextButton(
                style: const ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.black))),
                onPressed: () {
                 
                    onPositivePressed();
                },
                child: Text(positiveBtnText!),
              )
            ]
            else const SizedBox(width: 0,height: 0,)
      ],
    );
  }
}