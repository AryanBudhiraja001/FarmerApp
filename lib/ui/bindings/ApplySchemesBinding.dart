
import 'package:farmer_app/ui/constants/exports.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class UploadSchemesBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<UploadDocumentController>(UploadDocumentController());
  }

}