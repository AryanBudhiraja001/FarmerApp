
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/exports.dart';
import '../shimmer_effect/shimmerWidget.dart';

ImagePicker _picker = ImagePicker();

commonBlackContainer(context, {widget, height}) {
  return Container(
    width: fullWidth(),
    decoration:
        const BoxDecoration(gradient: LinearGradient(colors: [gradient1, black])),
    child: widget,
  );
}

assetImage({image, height, width, fit}) {
  return Image.asset(
    image,
    fit: fit ?? BoxFit.contain,
    height: height,
    width: width,
  );
}


viewsConverterCostNorm(num) {
  if (num > 999 && num < 99999) {
    return "${(num / 1000).toStringAsFixed(1)}K";
  }
     else if (num > 99999 && num < 9999999) {
    return "${(num / 100000).toStringAsFixed(1)}L";
  }
  else if (num > 9999999 && num < 999999999) {
    return "${(num / 10000000).toStringAsFixed(1)}Cr";
  }
  else {
    return num.toString();
  }
}

noDataAvailable({title,imagePath}){
  return  Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sizedBox(height: height_30),
        assetImage(image: imagePath??img_noSchemesImages,height: 100.0,width: 100.0),
        commonText(title??"No data Available",color: paragraphColor,align: TextAlign.center)
      ],
    ),
  );

     }

fileImage({image, height, width, fit, radius}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius ?? 0),
    child: Image.file(image,
        height: height ?? 50,
        width: width ?? 50,
        fit: fit ?? BoxFit.cover,
        filterQuality: FilterQuality.high),
  );
}

pickImage({height, width, bool camera = true}) async {
  return await _picker.pickImage(
    source: camera ? ImageSource.camera : ImageSource.gallery,
    maxWidth: width ?? 100,
    maxHeight: height ?? 100,
    // imageQuality: b
  );
}

customAppBar({
  context,
  leadingIcons,
  title,
  backIcon = false,
  leadingCLick,
  leading,
  onActionsClick,
  actions,
  hideLeading = false,
}) {
  return AppBar(
    centerTitle: false,
    // titleSpacing: margin_10,
    leading: leading??null,
    title: Row(
      children: [
        leadingIcons ?? Container(),
        backIcon ? sizedBox(width: margin_20) : Container(),
       Expanded(child:  commonText(title ?? "", color: white, fontSize: font_20,maxLines: 1),)

      ],
    ),
    actions: actions,
    backgroundColor: secondaryColor,
  );
}

appBarWithDataOnBack({title,data}){
  return AppBar(
    centerTitle: false,
    leading: null,
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        getInkWell(
            widget:Icon(Icons.arrow_back,color: white,),
            ontap: (){
              Get.back(result:data);
            }
        ),
        sizedBox(width: margin_20) ,
        commonText( title, color: white, fontSize: font_20),
      ],
    ),
    backgroundColor: secondaryColor,
  );


}


farmerProfileAppBar({
  context,
  leadingIcons,
  title,
  backIcon = false,
  leadingCLick,
  leading,
  onActionsClick,
  actions,
  hideLeading = false,
}) {
  return AppBar(
    centerTitle: false,
    // titleSpacing: margin_10,
    leading: leading,
    title: Row(
      children: [
        leadingIcons ?? Container(),
        backIcon ? sizedBox(width: margin_20) : Container(),
        Expanded(child:  commonText(title ?? "", color: white, fontSize: font_20,maxLines: 1),)

      ],
    ),
    actions: actions,
    backgroundColor: secondaryColor,
  );
}

titleText(title) {
  return commonText(title ?? "", fontSize: font_24, color: paragraphColor);
}

commonText(text, {color, fontSize, fontWeight, maxLines, letterSpacing,align,textHeight}) {
  return Text(
    text ?? "null",
    maxLines: maxLines ?? 2,
     textAlign: align??TextAlign.start,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
          height: textHeight??1.0,
          letterSpacing: letterSpacing ?? 0.28,
          color: color ?? black,
          fontSize: fontSize ?? font_16,
          fontWeight: fontWeight ?? FontWeight.w500,
          overflow: TextOverflow.ellipsis),
    ),
  );
}

commonTextDescription(text, {color, fontSize, fontWeight, maxLines, letterSpacing,align}) {
  return Text(
    text ?? "null",
    textAlign: align??TextAlign.start,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
          height: 1.5,
          letterSpacing: letterSpacing ?? 0.28,
          color: color ?? black,
          fontSize: fontSize ?? font_16,
          fontWeight: fontWeight ?? FontWeight.w500,
         ),
    ),
  );
}

