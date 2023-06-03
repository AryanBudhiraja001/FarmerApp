import 'package:flutter/material.dart';

import '../../../constants/exports.dart';

class SubSchemesList extends GetView<SubSchemesController> {
  SubSchemesList({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    GetBuilder<SubSchemesController>(
      init:SubSchemesController() ,
      builder: (controller){
        return  Scaffold(
          appBar: customAppBar(
            backIcon:false,
            leadingIcons: Container(),
            hideLeading:sizedBox(width: 0.0),
            title:controller.title??subSchemesStr.tr,
          ),
          body: setPadding(
              widget:
              _schemes(),
              topPadding: margin_40,
              bottomPadding:margin_16,
              leftPadding: margin_25,
              rightPadding: margin_25
          ),
        );
      },
    )
   // body: ,Area(child: Scaffold(

    );
  }




  _schemes(){
    return
      controller.subSchemesList.isEmpty?
          SizedBox(
            height: Get.mediaQuery.size.height,
              width: Get.mediaQuery.size.width,
              child:
          Column(
            children: [
              assetImage(image: img_noSchemesImages,height: 100.0,width: 100.0),
              commonText(noSchemesStr.tr),
            ],
          )
          )
      :
      AnimationLimiter(
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount: controller.subSchemesList.length,
          separatorBuilder: (context,index){
            return const Divider(color: dividerColor2);
          },
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                // verticalOffset: 50.0,
                child: FadeInAnimation(
                    child:  schemesItem(index)
                ),
              ),
            );
          },
        ),
      );
  }
  schemesItem(index){
    return getInkWell(

        widget: Container(
          padding: EdgeInsets.symmetric(vertical: margin_16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(margin_7),
                // height: 22,
                // width: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:circleColor,
                ),
                child: commonText( "${index+1}",color: white,fontSize: font_14),
              ),
              sizedBox(width: margin_16),
              Expanded(child: commonText( controller.subSchemesList[index].schemeCatName,color: subtitleColor,fontSize: font_16,fontWeight: FontWeight.w400,
                  letterSpacing:0.44
              )),
              sizedBox(width: margin_30),
            ],
          ),
        ),
        ontap: (){
          Get.toNamed(Routes().schemesCategoryList,arguments:controller.subSchemesList[index]);
        }
    );


  }
}
