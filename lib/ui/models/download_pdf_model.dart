
import 'package:flutter_downloader/flutter_downloader.dart';

class MyItem {
  final String  url;
  String? itemID;
  int progress =0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  MyItem({required this.url});

}