import 'package:flutter/material.dart';
import '../../constants/exports.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller){
        return Scaffold(
          appBar: customAppBar(
            leadingIcons: Container(),
            hideLeading:sizedBox(width: 0.0),
            title: notificationsStr.tr,),
          body:_notificationList()





        );
      },

    ));
  }


  _notificationList(){
    return
      FutureBuilder(
          future: controller.notificationFutureData,
          builder: (_,data){
            if(data.connectionState==ConnectionState.done){
              if(data.hasData){
                return
                 data.data!.data!.isNotEmpty?
                  Column(
                  children: [
                    sizedBox(height: margin_20),
                    AnimationLimiter(
                      child:  ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: controller.notificationList!.length,
                          itemBuilder: (_,index){
                            return   AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  // verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                        child:
                                        _notificationAnnouncement(index)
                                    )));
                          }) ,
                    ),
                  ],
                ):noDataAvailable();
              }
              if(data.hasError){
                return
                  noDataAvailable();
              }
            }
            if(data.connectionState==ConnectionState.waiting){
              return Center(
                child:circularIndicator() ,
              );
            }

              return
                  noDataAvailable();}
      )
    ;


  }



  _notificationAnnouncement(index){
    return Container(
       padding: EdgeInsets.symmetric(vertical: margin_16,horizontal: margin_16),
      margin: EdgeInsets.symmetric(vertical: margin_16,horizontal: margin_20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_15),
          border: Border.all(color: borderColor)
      ),
      child:
         Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText(controller.notificationList![index].message,fontSize: font_14,color:subtitleColor,fontWeight: FontWeight.w400),
              sizedBox(height: margin_20),

            Row(
              children: [
                Container(
                  height: 3,
                  width: 3,
                  margin: EdgeInsets.only(right: margin_3),
                  decoration:const  BoxDecoration(
                      shape: BoxShape.circle,
                      color: subtitleColor
                  ),
                ),
                sizedBox(width: margin_2),
                commonText(controller.timeAgoList[index],fontSize: font_14,color:subtitleColor,fontWeight: FontWeight.w400),
              ],
            )

            ],
          )
    );
  }


}
