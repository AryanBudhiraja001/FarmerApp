import 'package:farmer_app/ui/constants/exports.dart';
import 'package:flutter/material.dart';


import 'package:shimmer/shimmer.dart';
class ShimmerWidget extends StatelessWidget {
  final double width;
  final   double height;
final ShapeBorder shapeBorder;
 final  Color color;

   ShimmerWidget.rectangular({
    this.width=double.infinity,
   required this.height,
     this.color=shimmerColor,
   }
    ):shapeBorder= RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius_10));

  const ShimmerWidget.circular({
    required this.width,
    required this.height,
    this.shapeBorder=const CircleBorder(),
    this.color=Colors.grey
    }
    );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(baseColor:color.withOpacity(0.3),
        highlightColor: color.withOpacity(0.5),
        child: Container(
          decoration: ShapeDecoration(
            color:  primaryColor,
            shape: shapeBorder
          ),
      height: height,
      width: width,

    ));
  }
}
