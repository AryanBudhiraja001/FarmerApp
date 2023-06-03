import 'package:flutter/material.dart';
import '../constants/exports.dart';

class CustomButton extends StatelessWidget{
  var buttonText;
  var buttonColor;
  var cornerRadius;
  var onClick;
  var textColor;
  var verticalPadding;
  var horizontalPadding;
   var showIndicator;
   var buttonIcon;

  CustomButton({this.buttonText,
    this.buttonColor,
    this.cornerRadius,
    this.onClick,
    this.textColor,
    this.verticalPadding,
    this.horizontalPadding,
    this.showIndicator=false,
    this.buttonIcon,
  });
  @override
  Widget build(BuildContext context) {
       return ElevatedButton(
           onPressed: onClick??(){},
         style:ElevatedButton.styleFrom(
             backgroundColor: buttonColor??primaryColor,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(cornerRadius??margin_25)
             ),
           padding: EdgeInsets.symmetric(vertical:verticalPadding??margin_16,horizontal: horizontalPadding??margin_10)
           ),

           child: showIndicator?  SizedBox(
             height: 20.0,
             width: 20.0,
             child: CircularProgressIndicator(
               color: white,
             ),
           ):
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   commonText(buttonText,color: textColor??white,fontWeight: FontWeight.w500,fontSize: font_14,letterSpacing:1.25),
                  sizedBox(width: margin_5),
                   buttonIcon??Container()
                 ],
               )



       );
  }
}