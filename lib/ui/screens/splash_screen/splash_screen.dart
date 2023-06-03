
import 'package:farmer_app/ui/screens/splash_screen/splash_controller.dart';
import 'package:flutter/material.dart';

import '../../constants/exports.dart';

class SplashScreen extends GetView<SplashController> {
   SplashScreen({Key? key}) : super(key: key);


   SplashController _controller=Get.put(SplashController());

   @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child:_splashLogo(),
          ),
        ));
  }

  _splashLogo() {
    return Container(
      height: 136,
      width: 136,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage(ic_logo)),
          boxShadow: const [
            BoxShadow(
              color: shadowColor,
              offset: Offset(0.0, 2.0),
              blurRadius: 1.0,
            ),
          ]),
    );
  }




}