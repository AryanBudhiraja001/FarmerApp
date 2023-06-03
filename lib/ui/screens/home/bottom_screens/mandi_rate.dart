import 'package:farmer_app/ui/shimmer_effect/shimmerWidget.dart';
import 'package:flutter/material.dart';
import '../../../constants/exports.dart';


class MandiRate extends GetView<MandiRateController> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    GetBuilder<MandiRateController>(
      init: MandiRateController(),
      builder: (_){
        return
          Scaffold(

            body: SingleChildScrollView(
              child:setPadding(
                leftPadding: margin_20,
                rightPadding: margin_20,
                topPadding: margin_40,
                bottomPadding: margin_20,
                widget:
                Column(
                  children: [
                    _selectAddressContainer(),
                    sizedBox(height: height_20),
                    _selectCommodity(),
                    sizedBox(height: height_30),

                    controller.mandiPriceModel==null?
                    noDataAvailable(title:noRecordAvailStr.tr)
                      :
                    controller.mandiPriceModel!.data!.data!.isEmpty?
                    noDataAvailable(title:noRecordAvailStr.tr):
                    Column(
                       children: [
                    _selectPriceContainer(),
                         sizedBox(height: height_30),

                          _mandiPriceListView(),
                       ],
                     )

                  ],
                ),
              )
            ),
          );

      },
    )
 );
  }




  _selectAddressContainer(){
     return SizedBox(
         height: 32,
         child:
         ListView.builder(
         itemCount: controller.itemSelected.length,
         shrinkWrap: true,
         scrollDirection: Axis.horizontal,
         itemBuilder: (context,index){
           return _selectContainer(index);

         }))

      ;

  }
  _selectContainer(index){
    return
          getInkWell(
          ontap: (){
          controller.updateSelectContainer(index);
          controller.getDistrictList();
          Get.toNamed(Routes().search,arguments:{"index":index,"itemSelected":
          index==0?controller.listItemSelected.value
          :index==1?controller.listItemSelectedDistrict.value:
            controller.listItemSelectedMandi.value
          })
              ?.then((value) {
            controller.updateItemFun(index,value);
            controller.isLastPage.value=false;
            controller.currentPage.value=1;
      controller.getMandiPriceApiCall();

          });
        },
        widget: Container(
           height: 32,
         margin: EdgeInsets.only(right: margin_20),
          padding: EdgeInsets.symmetric(horizontal: margin_10),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_15),
          border: Border.all(color: controller.selectedItem.value==index?primaryColor:borderColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                commonText(controller.itemSelected[index],color: controller.selectedItem.value==index?primaryColor:subtitleColor,fontWeight: FontWeight.w400,fontSize: font_14),

            Icon(Icons.arrow_drop_down,color: controller.selectedItem.value==index?primaryColor:subtitleColor)
          ],
        ),
        ),
      );


  }



  _selectCommodity(){
       return getInkWell(
         ontap: (){
           Get.toNamed(Routes().search,arguments:{"index":4,"itemSelected":controller.listItemSelectedCommodity.value})?.then((value) {
   controller.selectCommodityItem(value);
   controller.isLastPage.value=false;
   controller.currentPage.value=1;
   controller.getMandiPriceApiCall();

           });
         },
         widget: Row(
           children: [
             commonText(selectCommodityStr.tr,color:subtitleColor,fontWeight: FontWeight.w400,fontSize: font_16,textHeight: 1.5),
              sizedBox(width: margin_20),
             Expanded(
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(radius_4),
                   border: Border.all(color: borderColor)
                 ),
                 child: ListTile(
                   title:commonText(controller.commonditySelectedValue.value,color:paragraphColor,fontWeight: FontWeight.w400,fontSize: font_14),
                   trailing:const Icon(Icons.arrow_drop_down,color:subtitleColor)
                   ),
               ),
             )

           ],
         ),
       );

  }

  _selectPriceContainer(){
    return Row(
      children: [
        _commonPriceContainer(price:controller.mandiPriceModel!.totalMinPrice!.round(),unit: quantalStr.tr,bottomText: miniPriceStr.tr),
        sizedBox(width: margin_10),
        _commonPriceContainer(price: controller.mandiPriceModel!.totalModalPrice!.round(),unit: quantalStr.tr,bottomText: averagePriceStr.tr),
        sizedBox(width: margin_10),
        _commonPriceContainer(price:controller.mandiPriceModel!.totalMaxPrice!.round(),unit: quantalStr.tr,bottomText: maxPriceStr.tr),

      ],
    );
  }
  _commonPriceContainer({price,unit,bottomText}){
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: margin_20,horizontal: margin_10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_15),
          color: thirdColor
        ),
        child: Column(
          children: [
            commonText("$price",color: white,fontSize: font_18),
            sizedBox(height: margin_10),
            commonText(unit,color: white,fontWeight: FontWeight.w400,fontSize: font_12),
            sizedBox(height: margin_10),
            Divider(color: white,),
            sizedBox(height: margin_10),
            commonText(
                bottomText,align:TextAlign.center,color: white,fontWeight: FontWeight.w400,fontSize: font_12),

          ],
        ),
      ),
    );

  }

    _mandiPriceListView(){
    return    controller.isLoadingData.value?loader():FutureBuilder(
          future: controller.futureMandiRate,
          builder: (_,data){
         if(data.connectionState==ConnectionState.done){
           if(data.hasData){
             return _mandiPriceList();
           }
           if(data.hasError){
             return noDataAvailable(title: noDataAvailStr);
           }
         }
         if(data.connectionState==ConnectionState.waiting){
           return _shimmerWidget();
         }
         return _shimmerWidget();

      });


    }


   _mandiPriceList(){
     return
     GetBuilder(
         init: MandiRateController(),
         builder: (mandiController){
   return    Column(
         children: [
           ListView.builder(
               itemCount:controller.mandiPriceModel!.data!.data!.length,
               shrinkWrap: true,
               primary: false,
               itemBuilder: (context,index)
               {
                 return _mandiPriceItem(index);
               }),
           controller.isLastPage.value?_pagesList(controller.totalPages):
           controller.currentPage.value==controller.totalPages?Container():_pagesList(controller.totalPages),
           sizedBox(height: margin_30)
         ],
       );

     });




   }
   _mandiPriceItem(index){
     return Container(
       margin: EdgeInsets.only(bottom: margin_20),
       padding: EdgeInsets.all(margin_20),
       decoration: BoxDecoration(
           border: Border.all(color: borderColor),
           borderRadius: BorderRadius.circular(radius_15)
       ),
       child: Column(
         children: [
           Row(
             crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
              Expanded(child:commonText(controller.mandiPriceModel!.data!.data![index].commodity,fontSize: font_14,color: subtitleColor,fontWeight: FontWeight.w400,textHeight: 1.4),
              ),

               sizedBox(width: margin_20),
               Expanded(
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     commonText(varietyStr.tr,fontSize: font_14,color: paragraphColor),
                     sizedBox(width: margin_5),
                 Expanded(child:commonText(controller.mandiPriceModel!.data!.data![index].variety,fontSize: font_14,color: subtitleColor,fontWeight: FontWeight.w400)
                 )
                   ],
                 ),
               )

             ],
           ),
           sizedBox(height: height_10),
           Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Expanded(child:
                      Row(
                       children: [
                         const Icon(Icons.currency_rupee,color: paragraphColor,size: 24,),
                         commonText(controller.mandiPriceModel!.data!.data![index].modalPrice,fontSize: font_18,color: paragraphColor),
                         commonText(quantalStr,fontSize: font_12,color: paragraphColor,fontWeight: FontWeight.w400),
                       ],
                     ),
                   ),


               sizedBox(width: margin_20),
               Expanded(
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     commonText(dateStr.tr,fontSize: font_14,color: paragraphColor),
                     sizedBox(width: margin_5),
                     Expanded(child:commonText(controller.mandiPriceModel!.data!.data![index].arrivalDate,fontSize: font_14,color: subtitleColor,fontWeight: FontWeight.w400)
                     )
                   ],
                 ),
               )

             ],
           ),
           sizedBox(height: height_10),
           Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children:  [
               const Icon(Icons.location_on_outlined,color: thirdColor,),
               sizedBox(width: margin_5),
               Expanded(child:commonText("${controller.mandiPriceModel!.data!.data![index].market},${controller.mandiPriceModel!.data!.data![index].district}",fontSize: font_14,color: subtitleColor,fontWeight: FontWeight.w400,textHeight: 1.4),
               )
             ],
           )

         ],
       ),
     );


   }


      _shimmerWidget(){
       return ListView.builder(
         shrinkWrap: true,
           primary: false,
           itemCount: 8,
           itemBuilder: (_,index){
         return _shimmerMandiPrice();
       });


      }

   _shimmerMandiPrice(){
    return Stack(
      children: [
        ShimmerWidget.rectangular(height: 120,width: Get.width,),
        Container(
            height: 120,
            margin: EdgeInsets.only(bottom: margin_20),
            padding: EdgeInsets.all(margin_20),
            decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(radius_15)
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWidget.rectangular(height: 16.0,width: 50,),
                    // Expanded(child:commonText(controller.mandiPriceModel!.data![index].commodity,fontSize: font_14,color: subtitleColor,fontWeight: FontWeight.w400,textHeight: 1.4),
                    //  ),

                    sizedBox(width: margin_20),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerWidget.rectangular(height: 16.0,width: 50,),
                          sizedBox(width: margin_5),
                          ShimmerWidget.rectangular(height: 16.0,width: 50,),
                        ]   )
                  ],
                ),

                sizedBox(height: height_10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ShimmerWidget.rectangular(height: 16.0,width: 80,),


                      ],
                    ),

                    ShimmerWidget.rectangular(height: 16.0,width: 100,),
                    sizedBox(width: margin_29)

                  ],
                ),
                sizedBox(height: height_10),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      ShimmerWidget.rectangular(height: 16.0,width:50,),
                      sizedBox(width: margin_5),
                      ShimmerWidget.rectangular(height: 16.0,width: 100,),
                    ]
                )

              ],
            )
        )
      ],
    );



    }






  _pagesList(itemLength){
    return SizedBox(
      height: 50.0,

      child: ListView.builder(
        controller: controller.mandiRateScrollController,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          primary: false,
          itemCount: itemLength,
          itemBuilder: (_,index){
            return _pageItem(index,itemLength);
          }),
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