sizedBox({height, width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

text(
  text, {
  color,
  fontSize,
  fontWeight,
}) {
  return Text(
    text,
    style: TextStyle(
        color: color ?? black,
        fontSize: fontSize ?? font_15,
        fontWeight: fontWeight ?? FontWeight.w700),
  );
}

setPadding({widget, leftPadding, rightPadding, bottomPadding, topPadding}) {
  return Padding(
    padding: EdgeInsets.only(
      left: leftPadding ?? 0,
      right: rightPadding ?? 0,
      bottom: bottomPadding ?? 0,
      top: topPadding ?? 0,
    ),
    child: widget,
  );
}

setPaddingAll({widget, margin}) {
  return Padding(
    padding: EdgeInsets.all(margin ?? 0),
    child: widget,
  );
}

alreadyAccountText({title, leading, onclick}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      commonText(title ?? alreadyStr,
          fontSize: font_16,
          color: floatingTextColor,
          fontWeight: FontWeight.w400),
      sizedBox(width: margin_10),
      getInkWell(
        ontap: onclick ?? () {},
        widget: commonText(leading ?? loginStr,
            fontSize: font_16, color: primaryColor),
      )
    ],
  );
}

getInkWell({widget, ontap}) {
  return InkWell(
    child: widget,
    onTap: ontap,
  );
}

logo({logoImage, logoHeight, logoWidth}) {
  return Container(
    height: logoHeight ?? 104.0,
    width: logoWidth ?? 104.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(image: AssetImage(ic_logo)),
    ),
  );
}

fullHeight() {
  return Get.height;
}

fullWidth() {
  return Get.width;
}

datePicker(context, controller) {
  return showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1990),
          lastDate: DateTime(2030))
      .then((date) {
    // var dateNow = DateFormat.yMMMMd().format(date!);
    // controller.text = dateNow;
  });
}

snackBar(message, {title, textColor, position, bgColor, borderRadius}) {
  return Get.snackbar(title ?? "", message,
      colorText: textColor ?? white,
      snackPosition: position ?? SnackPosition.TOP,
      backgroundColor: bgColor ?? black,
      borderRadius: borderRadius??0.0);
}

  fadeInImage({networkImage,fileImage,height,width}){
  return FadeInImage(
    height: height??100.0,
    width: width??100.0,
    fadeOutDuration: const Duration(seconds: 1) ,
    fadeInDuration: const Duration(seconds: 1),
    fit: BoxFit.fill,
    placeholder:  fileImage??AssetImage(ic_user),
    image:networkImage??AssetImage(ic_user),
  );

  }


  networkImages(url,{shape,placeHolder,errorWidget,height,width}){

  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      height: height??100,
      width: width??100,
      decoration: BoxDecoration(
        shape: shape??BoxShape.circle,
        image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
           ),
      ),
    ),
    placeholder: (context, url) =>placeHolder?? const ShimmerWidget.circular(width: 100.0, height: 100.0),
    errorWidget: (context, url, error) => errorWidget??assetImage(image:ic_user,width: 100.0,height: 100.0),
  );
  }




  circularIndicator({colors}){
  return    SpinKitCircle(
    color: colors??primaryColor,
    size: 50.0,
    //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
  );
  }

toast(message, {textColor, position, bgColor, borderRadius}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: position ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor ?? secondaryColor,

      textColor: textColor ?? Colors.white,
      fontSize: font_16);
}

  loader(){
  return   const SpinKitCircle(
    color: primaryColor,
    size: 50.0,
    //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
  );
  }
commonDialogs(
    {titleText,
    body,
    bgColor,
    textColor,
    radius,
      confirm,
      cancel,
    textCancel,
    textConfirm,
    onConfirmClick,
    confirmButtonColor}) {
  return Get.defaultDialog(
    title: titleText ?? "",
    middleText: "",
    content: body,
    confirm: confirm??Container(),
    cancel: cancel??Container(),
    onCancel: () {
      Get.back();
    },
    contentPadding:
        EdgeInsets.symmetric(horizontal: margin_20),
    buttonColor: confirmButtonColor ?? Colors.green,
    onConfirm: onConfirmClick ?? () {},
    radius: radius_8,
  );
}

commonBottomSheet({
  body,
  backgroundColor,
}) {
  body ??
      Get.bottomSheet(
        Container(
          padding: EdgeInsets.all(margin_10),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius_10),
                topRight: Radius.circular(radius_10),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                buttonText: "light Theme",
                onClick: () {
                  Get.changeTheme(ThemeData.light());
                },
              ),
              sizedBox(height: height_10),
              CustomButton(
                buttonText: "dark Theme",
                onClick: () {
                  Get.changeTheme(ThemeData.dark());
                },
              )
            ],
          ),
        ),
      );
}

   divider({height,color}){
  return Divider(thickness: height??1.0,color: color??dividerColor2,);
   }



/*============================================================routes managements==========================*/

// DateFormat.yMd()                 -> 7/10/1996
// DateFormat('yMd')                -> 7/10/1996
// DateFormat.yMMMMd('en_US')       -> July 10, 1996
// DateFormat.jm()                  -> 5:08 PM
// DateFormat.yMd().add_jm()        -> 7/10/1996 5:08 PM
// DateFormat.Hm()                  -> 17:08 // force 24 hour time
