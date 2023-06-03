import 'package:farmer_app/ui/constants/exports.dart';
import 'package:intl/intl.dart';

class TodayWeatherController extends GetxController {
  HomeController? homeController;
  var precipications;
  var dayTime = "14:30";
  var nightTime = "20:30";
  var dateList = [];
  var desList = [];
  var dayTempList = [];
  var nightTempList = [];
  var dateDes = DateTime.now();

  var date = DateTime.now();

  @override
  void onInit() {
    homeController = Get.find<HomeController>();
    debugPrint("weather details is${homeController!.weatherModel!.toJson()}");
    precipications = (homeController!.weatherModel!
                .list![homeController!.currentTimeLine.value].pop! *
            100)
        .toStringAsFixed(0);
    fetchDates();
    fetchDes();
    fetchDayAndNightTime();
    fetchNightTime();

    super.onInit();
  }

  fetchDates() {
    for (int i = 0; i < homeController!.dateTimeList.length; i++) {
      if (date.day == homeController!.dateTimeList[i].day) {
        final DateFormat formatter = DateFormat('d MMMM');
        final String formattedDate =
            formatter.format(homeController!.dateTimeList[i]);
        // dateList.add(formattedDate);
       if(i==0){
              dateList.add(todayStr.tr);
       }
       else{
         dateList.add(formattedDate);
       }
       date = date.add(const Duration(days: 1));
      }
      else{

      }
    }

  }

  fetchDes() {
    for (int i = 0; i < homeController!.dateTimeList.length; i++) {
      if (dateDes.day == homeController!.dateTimeList[i].day) {
        if (homeController!.weatherModel!.list![i].weather![0].description !=
            null) {
          desList.add(
              homeController!.weatherModel!.list![i].weather![0].description!);
          dateDes = dateDes.add(const Duration(days: 1));
        } else {
          desList.add(cloudsStr.tr);
        }
      }
    }
  }

  fetchDayAndNightTime() {
    for (int i = 0; i < homeController!.dateTimeList.length; i++) {
      if (dayTime == "${homeController!.dateTimeList[i].hour}:${homeController!.dateTimeList[i].minute}") {
        dayTempList.add(homeController!.weatherModel!.list![i].main!.temp);
      }
    }
  }

  fetchNightTime() {
    for (int i = 0; i < homeController!.dateTimeList.length; i++) {
      if (nightTime ==
          "${homeController!.dateTimeList[i].hour}:${homeController!.dateTimeList[i].minute}") {
        nightTempList.add(homeController!.weatherModel!.list![i].main!.temp);
      }
    }
  }

  @override
  void onClose() {
    dateList.clear();
    desList.clear();
    dayTempList.clear();
    nightTempList.clear();
    // TODO: implement onClose
    super.onClose();
  }
}
