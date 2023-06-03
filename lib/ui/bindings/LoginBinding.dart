import 'package:farmer_app/ui/constants/exports.dart';


class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<FarmerLoginController>(FarmerLoginController());
  }
}