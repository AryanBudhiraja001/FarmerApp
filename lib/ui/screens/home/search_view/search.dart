import 'package:farmer_app/ui/shimmer_effect/shimmerWidget.dart';
import 'package:flutter/material.dart';

import '../../../constants/exports.dart';



class Search extends GetView<SearchController> {

   Search({Key? key}) : super(key: key);

   final TextEditingController _searchController=TextEditingController();
   @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<SearchController>(
      init:SearchController() ,
      builder: (_){
      return  WillPopScope(
        onWillPop: ()async{
         Get.back(result:
          controller.selectedIndex.value==0? controller.stateList[controller.selectItem.value]:
          controller.selectedIndex.value==1?controller.districtList[controller.selectItem.value]:
          controller.selectedIndex.value==2? controller.mandiList[controller.selectItem.value]:
          controller.commodity[controller.selectItem.value]
          );
         return true;
        },
        child: Scaffold(
          appBar:_searchAppBar(),
          body:setPaddingAll(
              margin: margin_20,
              widget: Column(
                children: [
                  _searchEditText(),
                  sizedBox(height: height_20),
                 // controller.districtList.isEmpty?
                 // circularIndicator():
                  Expanded(
                      child: controller.foundUsers.isNotEmpty
                          ? ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context,index)=>divider(color: dividerColor2),
                        itemCount: controller.foundUsers.length,
                        itemBuilder: (context, index) =>
                            getInkWell(
                              ontap: (){
                                controller.selectItemFun(index);
                                Get.back(result:controller.foundUsers[controller.selectItem.value]);
                              },
                              widget: Container(
                                padding: EdgeInsets.all(margin_16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   commonText(controller.foundUsers[index],color: black),
                                ],
                                ),
                              ),
                            ),
                      )
                          :FutureBuilder(
                          future:controller.futureDistrictData,

                          builder: (_,data){
                            if(data.connectionState==ConnectionState.done){
                               if(data.hasData){
                                 return       ListView.separated(
                                   shrinkWrap: true,
                                   physics: BouncingScrollPhysics(),
                                   separatorBuilder: (context,index)=>divider(color: dividerColor2),
                                   itemCount:controller.selectedIndex.value==0?
                                   controller.stateList.length:controller.selectedIndex.value==1?
                                   controller.districtList.length:controller.selectedIndex.value==2?
                                   controller.mandiList.length:controller.commodity.length,
                                   itemBuilder: (context, index) =>_listItem(index),
                                 );
                               }
                               if(data.hasError){
                                 return noDataAvailable(title: noDataAvailStr);
                               }


                            }

                            if(data.connectionState==ConnectionState.waiting){
                              return listShimmer();
                            }


                          return  listShimmer();
                         })



                  ),
                ],
              ),
            ),
          ),
      );

      },

    ));
  }


    _searchAppBar(){
    return AppBar(
      centerTitle: false,
      leading: null,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          getInkWell(
              widget:Icon(Icons.arrow_back,color: white,),
              ontap: (){
                Get.back(result:
                controller.selectedIndex.value==0? controller.stateList[controller.selectItem.value]:
                controller.selectedIndex.value==1?controller.districtList[controller.selectItem.value]:
                controller.selectedIndex.value==2? controller.mandiList[controller.selectItem.value]:
                controller.commodity[controller.selectItem.value]
                );
              }
          ),
          sizedBox(width: margin_20) ,
           commonText(selectStr.tr, color: white, fontSize: font_20),
        ],
      ),
      backgroundColor: secondaryColor,
    );


    }
  _searchEditText(){
    return CommonTextField(
      controller: _searchController,
      showFloating: false,
      hideHelperText: true,
      suffix: Icon(Icons.search,color: black,),
      onChanged: (value){
        _runFilter(value);
        },
      labelText: searchStr.tr,
    );
  }

   void _runFilter(String enteredKeyword) {
     List results = [];
     if (enteredKeyword.isEmpty) {
       results =
       controller.selectedIndex.value==0? controller.stateList:
       controller.selectedIndex.value==1? controller.districtList:
       controller.selectedIndex.value==2? controller.mandiList:
       controller.commodity;
     } else {
       if(controller.selectedIndex.value==0){
            results ==  controller.stateList.where((user) =>
                user.toLowerCase().contains(enteredKeyword.toLowerCase()))
                .toList() ;
          }
          if(controller.selectedIndex.value==1){
          results=  controller.districtList.where((districtList) =>
              districtList.toLowerCase().contains(enteredKeyword.toLowerCase()))
                .toList();
          }
          if(controller.selectedIndex.value==2){
         results=   controller.mandiList.where((user) =>
                user.toLowerCase().contains(enteredKeyword.toLowerCase()))
                .toList();

          }
          if(controller.selectedIndex.value==4){
            results=  controller.commodity.where((user) =>
                user.toLowerCase().contains(enteredKeyword.toLowerCase()))
                .toList();
          }

     }
     controller.foundUserFun(results);
  }

  _listItem(index){
    return  getInkWell(
        ontap: (){
          controller.selectItemFun(index);
          Get.back(result: controller.selectedIndex.value==0?controller.stateList[controller.selectItem.value]:
          controller.selectedIndex.value==1?controller.districtList[controller.selectItem.value]:
          controller.selectedIndex.value==2?controller.mandiList[controller.selectItem.value]:
          controller.commodity[controller.selectItem.value]
          );
        },
        widget:
        Container(
                  padding: EdgeInsets.all(margin_16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      controller.selectedIndex.value==0?
                      commonText(controller.stateList[index],color: black):
                      controller.selectedIndex.value==1?
                      commonText(controller.districtList[index],color: black):
                      controller.selectedIndex.value==2?
                      commonText(controller.mandiList[index],color: black):
                      commonText(controller.commodity[index],color: black),
                      controller.selectItem.value==index?Icon(Icons.check_circle,color: primaryColor,):Container(),
                    ],
                  ),
                ),
             );

  }



  listShimmer(){
    return
    ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (_,index){
        return
        setPaddingAll(
          margin: margin_10,
          widget:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget.rectangular(height: 20.0,width:100,),
                  ShimmerWidget.circular(height: 20.0,width:40,)
                ],
              ),



        )
          ;
      },
    );
  }
}
