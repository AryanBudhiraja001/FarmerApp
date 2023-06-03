import 'package:farmer_app/ui/constants/exports.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoFeedPlayerController extends GetxController{
  late  YoutubePlayerController videoController;
  late TextEditingController idController;
  late TextEditingController seekToController;

  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  double volume = 100;
  bool muted = false;
  var isPlayerReady = false.obs;
  var index;
  var id;
  var title;
  var views;
  var time;

  VideoFeedController? videoFeedController;

  final List<String> ids = [];

  @override
  void onInit() {
    videoFeedController=Get.find<VideoFeedController>();
    id=Get.arguments["id"];
    title=Get.arguments["title"];
    views=Get.arguments["views"];
    time=Get.arguments["time"];
    videoController = YoutubePlayerController(
      initialVideoId:"$id",
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);

    seekToController = TextEditingController();
    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.unknown;
 var   videoIdd = YoutubePlayer.convertUrlToId("https://www.youtube.com/embed/ZaSTo8uY9xM");
    debugPrint('this is video ids $videoIdd');
    super.onInit();
  }

  void listener() {
    if (isPlayerReady.value && !videoController.value.isFullScreen) {
          playerState = videoController.value.playerState;
        videoMetaData = videoController.metadata;
        update();

    }
  }





  loadData(value){
    isPlayerReady.value=value;
    update();
  }
  @override
  void dispose() {
    videoController.dispose();
    idController.dispose();
    seekToController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    videoController.pause();
    super.onClose();
  }
}