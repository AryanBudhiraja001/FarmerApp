
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/exports.dart';
import '../../../../controller/video_feed_player_controller.dart';


class VideoPlayScreen extends GetView<VideoFeedPlayerController> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoFeedPlayerController>(
        init: VideoFeedPlayerController(),
        builder:(controller){

      return
        YoutubePlayerBuilder(
      onExitFullScreen: () {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
      controller: controller.videoController,
      showVideoProgressIndicator: true,
      progressColors: ProgressBarColors(
      backgroundColor: white,
      playedColor: redColor,
      handleColor:redColor
      ),
      progressIndicatorColor: primaryColor,
        onReady: () {
          controller.loadData(true);
        },
    onEnded: (data) {
        },
    ),
    builder: (context, player) => Scaffold(
    appBar:customAppBar(
    title:  controller.title
    ),
    body: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    // primary: false,
    children: [
    player,
    Padding(
    padding:  EdgeInsets.all(margin_20),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    _space,
    commonText(
        controller.title, fontSize: font_16, color: headingColor,textHeight: 1.4),
    sizedBox(height: margin_10),
    Row(
    children: [
    commonText("${controller.views} ${viewsStr.tr}", fontSize: font_14,
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
    commonText(controller.time, fontSize: font_14,
    color: subtitleColor,
    fontWeight: FontWeight.w400),
    ],
    ),
      _space,
    ],
    ),
    ),



    ],
    ),
    ),
    );
    }
    );

  }

  Widget get _space => const SizedBox(height: 10);






}