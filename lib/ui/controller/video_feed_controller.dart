
import 'package:timeago/timeago.dart' as timeago;
import 'package:dio/dio.dart';
import 'package:farmer_app/ui/constants/exports.dart';
import '../models/Playlist.dart';
import '../models/youtube_video_model.dart';
import '../networks/dio/error_handling.dart';


class VideoFeedController extends GetxController{
  List<Playlist> playlists = [];
  Playlist? playList;
  Future<VideosModel>? videoFutureData;
  List videosIds = [];
  var isLoadingVideo=false.obs;
  var keyword="".obs;
  HttpsService? httpsService;
  VideosModel? videoModel;
  var isLastPage=false.obs;
  List videoThumbNail=[];
   List timeAgoList=[];
   List videoViews=[];
   var errorMessage="".obs;
   List videoTitle=[];
   var currentPage=1.obs;
 var totalPages=1.obs;
  int? nextPage;
  int? previousPage;
  int? countStartFrom;
  final TextEditingController searchController=TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  @override
  onInit(){
    httpsService=HttpsService();
    videoFutureData=fetchVideos();
    super.onInit();
  }





    refreshScreen(){
    update(["video"]);
    }

  goToPageClicked(pageNumber){
    currentPage.value=pageNumber;
    fetchVideos();
  }
  goToNextPage(){
    if(currentPage.value!=totalPages.value){
      currentPage.value++;
      fetchVideos();
    }

  }


  goToPreviousPage(){
    if(currentPage.value!=1){
      currentPage.value--;
      fetchVideos();
    }
  }

  Future<VideosModel> fetchVideos() async{
    try{
      isLoadingVideo.value=true;
      refreshScreen();
      var response = await Dio().get(BASE_URL+fetchVideoEnd,
          options: Options(
              headers: httpsService!.headersGet),
        queryParameters: {
        "page":currentPage.value,
        }
      );
      if (response.statusCode == 200) {
        isLoadingVideo.value=false;
        refreshScreen();
        debugPrint("videos data is ${response.data}");
        videoModel=VideosModel.fromJson(response.data);
        totalPages.value=videoModel!.data!.lastPage!;
        videosIds.clear();
        for(int i=0;i<videoModel!.data!.data!.length;i++){
          videosIds.insert(i,videoModel!.data!.data![i].videoId);
          DateTime dt = DateTime.parse(videoModel!.data!.data![i].createdAt!);
          timeAgoList.insert(i, timeago.format(dt));

          videoThumbNail.insert(i,videoModel!.data!.data![i].thumbnail);
          videoTitle.insert(i, videoModel!.data!.data![i].title);
          debugPrint("time ago is${timeago.format(dt)}");
           var formattedNumber =   viewsConverter(int.parse(videoModel!.data!.data![i].views!));
           debugPrint("views ago is$formattedNumber");
          videoViews.insert(i,formattedNumber);
        }

      }
    }
    catch(e){
      if(e is DioError){
        isLoadingVideo.value=false;
        refreshScreen();
        DioException.fromDioError(e);
        errorMessage.value=DioException.errorMessage!;
        debugPrint("video feed error${errorMessage.value} ");
        errorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
        if(e.response!.statusCode==401){
          // errorMessage.value=e.response!.data;
          // toast(e.response!.data);
        }
        else{
        }
      }
      else{
        isLoadingVideo.value=false;
        refreshScreen();
      }
    }
    return videoModel!;
  }


  Future<VideosModel> searchFetchVideos() async{
    try{
      isLoadingVideo.value=true;
      refreshScreen();
      var response = await Dio().get(BASE_URL+searchVideoEnd,
          options: Options(
              headers: httpsService!.headersGet),
        queryParameters: {
          "keyword":keyword.value,
          "page":currentPage.value,
        }
      );

      if (response.statusCode == 200) {
        isLoadingVideo.value=false;
        refreshScreen();
        debugPrint("videos data is ${response.data}");
        videoModel=VideosModel.fromJson(response.data);
            update();
        totalPages.value=videoModel!.data!.lastPage!;
        videosIds.clear();
        for(int i=0;i<videoModel!.data!.data!.length;i++){
          videosIds.insert(i,videoModel!.data!.data![i].videoId);
          DateTime dt = DateTime.parse(videoModel!.data!.data![i].createdAt!);
          timeAgoList.insert(i, timeago.format(dt));

          videoThumbNail.insert(i,videoModel!.data!.data![i].thumbnail);
          videoTitle.insert(i, videoModel!.data!.data![i].title);
          debugPrint("time ago is${timeago.format(dt)}");
          var formattedNumber =   viewsConverter(int.parse(videoModel!.data!.data![i].views!));
          debugPrint("views ago is$formattedNumber");
          videoViews.insert(i,formattedNumber);
        }

      }
    }
    catch(e){
      isLoadingVideo.value=false;
      refreshScreen();
      if(e is DioError){
        DioException.fromDioError(e);
        errorMessage.value=DioException.errorMessage!;
        debugPrint("video feed error${errorMessage.value} ");
        errorMessage.value=DioException.handleStatusCode(e.response!.statusCode);
        if(e.response!.statusCode==401){
          errorMessage.value=e.response!.data;
          // toast(e.response!.data);
        }
        else{
        }
      }
    }
    return videoModel!;
  }
   viewsConverter(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)}K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)}K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)}M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)}B";
    } else {
      return num.toString();
    }
  }


@override
  void onClose() {
   videosIds.clear();
   timeAgoList.clear();
   videoViews.clear();
   videoThumbNail.clear();
    searchFocusNode.unfocus();
   FocusManager.instance.primaryFocus!.unfocus();
    super.onClose();
  }

  @override
  void dispose() {
    searchFocusNode.unfocus();
    FocusManager.instance.primaryFocus!.unfocus();
  }
}