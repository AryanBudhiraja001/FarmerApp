import 'package:flutter/material.dart';

import '../../../constants/exports.dart';


class Schemes extends  GetView<SchemesController> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(child:
    Scaffold(
          body:
          GetBuilder<SchemesController>(
        init:SchemesController() ,
    builder: (_){
    return  FutureBuilder(
    future:controller.future,
    builder: (context,data){
    if(data.connectionState==ConnectionState.done){
    if(data.hasData){
    return setPadding(
    widget:Column(

    children: [
    sizedBox(height: height_30),
    commonText(pleaseSelectCategoryStr.tr.toUpperCase(),color:floatingTextColor,fontWeight: FontWeight.w400,fontSize: font_14,letterSpacing: 1.07),
    sizedBox(height: height_30),
    _category(),
    ],
    ),

    bottomPadding:margin_16,
        leftPadding: margin_25,
    rightPadding: margin_25
    );
    }
    if(data.hasError){
    return SizedBox(
    height: Get.mediaQuery.size.height,
    width: Get.mediaQuery.size.width,
    child: noDataAvailable(title:Get.find<SchemesController>().schemesErrorMesages.value),
    );
    }
    }
    if(data.connectionState==ConnectionState.waiting){
      return loader();
    }
    return Center(
    child: loader()
    );
    }
    );
    }
    )
    )

    );


  }




  _category(){
    return
      AnimationLimiter(
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount:Get.find<SchemesController>().categoryList.length,
          separatorBuilder: (context,index){
            return Divider(color: dividerColor);
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

          margin: EdgeInsets.only(bottom: margin_6),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius:BorderRadius.circular(radius_8)
          ),
          padding: EdgeInsets.symmetric(vertical: margin_25,horizontal: margin_16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: commonText(Get.find<SchemesController>().categoryList[index].govtSchemeCatName,color: black,fontSize: font_18,fontWeight: FontWeight.w400,
                  letterSpacing:0.44
              )),
              Icon(Icons.arrow_forward_ios,color: black,size: 18,),
            ],
          ),
        ),
        ontap: (){
          Get.toNamed(Routes().subSchemesList,arguments:controller.categoryList[index],);
        }
    );


  }
}
