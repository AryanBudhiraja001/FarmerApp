
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:flutter/material.dart';


import 'package:youtube_player_flutter/youtube_player_flutter.dart';





class SchemesVideoPlay extends StatelessWidget {

final  SchemesVideoPlayController _controller =Get.put(SchemesVideoPlayController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchemesVideoPlayController>(builder:(controller){
      return
        YoutubePlayerBuilder(
          onExitFullScreen: () {
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(
            controller: _controller.videoController,
            showVideoProgressIndicator: true,
            progressColors: ProgressBarColors(
                backgroundColor: white,
                playedColor: redColor,
                handleColor:redColor
            ),
            progressIndicatorColor: primaryColor,
            onReady: () {
              _controller.loadData(true);
            },
            onEnded: (data) {
            },
          ),
          builder: (context, player) => Scaffold(
            appBar:customAppBar(
                title:  _controller.title,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // primary: false,
              children: [
                player,
                sizedBox(height: margin_20),
                 setPadding(
                   leftPadding: margin_20,
                   widget:    commonText(
                       _controller.title, fontSize: font_16, color: headingColor,textHeight: 1.4),
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