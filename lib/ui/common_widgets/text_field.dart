import 'package:flutter/material.dart';
import '../constants/exports.dart';


class CommonTextField extends StatelessWidget{
  var controller;
  var hint;
  var validation;
   var inputType;
   var maxLength;
   var labelText;
   var prefix;
   var suffix;
   var enable;
   var readOnly;
   var inputFormators;

   var preText;
   var onChanged;
   var showFloating;
   var focusNode;
   var inputActions;
   var maxlines;
   var hideHelperText;
  CommonTextField({
    this.controller,
    this.hint,
    this.validation,
    this.inputType,
    this.maxLength,
    this.labelText,
    this.prefix,
    this.suffix,
    this.enable,
    this.readOnly,
    this.inputFormators,
    this.preText,

    this.onChanged,
    this.showFloating =true,

    this.focusNode,
    this.inputActions,
    this.maxlines,
    this.hideHelperText=false,

      }
      );


  @override
  build(BuildContext context){
    return   TextFormField(
      controller: controller,
      validator: validation,
       maxLines: maxlines??1,
       enabled: enable??true,
        readOnly: readOnly??false,
        keyboardType: inputType??TextInputType.text,
       onChanged: onChanged,
        focusNode: focusNode,
      textInputAction: inputActions,
      style: GoogleFonts.roboto(
    textStyle: TextStyle(
    color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),
      ),
      cursorColor: primaryColor,
      inputFormatters: inputFormators,
      decoration: InputDecoration(
        floatingLabelBehavior: showFloating?FloatingLabelBehavior.auto:FloatingLabelBehavior.never,
        prefixStyle: GoogleFonts.roboto(
          textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
        prefixText: preText??"",
        fillColor: gradient1,
        labelText: labelText ??"",
          helperStyle: GoogleFonts.roboto(
            textStyle:TextStyle(color: paragraphColor,fontSize: font_11,fontWeight: FontWeight.w400),),
          helperText: hideHelperText?"":requiredStr.tr,

          iconColor: black,
         prefixIcon:prefix,
         suffixIcon: suffix,
          hoverColor: hoverBorderColor,
          labelStyle:  GoogleFonts.roboto(
          textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius_4),
            borderSide: BorderSide(
              color: borderColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius_4),
            borderSide: BorderSide(
              color:primaryColor,
              width: 1.0,
            ),
          ),
          errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius_4),
            borderSide: BorderSide(
              color:errorBorderColor,
              width: 1.0,
            ),
          ),
          border:OutlineInputBorder(

          borderRadius: BorderRadius.circular(radius_4)
        ),
        hintText: hint,
        hintStyle: TextStyle(color: black,fontSize: font_15)
      )
    );
    }




}