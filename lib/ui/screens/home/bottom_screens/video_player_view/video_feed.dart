import 'package:flutter/material.dart';
import '../../../../constants/exports.dart';
import '../../../../shimmer_effect/shimmerWidget.dart';


class VideoFeed extends GetView<VideoFeedController> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<VideoFeedController>(
     init: VideoFeedController(),
      id: "video",
      builder: (_){
       return Scaffold(
          body: setPadding(
            leftPadding: margin_20,
            rightPadding: margin_20,
            topPadding: margin_40,
             // bottomPadding: margin_20,
            widget: Column(
              children: [
                _searchEditText(),
                 sizedBox(height: height_10),
                controller.isLoadingVideo.value?loader():
                 Expanded(
                   child: GetBuilder<VideoFeedController>(
                     init:VideoFeedController() ,
                       id:"videoList",
                       builder: (_){
                     return       FutureBuilder(
                         future: controller.videoFutureData,
                         builder: (context,data){

                           if(data.connectionState==ConnectionState.done){
                             if(data.hasData){
                               return _videoFeedList();
                             }
                           }
                           if(data.connectionState==ConnectionState.waiting)
                           {
                             return ListView.builder(
                                 itemCount: 3,
                                 shrinkWrap: true,
                                 primary: true,
                                 itemBuilder: (context,index){
                                   return setPadding(
                                       bottomPadding: margin_20,
                                       widget:_videoShimmerContainer()
                                   );
                                 });
                           }
                           if(data.hasError){
                             return  controller.errorMessage.value==""?
                             noDataAvailable(title: noVideoAvailStr.tr):
                             noDataAvailable(title:controller.errorMessage.value);
                           }
                           return ListView.builder(
                               itemCount: 3,
                               shrinkWrap: true,
                               primary: false,
                               itemBuilder: (context,index){
                                 return setPadding(
                                     bottomPadding: margin_20,
                                     widget:_videoShimmerContainer()
                                 );
                               }
                               );
                         });
                     }),
                 )
              ],
            ),
          ),
        );
      },
    ),
    );
  }



  _searchEditText(){
    return CommonTextField(
      controller: controller.searchController,
      showFloating: false,
      hideHelperText: true,
      // focusNode: controller.searchFocusNode,
      suffix: getInkWell(
          ontap: (){
            controller.currentPage.value=1;
            controller.videosIds.clear();
            controller.searchFetchVideos();
            controller.refreshScreen();
            disableKeyboard();
            },
          widget: Icon(Icons.search,color: black,)),
      onChanged: (value){
        controller.keyword.value=value;
        if(value==""){
          controller.currentPage.value=1;
           controller.videosIds.clear();
         controller.isLastPage.value=false;
          controller.fetchVideos();
          controller.refreshScreen();
          disableKeyboard();

        }
        debugPrint('keyword is $value');
        },
      labelText: searchStr.tr,
    );
  }

  _videoFeedList(){
    return
      controller.videosIds.isEmpty?noDataAvailable(title: noVideoAvailStr.tr):
      SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
            primary: false,
            separatorBuilder: (context,index){
              return Divider(color: dividerColor2,);
            },
              shrinkWrap: true,
              itemCount:controller.videosIds.length,
              itemBuilder: (context,index){
              return  _videoItem(index);
               }),

            controller.isLastPage.value?_pagesList(controller.totalPages.value):
            controller.currentPage.value==controller.totalPages.value?Container():_pagesList(controller.totalPages.value),
              //_bottomPaginationButtons(),
            sizedBox(height: margin_20),
          ],
        ),
      );

  }

  _videoItem(index) {
    return  setPadding(
      topPadding: margin_20,
      bottomPadding: margin_20,
      widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _videoThumbNail(index),
            sizedBox(height: margin_20),
            commonText(
                controller.videoModel!.data!.data![index].title, fontSize: font_16, color: headingColor,textHeight: 1.4),
            sizedBox(height: margin_10),
            Row(
              children: [
                commonText(  "${controller.videoViews[index]} ${viewsStr.tr}", fontSize: font_14,
                    color: subtitleColor,
                    fontWeight: FontWeight.w400),
                sizedBox(width: margin_16),
                Container(
                  height: 3,
                  width: 3,
                  margin: EdgeInsets.only(right: margin_3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: subtitleColor
                  ),
                ),
                sizedBox(width: margin_10),
                controller.timeAgoList.isEmpty?commonText(noTimeAvailStr.tr, fontSize: font_14,
                    color: subtitleColor,
                    fontWeight: FontWeight.w400):
                commonText(controller.timeAgoList[index], fontSize: font_14,
                    color: subtitleColor,
                    fontWeight: FontWeight.w400),
              ],
            )
          ],
        ),
    );
    }

    _videoThumbNail(index){
      return getInkWell(
        ontap: (){
          Get.toNamed(Routes().videoPlay,arguments:{"id":controller.videosIds[index],"title":controller.videoModel!.data!.data![index].title,"views":controller.videoViews[index],"time":controller.timeAgoList[index]});
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
                  child:

                  CachedNetworkImage(imageUrl:controller.videoThumbNail[index],
                    height:  212,
                    fit:BoxFit.fill,
                    width: double.infinity ,
                    errorWidget: (context, url, error)=>assetImage(image: coldStorageIcon,height: 212.0,width:fullWidth()),
                  )
                ),
                Icon(Icons.play_circle,color: white,size: 40,),
              ],
            ),
          ),
        ),
      );


    }

   _bottomPaginationButtons(){
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
         controller.currentPage.value==controller.totalPages.value?Container():
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


  _pagesList(itemLength){
    return SizedBox(
      height: 50.0,
      child: ListView.builder(
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




   _videoShimmerContainer(){
     return
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           ShimmerWidget.rectangular(height: 214,
             width: double.infinity,
           ),
           sizedBox(height: margin_20),
           ShimmerWidget.rectangular(height: 20,
             width: double.infinity,
           ),
           sizedBox(height: margin_10),
           ShimmerWidget.rectangular(height: 16,
             width:200,
           ),
           sizedBox(height: margin_10),
           Row(
             children: [
               ShimmerWidget.rectangular(height: 16,
                 width:100,
               ),
               sizedBox(width: margin_16),

               sizedBox(width: margin_10),
               ShimmerWidget.rectangular(height: 16,
                 width:100,
               ),
             ],
           )
         ],
       );

   }

}
