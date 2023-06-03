import 'package:flutter/material.dart';
import '../../../constants/exports.dart';

class SchemeDetails extends GetView<SchemesDetailsController> {
   const SchemeDetails({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: customAppBar(
        title: schemesDetailsStr.tr,
      ),
      body:
      GetBuilder<SchemesDetailsController>(
        init: SchemesDetailsController(),
        builder: (_){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: setPadding(
                    leftPadding: margin_20,
                    rightPadding: margin_20,
                    topPadding: margin_40,
                    bottomPadding: margin_40,
                    widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _title(),
                          sizedBox(height: height_18),
                          _subTitle(),
                          sizedBox(height: height_37),
                          _subsidyContainer(),
                          sizedBox(height: height_20),
                          _requiredDocument(),
                             const  Divider(color: dividerColor2,),
                              _details(),
                             const  Divider(color: dividerColor2,),
                             _videos(),

                        ],
                      ),
                    ),
                  ),
              ),

              _applyButton(),
            ],
          )
            ;
        },
      )





    ));
  }

   _title(){
   return commonText(controller.scheme!.schemeName??"null",fontSize: font_18,color: paragraphColor);
  }
  _subTitle(){
    return    Row(
      children: [
        commonText(costNormsStr.tr,color: paragraphColor,fontSize: font_16),
        Expanded(child:commonText(controller.costNorm,color: paragraphColor,fontWeight: FontWeight.w400,fontSize: font_16),)
      ],
    );
  }
  _subsidyContainer(){
   return Container(
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(radius_20),
       border: Border.all(color: borderColor)
     ),
     child:Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           children: [
             Expanded(
               child: Container(
                 padding: EdgeInsets.symmetric(vertical: margin_20,horizontal: margin_20),
                 decoration: BoxDecoration(
                   color: subsidyBgColor,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(radius_20),
                     topRight: Radius.circular(radius_20)
                   )
                 ),
                 child: commonText(subsidyStr.tr,fontSize: font_16,color: white),
               ),
             ),
           ],
         ),
         controller.scheme!.publicSector==null?Container():subsidySubtitle(index:0,title: publicSubStr.tr,des:controller.scheme!.publicSector),
         controller.scheme!.publicSector==null?Container():setPadding(
             leftPadding: margin_20,
             rightPadding: margin_20,
             widget:   divider(color: dividerColor2)
           )
       ,
         controller.scheme!.privateSector==null?Container():subsidySubtitle(index:1,title: privateSubStr.tr,des:controller.scheme!.privateSector),
         sizedBox(height: margin_10),
       ],
     ),
   );


  }

     subsidySubtitle({index,title,des}){
   return Container(
     margin: EdgeInsets.symmetric(vertical: margin_16,horizontal: margin_20),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               commonText(title,fontSize: font_16,color: paragraphColor),
              getInkWell(
                ontap: (){
                  controller.selectedSubsidySector(index);
                },
                widget:
                Radio(
                  activeColor: primaryColor,
                  onChanged:(value){
                    controller.selectedSubsidySector(index);
                      localStorage.write(LocalStorageConstants().selectedSector, index);
                      var saveValue=localStorage.read(LocalStorageConstants().selectedSector);
                      debugPrint("selected Sector is ${saveValue.toString()}");
                  } ,
                  groupValue:index,
                  value: controller.selectedIndex.value,

                ),
              ),

             ],
           ),

         sizedBox(height: margin_16),
         commonText(des,fontSize: font_14,color: subtitleColor,fontWeight: FontWeight.w400,maxLines: 5,textHeight: 1.5),
       ],
     ),
   );

  }


  _requiredDocument(){
   return
   GetBuilder<SchemesDetailsController>(
       init:SchemesDetailsController(),
       id: "requiredDocuments",
       builder: (_){
      return      ExpansionTile(
          initiallyExpanded:controller.selectedTile.value==1,
          maintainState:controller.termsExpansion.value,
          onExpansionChanged: (value){
            controller.updateTerms(value);
            controller.updateDetails(false);
            controller.updateVideos(false);
          },
          trailing: controller.termsExpansion.value?const Icon(Icons.expand_more,color: paragraphColor,):const Icon(Icons.arrow_forward_ios,size: 16,color: paragraphColor,),
          title: commonText(requiredDocumentStr.tr,fontSize: font_18,color: paragraphColor),
          children:[
            _requiredDocumentList(),
            sizedBox(height: margin_20),
          ]
      );

   });
  }
    _requiredDocumentList(){
   return  controller.terms.isEmpty?
   noDataAvailable(title:noRequiredDocumentStr.tr,): ListView.builder(
        shrinkWrap: true,
          primary: false,
          itemCount:controller.terms.length,
          itemBuilder: (context,index){
           if(index==0){
             return controller.terms[index].terms==null? noDataAvailable(title:noRequiredDocumentStr.tr,):
             _requiredDocumentItem(index);
           }else{
             return controller.terms[index].terms==null?Container():
             _requiredDocumentItem(index);
           }

      });

       }

   _requiredDocumentItem(index){
     return Container(
       margin: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_5),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Column(
                 children: [
                   sizedBox(height: margin_10),
                   Container(
                     height: 8,
                     width: 8,
                     decoration: const BoxDecoration(
                         color: circleColor,
                         shape: BoxShape.circle
                     ),
                   ),
                 ],
               ),
               sizedBox(width: margin_16),
               Expanded(child: commonText(controller.terms[index].terms,fontSize: font_16,color:subtitleColor,fontWeight: FontWeight.w400,textHeight: 1.5))
             ],
           ),
           sizedBox(height: margin_20)
         ],
       ),
     );

    }


  _details(){

    return
    GetBuilder<SchemesDetailsController>(

        init: SchemesDetailsController(),
        id: "Details",
        builder: (_){
          return       ExpansionTile(
              initiallyExpanded: controller.selectedTile.value==2,
          // maintainState:controller.detailsExpansion.value ,
          onExpansionChanged: (value){
            controller.updateDetails(value);
            controller.updateTerms(false);
            controller.updateVideos(false);
          },
          trailing: controller.detailsExpansion.value?const Icon(Icons.expand_more,color: paragraphColor,): const Icon(Icons.arrow_forward_ios,size: 16,color: paragraphColor,),
          title: commonText(detailedDesciptionStr.tr,fontSize: font_18,color: paragraphColor),

          children:[
            ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                controller.scheme!.detailedDescription==""?
                commonText(noDesAvailStr.tr,color:paragraphColor):
                setPadding(
                  leftPadding: margin_20,
                  rightPadding: margin_20,
                  widget:commonTextDescription(controller.scheme!.detailedDescription??"null",fontSize: font_16,color: paragraphColor,fontWeight: FontWeight.w400),
                ),
                sizedBox(height: margin_20),
              ],
            )

          ]

      );
    });





  }
  _videos(){
    return
      GetBuilder<SchemesDetailsController>(

        id: "Video",
          init: SchemesDetailsController(),
          builder: (_){
    return
        ExpansionTile(
            initiallyExpanded:controller.selectedTile.value==3,
            // maintainState: controller.videosExpansion.value,
            onExpansionChanged: (value){
              controller.updateDetails(false);
              controller.updateTerms(false);
              controller.updateVideos(value);
            },
            trailing: controller.videosExpansion.value?const Icon(Icons.expand_more,color: paragraphColor,):const Icon(Icons.arrow_forward_ios,size: 16,color: paragraphColor,),
            title: commonText(videosStr.tr,fontSize: font_18,color: paragraphColor),
            children:[
              controller.video.isEmpty?
              noDataAvailable(title: noVideoAvailStr.tr):
              _videoList(),
              sizedBox(height: height_40)
            ]
        );
      });

  }

  _videoList(){
    return  AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount:controller.video.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              // verticalOffset: 50.0,
              child: FadeInAnimation(
                  child:
                  controller.ids.isEmpty?
                 noDataAvailable(title: noVideoAvailStr.tr):
                  _videoItem(index)
              ),
            ),
          );
        },
      ),
    );
  }

  _videoItem(index){
    return
     setPadding(
       topPadding: margin_10,
       widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _videoThumbNail(index),
               _videoTitle(index),
            ],
       ),
     );

  }
  
  _videoTitle(index){
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin_20),
      child:commonText(controller.video[index].title,fontSize: font_14,color:headingColor,textHeight: 1.4)
    );
  }

  _videoThumbNail(index){
      return getInkWell(
      ontap: (){
        Get.toNamed(Routes().schemesVideoPlay,arguments:{"id":controller.ids[index],"title":controller.video[index].title});
      },
      widget: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(radius_18),
        child: Container(
          height: 212,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_18),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  child:Image.network('https://img.youtube.com/vi/${controller.ids[index]}/mqdefault.jpg',fit: BoxFit.fill,width: double.infinity,height: 212,)
              ),
              Icon(Icons.play_circle,color: white,size: 40,),
            ],
          ),
        ),
      ),
    );

  }



  _applyButton(){

    return Container(
      width: double.infinity,
      padding:EdgeInsets.symmetric(vertical: margin_20) ,
      decoration: BoxDecoration(
          color: white,
          border: const Border(
              top: BorderSide(color: borderColor)
          )
      ),
      child:setPadding(
          leftPadding: margin_20,
          rightPadding: margin_20,
          widget:
          ElevatedButton(onPressed: (){
            Get.delete<CompleteDetailsScreensController>();
             Get.toNamed(Routes().completeDetailsScreen,arguments:{"scheme":controller.scheme,"isSchemeResubmit":SCHEMES_SUBMIT});
             },
            style:ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(margin_25)
                ),
                padding: EdgeInsets.symmetric(vertical:margin_20,horizontal:margin_10)
            ),

            child: commonText(proceedStr.tr,color: white,fontWeight: FontWeight.w500,fontSize: font_14,letterSpacing:1.25),
          )
      ),
    );


  }

}
