import 'package:flutter/material.dart';

import '../../../constants/exports.dart';
import '../../../shimmer_effect/shimmerWidget.dart';


class SchemesCategoryList extends GetView<SchemesCategoryListController> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    GetBuilder<SchemesCategoryListController>(
      init: SchemesCategoryListController(),
      builder: (_){
        return  Scaffold(
          appBar: customAppBar(
            backIcon:false,
            leadingIcons: Container(),
            hideLeading:sizedBox(width: 0.0),
            title:controller.title??"SubSchemes",
            // actions:[
            //   Row(
            //     children: [
            //       getInkWell(
            //           ontap: (){
            //             Get.toNamed(Routes().notifications);
            //           },
            //           widget: Icon(Icons.notifications_rounded,color: white,)),
            //       sizedBox(width: width_20),
            //     ],
            //   ),
            // ],

          ),
          body: controller.isLoadingData.value?loader():FutureBuilder(
                      future: controller.futureComponent,
                      builder: (_,data){
                        if(data.connectionState==ConnectionState.done){
                          return
                            SingleChildScrollView(
                              child:   _components() ,
                            );
                        }
                        if(data.connectionState==ConnectionState.waiting){
                          return _componentShimmerWidget();
                        }
                        else{
                          return noDataAvailable(title:noComAvailStr.tr);
                        }
                      }

                      ),
        );
      },
    )
      // body: ,Area(child: Scaffold(

    );
  }




  _components(){
    return
      controller.componentList.isEmpty?
      SizedBox(
          height: Get.mediaQuery.size.height,
          width: Get.mediaQuery.size.width,
          child:
        noDataAvailable(title:noCategoryAvailStr.tr)
      )
          :
      setPadding(
        leftPadding: margin_20,
        rightPadding: margin_20,
         topPadding: margin_20,
        widget: Column(
          children: [
            AnimationLimiter(
              child: ListView.separated(
                shrinkWrap: true,
                 primary: false,
                itemCount: controller.componentList.length,
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
                          child:  _componentItem(index)
                      ),
                    ),
                  );
                },
              ),
            ),
            sizedBox(height: margin_30),
            _bottomButtons(),
            sizedBox(height: margin_20),
          ],
        ),
      );
  }

  _componentItem(index){
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
                decoration:const  BoxDecoration(
                  shape: BoxShape.circle,
                  color:circleColor,
                ),
                child: commonText( "${controller.countStartFrom!+index}",color: white,fontSize: font_14),
              ),
              sizedBox(width: margin_16),
              Expanded(child: commonText(controller.componentList[index].subcategoryName!.capitalize,color: subtitleColor,fontSize: font_16,fontWeight: FontWeight.w400,
                  letterSpacing:0.44,textHeight: 1.4,maxLines: 3,
              )),
              // sizedBox(width: margin_20),
            ],
          ),
        ),
        ontap: (){
           Get.toNamed(Routes().exploreSchemes,arguments: controller.componentList[index]);
        }
    );


  }

 _componentShimmerWidget(){
   return SingleChildScrollView(
     child: Center(
       child: setPaddingAll(
         margin: margin_20,
         widget: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             sizedBox(height: height_30),
             ListView.builder(
                 itemCount: 8,
                 shrinkWrap: true,
                 primary: false,
                 itemBuilder: (context,index){
                   return  setPadding(
                       bottomPadding: height_20,
                       widget: ShimmerWidget.rectangular(height: 56.0));
                 }),
           ],
         ),
       ),
     ),
   );
  }




  _bottomButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        controller.currentPage.value==1?Container():  getInkWell(
          ontap: (){
            controller.goToPreviousPage();
          },
          widget: Container(
            padding: EdgeInsets.symmetric(vertical: margin_12,horizontal: margin_24),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(radius_4),
              color: disableButtonColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.skip_previous,color: headingColor,),
                sizedBox(width: margin_5),
                commonText(prevPageStr.tr,color: headingColor,fontWeight: FontWeight.w500,fontSize: font_14,letterSpacing:1.25),
              ],
            ),
          ),
        ),
        controller.currentPage.value==controller.totalPages?Container():
        getInkWell(
          ontap: (){
            controller.goToNextPage();
          },
          widget: Container(
            padding: EdgeInsets.symmetric(vertical: margin_12,horizontal: margin_24),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(radius_4),
              color: disableButtonColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonText(nextPageStr.tr,color: headingColor,fontWeight: FontWeight.w500,fontSize: font_14,letterSpacing:1.25),
                sizedBox(width: margin_5),
               const Icon(Icons.skip_next,color: headingColor,),
              ],
            ),
          ),
        ),



      ],
    );


  }
}
