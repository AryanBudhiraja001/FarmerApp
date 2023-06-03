import 'package:flutter/material.dart';
import '../../../constants/exports.dart';

class TodayWeather extends GetView {
   TodayWeather({Key? key}) : super(key: key);
   final TodayWeatherController _controller =Get.put(TodayWeatherController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<TodayWeatherController>(

        init:_controller ,
        builder: (controller){
      return Scaffold(
        appBar: customAppBar(
          title:todayWeatherStr.tr
        ),
        body: setPaddingAll(
          margin: margin_20,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
            _weatherContainer(),
              sizedBox(height: height_30),
              _weeklyForeCastHeading(),
              sizedBox(height: height_20),
              _weatherList(),

            ],
          ),
        ),


      );



    }));

  }

  _weatherContainer(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(margin_25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_15),
          gradient: LinearGradient(
              colors: [
                gradientColor1,
                gradientColor2,
              ]
          )
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _controller.homeController!.weatherModel!.list![_controller.homeController!.currentTimeLine.value].weather![0].icon!=null?
                    assetImage(image:"$weatherIcon${_controller.homeController!.weatherModel!.list![_controller.homeController!.currentTimeLine.value].weather![0].icon}@2x.png",height: 32.0,):
                    assetImage(image: weatherIconDefault,height: 32.0),

                   // Icon(Icons.cloud_outlined,color: white,size: 28,),
                    sizedBox(height: height_10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _controller.homeController!.weatherModel!.list![_controller.homeController!.currentTimeLine.value].main!.temp!=null?commonText(_controller.homeController!.weatherModel!.list![_controller.homeController!.currentTimeLine.value].main!.temp.toString(),color: white,fontSize: font_30):commonText("31.14",color: white),
                        Container(
                          padding: EdgeInsets.all(margin_3),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: white,width: 2)
                          ),
                        )
                      ],
                    )

                  ],
                ),
                sizedBox(width: width_20),
                VerticalDivider(color: white.withOpacity(0.14),thickness: 1,),
                sizedBox(width: width_20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _controller.desList.isNotEmpty?commonText(_controller.desList[0],color: white,fontSize: font_16):commonText("Clouds",color: white),
                      sizedBox(height: height_10),
                      commonText(_controller.homeController!.address.value,color: white,fontSize: font_14,fontWeight: FontWeight.w400,textHeight: 1.4,maxLines: 3)

                    ],
                  ),
                ),

              ],
            ),
          ),
          sizedBox(height: height_10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              commonText("Precipications:${_controller.precipications} %",color: white,fontSize: font_14,fontWeight: FontWeight.w400),
              sizedBox(width: margin_20),
              commonText("Humidity:${_controller.homeController!.weatherModel!.list![_controller.homeController!.currentTimeLine.value].main!.humidity} %",color: white,fontSize: font_14,fontWeight: FontWeight.w400)
            ],
          ),
          sizedBox(height: height_10),
          commonText("Wind:${_controller.homeController!.weatherModel!.list![_controller.homeController!.currentTimeLine.value].wind!.speed} Km/h",color: white,fontSize: font_14,fontWeight: FontWeight.w400)

        ],
      ),
    );
  }

  _weeklyForeCastHeading(){
    return   commonText(weeklyForeCastStr.tr,color: paragraphColor,fontSize: font_18);

  }
  
  _weatherList(){
    return
      _controller.dateList.isNotEmpty?
      Expanded(
      child: ListView.builder(
          itemCount:5,
          shrinkWrap: true,
          itemBuilder:(context,index){
          return _weatherItem(index: index);

      }),
    ):noDataAvailable(title:noDataAvailStr.tr);
    
    
  }

  _weatherItem({index,heading,weatherState,dayData,nightData}){
    return Container(
      color:index.isEven?bgColor2:bgColor,
      child:  setPadding(
        topPadding: margin_20,
        bottomPadding: margin_20,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Expanded(child:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Expanded(child:commonText(_controller.dateList[index],color: subtitleColor,fontSize: font_14,fontWeight: FontWeight.w400),
              ),


                  Expanded(child:   commonText(_controller.desList[index]??"NA",color: subtitleColor,fontSize: font_14,fontWeight: FontWeight.w400,align: TextAlign.left))              ,
              ],
            ),),
            commonText("D ${_controller.dayTempList[index]} / N${_controller.nightTempList[index]}",color: subtitleColor,fontSize: font_14,fontWeight: FontWeight.w400),
          ],
        ),
      ) ,
    );


  }
  
  
  


}
