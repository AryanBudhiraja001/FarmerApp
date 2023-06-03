import 'package:farmer_app/ui/constants/exports.dart';


class AppliedSchemesBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<MySchemesController>(MySchemesController());
  }
}