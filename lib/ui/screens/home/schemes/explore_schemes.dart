

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../constants/exports.dart';
import '../../../shimmer_effect/shimmerWidget.dart';

class ExploreSchemes extends GetView<ExploreSchemeController> {
   ExploreSchemes({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return  SafeArea(child: GetBuilder<ExploreSchemeController>(
                 init: ExploreSchemeController(),
                  builder: (controller) {
                    return Scaffold(
                      appBar: customAppBar(
                          title:controller.title??"null",
                      ),
                      body:
                          SingleChildScrollView(
                            child:    setPaddingAll(
                              margin: margin_20,
                              widget: Column(
                                children: [
                                  _filterView(),
                                 _schemesView(),


                                ],
                              ),
                            ),
                          )




                    );
            }),);





       }





       _filterView(){
    return   FutureBuilder(
        future: controller.futureComponentData,
        builder: (_,data){
          if(data.connectionState==ConnectionState.done){
            if(data.hasData){
              return controller.componentList.isEmpty?Container():
              controller.applyFilterShow.value?_applyFilterView():_showFilter(title: showFilterStr.tr,icon: Icons.expand_more);
            }
            if(data.hasError){
              return Container();
            }
          }
          if(data.connectionState==ConnectionState.waiting){
            return _filterShimmerWidget();
          }
          else {
            return _filterShimmerWidget();
          }

        });

       }


       _showFilter({title,IconData? icon}){
        return getInkWell(
          ontap: (){
            controller.showApplyFilter();
            },
          widget: setPadding(bottomPadding: margin_10,
            widget: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
              commonText(title,fontSize: font_12,color: subtitleColor),
                  sizedBox(width: margin_8),
                   Icon(icon,size: 30,color: subtitleColor,),
                ],
              ),
          ),
        );
       }

      _applyFilterView(){

        return   GetBuilder<ExploreSchemeController>(
          id:"filter",
            builder: (_){
          return   setPadding(
            bottomPadding: margin_20,
            widget: Column(
              children: [
                _selectComponent(),
                controller.subComponentList.isEmpty?Container():sizedBox(height: margin_20),
                controller.subComponentList.isEmpty?Container():_selectSubComponent(),
                sizedBox(height: margin_30),
                _searchFilterButton(),
                sizedBox(height: margin_20),
                _showFilter(title: showLessStr.tr,icon: Icons.expand_less),
                // sizedBox(height: margin_20),
                divider(color: dividerColor2),
              ],
            ),
          );


        });


      }


      _selectComponent(){
     return  CommonTextField(
        controller: controller.componentEditController,
       readOnly: true,
       inputActions: TextInputAction.next,
       hideHelperText: true,
       suffix: _componentMenu(),
     );
   }
   _componentMenu(){
     return DropdownSearch<dynamic>(
       popupProps: PopupProps.menu(
         fit: FlexFit.loose,
         showSelectedItems: false,
         // textStyle:GoogleFonts.roboto(
         //     textStyle:
         //     TextStyle(
         //         letterSpacing:  0.28,
         //         color:paragraphColor,
         //         fontSize:font_14,
         //         fontWeight:FontWeight.w400,
         //         overflow: TextOverflow.ellipsis)),
       ),
       items: controller.componentNameList,
       dropdownDecoratorProps: DropDownDecoratorProps(

           dropdownSearchDecoration: InputDecoration(
             contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
             border: InputBorder.none,
           )
       ),
       onChanged: (value){
         controller.subComponentList.clear();
         controller.subComponentNameList=[allStr,];
         controller.subComponentEditController.text="all";
          var index=  controller.componentNameList.indexOf(value);
          if(index!=0){
                 controller.subComponentList.clear();
                 controller.subComponentNameList=[allStr,];
                 controller.getSubComponentList(index-1);
                 var componentId=  controller.componentList[index-1].componentId;
                 debugPrint("selected component id $componentId and subcomponet${index-1}");
                 controller.componentSelectFromMenu(componentId,index);
                 controller.subComponentSelectFromMenu(0, 0);
               }
              if(index==0){
                controller.componentIdSelect.value =0;
                controller.subComponentIdSelect.value =0;
                controller.componentSelect.value=0;
                controller.componentEditController.text=controller.componentNameList[index];
                controller.subComponentList.clear();
                controller.subComponentEditController.text=controller.subComponentNameList[index];
              }
              controller.refreshFilterView();
              },
       selectedItem:controller.componentEditController.text
     );
   }

   _selectSubComponent(){
     return     CommonTextField(
         controller: controller.subComponentEditController,
         readOnly: true,
       hideHelperText: true,
         inputActions: TextInputAction.next,
         suffix: _subComponentMenu(),
       );
   }
   _subComponentMenu(){
     return DropdownSearch<dynamic>(
       popupProps: PopupProps.menu(
         fit: FlexFit.loose,
         showSelectedItems: false,
         // textStyle:GoogleFonts.roboto(
         //     textStyle:
         //     TextStyle(
         //         letterSpacing:  0.28,
         //         color:paragraphColor,
         //         fontSize:font_14,
         //         fontWeight:FontWeight.w400,
         //         overflow: TextOverflow.ellipsis)),
       ),
       items: controller.subComponentNameList,
         dropdownDecoratorProps: DropDownDecoratorProps(

           dropdownSearchDecoration: InputDecoration(
             contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
             border: InputBorder.none,
           )
       ),
       onChanged: (value){
         var index=  controller.subComponentNameList.indexOf(value);
         if(index!=0){
           var subcomponentId=  controller.subComponentList[index-1].subComponentId;
           debugPrint("selected component id $subcomponentId and subcomponet${index-1}");
           controller.subComponentSelectFromMenu(subcomponentId,index);
         }
         if(index==0){
           controller.subComponentIdSelect.value =0;
           controller.subComponentSelect.value=0;
           controller.componentEditController.text=controller.subComponentNameList[index];
         }
         },
       selectedItem:controller.subComponentEditController.text
     );
   }




       _schemesView(){
        return
          GetBuilder<ExploreSchemeController>(
          id: "schemes",
          builder: (_){
          return controller.isLoadingSchemes.value?loader(): FutureBuilder(
                future: controller.futureSchemesData,

                builder: (_,data){
                  if(data.connectionState==ConnectionState.done){
                    if(data.hasData){
                      return  schemesList() ;
                    }
                    if(data.hasError){
                      return noDataAvailable(title: noSchemesStr);
                    }

                  }
                  if(data.connectionState==ConnectionState.waiting){
                    return _shimmerList();
                  }
                  else {
                    return _shimmerList();
                  }

                });
          },

        );


       }


   schemesList(){
   return
     controller.schemesList.isEmpty?
     noDataAvailable(title:noSchemesStr.tr):
     Column(
       children: [
         AnimationLimiter(
           child: ListView.builder(
               shrinkWrap: true,
               primary: false,
               itemCount:controller.schemesList.length,
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

         )),
    //  _bottomButtons(),

         controller.isLastPage.value?_pagesList(controller.totalPages):
         controller.currentPage.value==controller.totalPages?Container():_pagesList(controller.totalPages)
       ],
     );


   }




   schemesItem(index){
   return
      Container(
       margin:EdgeInsets.only(bottom: margin_20),
        padding: EdgeInsets.all(margin_20),
       decoration: BoxDecoration(
        border: Border.all(color: borderColor),
         borderRadius: BorderRadius.circular(radius_10),

       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           itemTitle(index),
           sizedBox(height: height_20),
           _subTitle(index),
           sizedBox(height: height_20),
       //     controller.schemesIDList.isNotEmpty?controller.schemesIDList.contains(controller.schemesList[index].id)?commonText(alreadyAppliedStr.tr,color: redColor):
       // _knowMoreButton(index): _knowMoreButton(index),

           _knowMoreButton(index)
         ],
       ),
      );


   }
   itemTitle(index){
    return commonText(controller.schemesList[index].schemeName,fontSize: font_18,color: headingColor);

  }
  _subTitle(index){
   return Column(
     children: [
       Row(children: [
         controller.schemesList[index].publicRange==0? Container():
         Row(
           children: [
             commonText(publicSubStr.tr,color: paragraphColor,fontSize: font_14),
             commonText(" ${controller.schemesList[index].publicRange}%",color: paragraphColor,fontWeight: FontWeight.w400,fontSize: font_14),

           ],
         ),

         controller.schemesList[index].publicRange==0? Container(): sizedBox(width: margin_20),
         controller.schemesList[index].privateRange==0? Container():
         Row(
           children: [
             commonText(privateSubStr.tr,color: paragraphColor,fontSize: font_14),
             commonText("${controller.schemesList[index].privateRange}%",color: paragraphColor,fontWeight: FontWeight.w400,fontSize: font_14),

           ],
         ),
       ]),
       sizedBox(height: margin_20),
       Row(
         children: [
           commonText(costNormsStr,color: paragraphColor,fontSize: font_14),
           Expanded(child:commonText(controller.costNorm[index],color: paragraphColor,fontWeight: FontWeight.w400,fontSize: font_14),)
         ],
       )
      ] ,
   );

  }

  _knowMoreButton(index){
    return getInkWell(
      ontap: (){
        Get.toNamed(Routes().schemesDetails,arguments:controller.schemesList[index]);
         },
      widget: Container(

        padding: EdgeInsets.symmetric(vertical: margin_10,horizontal: margin_20),
        decoration: BoxDecoration(
          border: Border.all(color:knowMoreBorderColor),
          borderRadius: BorderRadius.circular(radius_24)

        ),
        child:Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonText(knowMoreStr.tr,fontSize: font_12,color:knowMoreBorderColor),
            sizedBox(width: width_15),
            Icon(Icons.arrow_forward,color: knowMoreBorderColor,)
          ],
        ) ,
      ),
    );
  }

     _shimmerList(){

     return   ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (_,index){
          return _schemesShimmerWidget();
        });

     }

   _filterShimmerWidget() {
     return Align(
       alignment: Alignment.topRight,
       child: setPadding(
           bottomPadding: margin_20,
           widget: ShimmerWidget.rectangular(width: 100, height: 14,color: Colors.grey.shade400,)),
     );
  }

  _schemesShimmerWidget() {
     return setPadding(
       bottomPadding: margin_10,
       widget: Stack(
         children: [
           ShimmerWidget.rectangular(width: 325, height: 220,color: Colors.grey.shade400,),
           Container(
             height: 200,
             width: 320,
             margin: EdgeInsets.only(right: margin_20),
             child: setPadding(
               leftPadding: margin_20,
               widget: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   ShimmerWidget.rectangular(
                     height: 20,
                     width: 100.0,
                     color: shimmerColor,
                   ),
                   ShimmerWidget.rectangular(
                     height: 14,
                     width: 100.0,
                     color: shimmerColor,
                   ),
                   ShimmerWidget.rectangular(
                     height: 14,
                     width: 100.0,
                     color: shimmerColor,
                   ),
                   ShimmerWidget.rectangular(
                     height: 30,
                     width: 120.0,
                     color: shimmerColor,
                   ),
                 ],
               ),
             ),
           ),
         ],
       ),
     );
   }


  _searchFilterButton(){
        return getInkWell(
          ontap: (){
              controller.currentPage.value=1;
               controller.isLastPage.value=false;
            controller.fetchSchemesApiData();
            controller.showApplyFilter();
             // _controller.refreshScreen();
          },
          widget: Container(
            alignment: Alignment.center,
             padding: EdgeInsets.symmetric(vertical: margin_16),
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_50),
              border: Border.all(color: primaryColor)
            ),
            child: commonText(searchStr.toUpperCase().tr,color: primaryColor,fontSize: font_14,),
          ),
        );

  }

  _pagesList(itemLength){
      return SizedBox(
        height: 50.0,
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                   shrinkWrap: true,
                   primary: false,
                   itemCount: itemLength,
                  itemBuilder: (_,index){
                     return _pageItem(index,itemLength);
              }),
            ),
          ],
        ),
      );
   }
   
   _pageItem(index,itemLength){
     return getInkWell(
         ontap: (){
           controller.currentPage.value=index+1;
           controller.goToPageClicked(controller.currentPage.value);
           if(controller.currentPage.value==itemLength){
             controller.isLastPage.value=true;
           }
           },
       widget: Container(
           height: 50,
         width: 50,
         margin: EdgeInsets.symmetric(horizontal: margin_5),
           alignment: Alignment.center,
         decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index+1==controller.currentPage.value?thirdColor:disableButtonColor,
              ),
         child: commonText("${index+1}",color: index+1==controller.currentPage.value?white:paragraphColor) ,
           ),
     );
     
     
     }
   
      
}
