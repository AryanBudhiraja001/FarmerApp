
import 'package:farmer_app/ui/shimmer_effect/shimmerWidget.dart';
import 'package:flutter/material.dart';
import '../../constants/exports.dart';



class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
          GetBuilder(
            init:MainScreenController() ,
            builder: (_){
              return         Scaffold(
                  drawer: _drawer(),
                  appBar: customAppBar(
                      backIcon:false,
                      leadingIcons: Container(),
                      hideLeading:sizedBox(width: 0.0),
                     // title: controller.appBarTitle[controller.currentIndex.value],
                      title: controller.currentIndex.value==0?homeStr.tr:
                      controller.currentIndex.value==1?schemesStr.tr:
                      controller.currentIndex.value==2?mandiRateStr.tr:
                      videoFeedStr.tr,
                      actions:[
                        Row(
                          children: [
                            getInkWell(
                                ontap: (){
                                  Get.toNamed(Routes().notifications)?.then((value) {
                                    controller.update();
                                  });
                                },
                                widget: Stack(children:
                                [
                                  Icon(Icons.notifications_rounded,color: white,),
                                 controller.notificationReadStatus.value? Positioned(
                                      top: margin_0,
                                      right: margin_0,
                                      child:
                                     Icon(Icons.circle,size: 10,color: redColor,)
                                  ): Positioned(
                                     top: margin_0,
                                     right: margin_0,
                                     child:
                                     Container()
                                 )
                                ]

                               )),
                            sizedBox(width: width_10),
                          ],
                        )
                      ] ),
                  bottomNavigationBar:_bottomNavigation(),
                  body: IndexedStack(
                    index: controller.currentIndex.value,
                    children:  [
                       HomeScreen(),
                       Schemes(),
                       MandiRate(),
                       VideoFeed(),
                    ],
                  )
              );
            },
          )

    );
  }






  _bottomNavigation(){
   return  GetBuilder<MainScreenController>(
     builder: (_){
       return      BottomNavigationBar(
         currentIndex:  controller.currentIndex.value,
         type: BottomNavigationBarType.fixed,
         backgroundColor: primaryColor,
         selectedItemColor: white,
         unselectedItemColor: Colors.white.withOpacity(.60),
         selectedFontSize: font_14,
         unselectedFontSize:font_14,
         onTap: (value) {
           controller.onBottomClick(value);
         },
         items: [
           BottomNavigationBarItem(
             label: homeStr.tr,
             icon: setPadding(
                 bottomPadding: margin_2,
                 widget:  const Icon(Icons.home_filled)),
           ),
           BottomNavigationBarItem(
             label: schemesStr.tr,

             icon:  setPadding(
               bottomPadding: margin_2,
               widget: const Icon(
                 Icons.format_list_bulleted,
               ),
             ),
           ),
           BottomNavigationBarItem(
             label: mandiRateStr.tr,

             icon:  setPadding(
               bottomPadding: margin_2,
               widget: const Icon(Icons.currency_rupee,
               ),
             ),
           ),
           BottomNavigationBarItem(
             label: videoFeedStr.tr,
             icon:  setPadding(
               bottomPadding: margin_2,
               widget: const Icon(
                 Icons.play_circle_fill,
               ),
             ),
           ),
         ],
       );
     },
   );





  }
  _drawer(){
    return Drawer(
      child :Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        setPadding(
                          leftPadding: margin_20,
                          topPadding: margin_40,
                          widget:
                          FutureBuilder(
                              future: controller.future,
                              builder: (_,data){
                           if(data.connectionState==ConnectionState.done){

                          return   Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 controller.profileData==null?assetImage(image: ic_user,height: 40.0,width: 40.0):
                                 Container(
                                     height: 50.0,width: 50.0,
                                     decoration:const BoxDecoration(
                                         shape: BoxShape.circle
                                     ),
                                     child:ClipRRect(
                                         clipBehavior: Clip.antiAliasWithSaveLayer,
                                         borderRadius: BorderRadius.circular(radius_40),
                                         child:networkImages("$image_url${controller.profileData!.mediaUrl}${controller.profileData!.data!.avatar}",height: 50.0,width: 50.0)
                                     )
                                 ),


                                 sizedBox(height: height_20),
                                 controller.profileData==null?commonText(farmerNameDummyStr.tr,fontSize: font_20,color:drawerHeadingColor):commonText( controller.profileData!.data!.name,fontSize: font_20,color:drawerHeadingColor) ,
                                 sizedBox(height: margin_5),
                                 controller.profileData==null ?commonText("farmer ID: null",fontSize: font_14,color:floatingTextColor,fontWeight: FontWeight.w400):commonText("farmer ID:${controller.profileData!.data!.farmerUniqueId}",fontSize: font_14,color:floatingTextColor,fontWeight: FontWeight.w400),
                               ],
                             );
                           }
                           if(data.connectionState==ConnectionState.waiting){
                             return  _farmerInfoShimmer();
                           }

                           return _farmerInfoShimmer();
                              }

                          )



                        ),
                        sizedBox(height: height_20),
                        const Divider(color: borderColor,),
                        sizedBox(height: height_10),
                        _drawerItemList(),
                      ],
                    ),
                    _logout(),
                  ],
      )

      );








  }

  _farmerInfoShimmer(){
    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerWidget.circular(width: 50.0, height: 50.0),
        sizedBox(height: height_20),
        ShimmerWidget.rectangular(height: 20,width: 100,),
        sizedBox(height: margin_5),
        ShimmerWidget.rectangular(height: 14,width: 120,),
      ],
    );

  }


  _drawerItemList(){
  return  ListView.builder(
        itemCount:controller.drawerItems.length ,
        shrinkWrap: true,
        itemBuilder: (context,index){
     return  _drawerItem(index);
    });


  }


   _drawerItem(index){
    return
    getInkWell(
      ontap: (){
        if(index==0){
          Get.back(closeOverlays: true);
          Get.toNamed(Routes().notifications);
        }
         if(index==1){
            Get.back(closeOverlays: true);
           Get.toNamed(Routes().updateProfileInfo);
         }
         if(index==2){
           Get.back(closeOverlays: true);
           Get.toNamed(Routes().updateAddress);

         }
         if(index==3){
           Get.back(closeOverlays: true);
           Get.toNamed(Routes().languagesPref);
         }
        if(index==4){
          Get.back(closeOverlays: true);
          Get.toNamed(Routes().mySchemes);
        }
        if(index==5){
          Get.back(closeOverlays: true);
          Get.toNamed(Routes().bankDetailsScreen);
        }
        if(index==6){
          Get.back(closeOverlays: true);
          Get.toNamed(Routes().landDetailsScreen);
        }
         },
      widget:
      setPadding(
        leftPadding: margin_20,
        bottomPadding: margin_16,
        topPadding: margin_16,
        widget:index==0?
        commonText(notificationsStr.tr,fontSize: font_14,color:floatingTextColor):
            index==1?
            commonText(personalInfoStr.tr,fontSize: font_14,color:floatingTextColor):
                index==2? commonText(addressStr.tr,fontSize: font_14,color:floatingTextColor):
                    index==3?commonText(languagePreferenceStr.tr,fontSize: font_14,color:floatingTextColor):
                        index==4?commonText( mySchemesStr.tr,fontSize: font_14,color:floatingTextColor):
                        index==5?commonText( bankDetailsStr.tr,fontSize: font_14,color:floatingTextColor):
                       commonText(landDetailsStr.tr,fontSize: font_14,color:floatingTextColor),
        //commonText(controller.drawerItems[index],fontSize: font_14,color:floatingTextColor)
      )
      );
  }





  _logout(){
   return
     getInkWell(
       ontap: (){
         controller.logoutApiCall();
         },
       widget: setPadding(
       leftPadding: margin_20,
       topPadding: margin_16,
       bottomPadding: margin_30,
         widget: Row(
         children: [
           const Icon(Icons.logout,color: circleBgColor,),
           sizedBox(width: margin_10),
           commonText(logoutStr.tr,fontSize: font_14,color:floatingTextColor)
         ],
       ),
     )
     )

   ;


  }





}
