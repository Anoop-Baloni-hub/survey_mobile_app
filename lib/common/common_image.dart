import 'package:flutter/material.dart';

Widget assetImage({
  required String image,
  double? height,
  double? width,
  double? scale,
  Color? color,
  BoxFit? fit,
}) {
  return Image.asset(
    image,
    height: height,
    width: width,
    scale: scale,
    color: color,
    fit: fit,
  );
}

Widget networkImage({
  required String image,
  double? height,
  double? width,
  double scale = 1.0,
  Color? color,
  BoxFit? fit,
}) {
  return Image.network(
    image,
    height: height,
    width: width,
    scale: scale,
    color: color,
    fit: fit,
  );
}
