import 'package:farmer_app/ui/constants/exports.dart';


class CompleteDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<CompleteDetailsScreensController>(CompleteDetailsScreensController());
  }


}