import 'package:farmer_app/ui/shimmer_effect/shimmerWidget.dart';
import 'package:flutter/material.dart';

import '../../../constants/exports.dart';

class HomeScreen extends GetView<HomeController> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
         Scaffold(
            body: GetBuilder<HomeController>(
         init: HomeController(),
    builder: (_) {
           return SingleChildScrollView(
    child: setPadding(
    //leftPadding: margin_20,
   // rightPadding: margin_20,
    topPadding: margin_40,
    bottomPadding: margin_40,
    widget: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      setPadding(
        leftPadding: margin_20,
         rightPadding: margin_20,
        widget:  _weatherContainer(),
      ),

    sizedBox(height: height_40),
   setPadding(
    // leftPadding: margin_20,
   //  rightPadding: margin_20,
     widget:_featureSchemes(),
   ),

    sizedBox(height: height_40),
    setPadding(
      leftPadding: margin_20,
      rightPadding: margin_20,
      widget:  _mandiPriceContainer(),
    ),

    sizedBox(height: height_40),
    setPadding(
      leftPadding: margin_20,
      rightPadding: margin_20,
      widget:    _todayInformationView(),

    )

    ],
    ),
    ),
    );
    })));
  }

  _weatherContainer() {
    return FutureBuilder(
        future: controller.futureWeatherData,
        builder: (context, data) {
          if (data.connectionState == ConnectionState.done) {
            if (data.hasData) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(margin_25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius_15),
                    gradient: const LinearGradient(colors: [
                      gradientColor1,
                      gradientColor2,
                    ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller
                                          .weatherModel!
                                          .list![
                              controller.currentTimeLine.value]
                                          .weather![0]
                                          .icon !=
                                      null
                                  ? assetImage(
                                      image:
                                          "$weatherIcon${controller.weatherModel!.list![controller.currentTimeLine.value].weather![0].icon}@2x.png",
                                      height: 32.0,
                                    )
                                  : assetImage(
                                      image: weatherIconDefault, height: 28.0),
                              sizedBox(height: height_10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  controller
                                              .weatherModel!
                                              .list![controller
                                                  .currentTimeLine.value]
                                              .main!
                                              .temp !=
                                          null
                                      ? commonText(
                                      controller
                                              .weatherModel!
                                              .list![controller
                                                  .currentTimeLine.value]
                                              .main!
                                              .temp
                                              .toString(),
                                          color: white,
                                          fontSize: font_30)
                                      : commonText("31.14", color: white),
                                  Container(
                                    padding: EdgeInsets.all(margin_3),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: white, width: 2)),
                                  )
                                ],
                              )
                            ],
                          ),
                          sizedBox(width: width_20),
                          VerticalDivider(
                            color: white.withOpacity(0.14),
                            thickness: 1,
                          ),
                          sizedBox(width: width_20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller
                                            .weatherModel!
                                            .list![controller
                                                .currentTimeLine.value]
                                            .weather![0]
                                            .description !=
                                        null
                                    ? commonText(
                                    controller
                                            .weatherModel!
                                            .list![controller
                                                .currentTimeLine.value]
                                            .weather![0]
                                            .description!,
                                        color: white,
                                        fontSize: font_16)
                                    : commonText(cloudsStr.tr, color: white),
                                sizedBox(height: height_10),
                                controller.address.value == ""
                                    ? ShimmerWidget.rectangular(
                                        height: 20.0,
                                        width: 100.0,
                                )
                                    : commonText(
                                    controller.address.value,
                                        color: white,
                                        fontSize: font_14,
                                        fontWeight: FontWeight.w400,
                                        maxLines: 3,
                                        textHeight: 1.4)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedBox(height: height_20),
                    _seeAllButton(
                        buttonText: seeAllStr.tr,
                        onclick: () {
                          Get.toNamed(Routes().todayWeather);
                        }),
                  ],
                ),
              );
            }
            if (data.hasError){
              return noDataAvailable(title:noDataAvailStr.tr);
            }
          }
          return _todayWeatherShimmerContainer();
        });
  }

  _seeAllButton({buttonText, onclick}) {
    return getInkWell(
      ontap: onclick,
      widget: Container(
        padding:
            EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_20),
        decoration: BoxDecoration(
            color: white,
            // border: Border.all(color:knowMoreBorderColor),
            borderRadius: BorderRadius.circular(radius_24)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonText(buttonText,
                letterSpacing: 1.07, fontSize: font_12, color: primaryColor),
            sizedBox(width: width_15),
            const Icon(
              Icons.arrow_forward,
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }

  _todayWeatherShimmerContainer() {
    return
     Stack(
        children: [
          ShimmerWidget.rectangular(
            height: 200,
            width: double.infinity,

          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(margin_25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ShimmerWidget.circular(width: 40.0, height: 40.0

                          ),
                          sizedBox(height: height_10),
                          ShimmerWidget.rectangular(width: 100.0, height: 20,
                          ),
                        ],
                      ),
                      sizedBox(width: width_20),
                      VerticalDivider(
                        color: black.withOpacity(0.14),
                        thickness: 1,
                      ),
                      sizedBox(width: width_20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerWidget.rectangular(width: 80.0, height: 14),
                            sizedBox(height: height_10),
                            Expanded(
                                child: ShimmerWidget.rectangular(height: 40)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBox(height: height_20),
                ShimmerWidget.rectangular(
                  width: 100.0,
                  height: 40.0,
                ),
              ],
            ),
          )
        ],
     );

  }

  _featureSchemes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setPadding(
          leftPadding: margin_20,
          widget:  commonText(
            featuresSchemesStr.tr,
            fontSize: font_18,
            color: paragraphColor,
          ),
        ),

        sizedBox(height: height_20),
         _featuresSchemesList(),
      ],
    );
  }

  _featuresSchemesList() {
    return  FutureBuilder(
         future: controller.getFeaturesSchemesApiCall(),
         builder: (context, data) {
           if (data.connectionState == ConnectionState.done) {
             if (data.hasData) {
               return controller.featuresSchemesModel!.schemes!.isEmpty?noDataAvailable(title: "No Features Schemes Available"):
               SizedBox(
                 height: height_220,
                 child: ListView.builder(
                     itemCount: controller.featuresSchemesModel!.schemes!.length,
                     shrinkWrap: true,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context, index) {

                       return _featuresSchemesItem(index);
                     }),
               );
             }
           }
           if (data.hasError) {
             return    noDataAvailable(title: controller.featuresSchemesErrorMessage.value);
           }
           if (data.connectionState == ConnectionState.waiting) {
             return _featuresShimmerWidget();
           }
           return _featuresShimmerWidget();
         });



  }

  _featuresSchemesItem(index) {
    return Container(
      width:Get.width*0.75,
      margin: EdgeInsets.only(left: margin_20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius_15),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radius_15),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              height: 320.0,
            width: Get.width*0.75,
            imageUrl:controller.featuresSchemesBackImagePath[index],
              placeholder: (context, url) =>ShimmerWidget.rectangular(width: 320.0, height: 320.0),
            errorWidget: (context, url, error) => assetImage(image:coldStorageIcon ,fit:BoxFit.fill,height: 320.0),
           ),
          ),
          setPadding(
             topPadding: margin_20,
            leftPadding: margin_20,
             bottomPadding: margin_20,
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                commonText(
                  "${controller.featuresSchemesModel!.schemes![index].schemeName}",
                  fontSize: font_18,
                  color: white,
                ),
                controller.featuresSchemesPublicSector[index]!=0?  commonText(
                  "${publicSubStr.tr}${controller.featuresSchemesPublicSector[index]}%",
                  fontSize: font_14,
                  color: white,
                ):Container(),
                controller.featuresSchemesPrivateSector[index]!=0?  commonText(
                  "${privateSubStr.tr}${controller.featuresSchemesPrivateSector[index]}%",
                  fontSize: font_14,
                  color: white,
                ):Container(),
                commonText(
                  "${costNormsStr.tr}${controller.costNormPrice[index]}",
                  fontSize: font_14,
                  color: white,
                ),
                sizedBox(height: margin_10),
                _seeAllButton(
                    buttonText: knowMoreStr.tr,
                    onclick: ()async {
                      Get.toNamed(Routes().schemesDetails,arguments:controller.featuresSchemesModel!.schemes![index]);
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  _featuresShimmerWidget() {
    return setPadding(
      leftPadding: margin_20,

      rightPadding: margin_20,
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

  _mandiPriceContainer() {
    return Column(
      children: [
        _mandiPriceTitle(
            title: mandiPriceStr.tr,
            leading: viewAllStr.tr,
            onViewClick: () {
              controller.mainScreenController!.onBottomClick(2);
            }),
        sizedBox(height: height_20),
        _mandiPriceList(),
      ],
    );
  }

  _mandiPriceTitle({title, leading, onViewClick}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonText(
          title,
          fontSize: font_18,
          color: paragraphColor,
        ),
        getInkWell(
          ontap: onViewClick,
          widget: commonText(
            leading,
            fontSize: font_12,
            color: thirdColor,
          ),
        )
      ],
    );
  }
  _mandiPriceList() {
    return FutureBuilder(
        future: controller.getMandiPriceApiCall(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.done) {
            if (data.hasData) {

              return controller.mandiPriceModel!.data!.data!.isEmpty?
              noDataAvailable(title: noDataAvailStr):
              ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return
                      _mandiPriceItem();
                  });
            }
            if (data.hasError) {
              return noDataAvailable(title: controller.mandiRateErrorMessage.value);
            }
          }
          if (data.connectionState == ConnectionState.waiting) {
            return _mandiPriceItemShimmerWidget();
          }

          return _mandiPriceItemShimmerWidget();
        });
  }
  _mandiPriceItemShimmerWidget() {
    return Stack(
      children: [
        ShimmerWidget.rectangular(
          height: 120,
          width: double.infinity,
        ),
        Container(
          padding: EdgeInsets.all(margin_20),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(radius_15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ShimmerWidget.rectangular(
                      height: 14,
                    ),
                  ),
                  sizedBox(width: margin_20),
                  Expanded(
                    child: ShimmerWidget.rectangular(
                      height: 14,
                    ),
                  ),
                ],
              ),
              sizedBox(height: height_10),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ShimmerWidget.rectangular(
                      height: 14,
                    ),
                  ),
                  sizedBox(width: margin_20),
                  Expanded(
                    child: ShimmerWidget.rectangular(
                      height: 14,
                    ),
                  )
                ],
              ),
              sizedBox(height: height_10),
              Align(
                alignment: Alignment.topLeft,
                child: ShimmerWidget.rectangular(
                  height: 14,
                  width: Get.width * 0.3,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  _mandiPriceItem() {
    return Container(
      padding: EdgeInsets.all(margin_20),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(radius_15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonText("${controller.mandiPriceModel!.data!.data![0].commodity}",
                  fontSize: font_14,
                  color: subtitleColor,
                  fontWeight: FontWeight.w400),
              Row(
                children: [
                  commonText(varietyStr.tr,
                      fontSize: font_14, color: paragraphColor),
                  sizedBox(width: margin_5),
                  commonText("${controller.mandiPriceModel!.data!.data![0].variety}",
                      fontSize: font_14,
                      color: subtitleColor,
                      fontWeight: FontWeight.w400),
                ],
              )
            ],
          ),
          sizedBox(height: height_10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.currency_rupee,
                    color: paragraphColor,
                    size: 24,
                  ),
                  commonText(
                      "${controller.mandiPriceModel!.data!.data![0].modalPrice}",
                      fontSize: font_18,
                      color: paragraphColor),
                  commonText(quantalStr.tr,
                      fontSize: font_12,
                      color: paragraphColor,
                      fontWeight: FontWeight.w400),
                ],
              ),
              Row(
                children: [
                  commonText(dateStr.tr, fontSize: font_14, color: paragraphColor),
                  sizedBox(width: margin_5),
                  commonText(
                      "${controller.mandiPriceModel!.data!.data![0].arrivalDate}",
                      fontSize: font_12,
                      color: paragraphColor,
                      fontWeight: FontWeight.w400),
                ],
              )
            ],
          ),
          sizedBox(height: height_10),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: thirdColor,
              ),
              sizedBox(width: margin_5),
              commonText(
                  "${controller.mandiPriceModel!.data!.data![0].market},${controller.mandiPriceModel!.data!.data![0].district}",
                  fontSize: font_14,
                  color: subtitleColor,
                  fontWeight: FontWeight.w400),
            ],
          )
        ],
      ),
    );
  }

  _todayInformationView() {
    return Column(
      children: [
        _mandiPriceTitle(
            title: todayInformation.tr,
            leading: viewAllStr.tr,
            onViewClick: () {
              controller.mainScreenController!.onBottomClick(3);
            }),
        sizedBox(height: height_20),
        FutureBuilder(
            future: controller.fetchVideos(),
            builder: (context, data) {
              if (data.connectionState == ConnectionState.done) {
                if (data.hasData) {
                  return _videoView();
                }
                if (data.hasError) {
                  return    noDataAvailable(title:controller.videoFeedErrorMessages.value);
                }
              }
              if (data.connectionState == ConnectionState.waiting) {
                return _videoShimmerContainer();
              }
              return _videoShimmerContainer();
            })
      ],
    );
  }

  _videoView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _videoThumbNail(),
        sizedBox(height: margin_20),
        commonText(controller.videoModel!.data!.data![0].title,
            fontSize: font_16, color: headingColor, textHeight: 1.4),
        sizedBox(height: margin_10),
        Row(
          children: [
            commonText("${controller.videoViews[0]} ${viewsStr.tr}",
                fontSize: font_14,
                color: subtitleColor,
                fontWeight: FontWeight.w400),
            sizedBox(width: margin_16),
            Container(
              height: 3,
              width: 3,
              margin: EdgeInsets.only(right: margin_3),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: subtitleColor),
            ),
            sizedBox(width: margin_10),
            commonText(controller.timeAgoList[0],
                fontSize: font_14,
                color: subtitleColor,
                fontWeight: FontWeight.w400),
          ],
        )
      ],
    );
  }
  _videoThumbNail() {
    return getInkWell(
      ontap: () {
        Get.toNamed(Routes().videoPlay, arguments: {
          "id": controller.videosIds[0],
          "title": controller.videoModel!.data!.data![0].title,
          "views": controller.videoViews[0],
          "time": controller.timeAgoList[0]
        });
      },
      widget: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(radius_24),
        child: Container(
          height: 214,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_24),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: controller.videoThumbNail[0] == null
                    ? assetImage(
                        image: video_image,
                        fit: BoxFit.cover,
                        width: double.infinity)
                    :CachedNetworkImage(imageUrl:controller.videoThumbNail[0],
                height:  212,
                  fit:BoxFit.fill,
                  width: double.infinity ,
                  errorWidget: (context, url, error)=>assetImage(image: coldStorageIcon,height: 212.0,width:fullWidth()),
                )


              ),
              Icon(
                Icons.play_circle,
                color: white,
                size: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _videoShimmerContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget.rectangular(
          height: 214,
          width: double.infinity,
        ),
        sizedBox(height: margin_20),
        ShimmerWidget.rectangular(
          height: 20,
          width: double.infinity,
        ),
        sizedBox(height: margin_10),
        ShimmerWidget.rectangular(
          height: 16,
          width: 200,
        ),
        sizedBox(height: margin_10),
        Row(
          children: [
            ShimmerWidget.rectangular(
              height: 16,
              width: 100,
            ),
            sizedBox(width: margin_16),
            sizedBox(width: margin_10),
            ShimmerWidget.rectangular(
              height: 16,
              width: 100,
            ),
          ],
        )
      ],
    );
  }
}
