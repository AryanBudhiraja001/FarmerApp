
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:flutter/material.dart';





class DownloadingDialog extends StatelessWidget {
  var fileUrl;
  DownloadingDialog(this.fileUrl);

  final DownloadFileController _controller=Get.put(DownloadFileController());

  @override
  Widget build(BuildContext context) {
    _controller.fileUrl=fileUrl;
    return GetBuilder<DownloadFileController>(builder: (_){
      return Container(
        color: black,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator.adaptive(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Downloading: ${_controller.downloadingProgress}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
        ),
      );

    });


  }
}