import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

const Color primaryColor = Color(0xFFFD8F22);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color greyColor = Color(0xFF9C9C9C);
const Color greyD9Color = Color(0xFFD9D9D9);
const Color black33Color = Color(0xFF333333);
const Color recColor = Color(0xFFF2F2F2);
const Color yellowColor = Color(0xFFFFC107);
const Color redColor = Color(0xFFCE2D2D);
const Color orangeColor = Color(0xFFFF6E07);
const Color lightRedColor = Color(0xFFF25746);

const double fixPadding = 10.0;

const SizedBox heightSpace = SizedBox(height: fixPadding);
const SizedBox height5Space = SizedBox(height: 5.0);
const SizedBox widthSpace = SizedBox(width: fixPadding);
const SizedBox width5Space = SizedBox(width: 5.0);

SizedBox widthBox(double width) => SizedBox(width: width);
SizedBox heightBox(double height) => SizedBox(height: height);

List<BoxShadow> boxShadow = [
  BoxShadow(
    color: blackColor.withOpacity(0.2),
    blurRadius: 6.0,
  )
];

const TextStyle extrabold30White =
    TextStyle(color: whiteColor, fontSize: 30.0, fontWeight: FontWeight.w800);

const TextStyle extrabold28White =
    TextStyle(color: whiteColor, fontSize: 28.0, fontWeight: FontWeight.w800);

const TextStyle extrabold18White =
    TextStyle(color: whiteColor, fontSize: 18.0, fontWeight: FontWeight.w800);

const TextStyle extrabold16White =
    TextStyle(color: whiteColor, fontSize: 16.0, fontWeight: FontWeight.w800);

const TextStyle extrabold14Primary =
    TextStyle(color: primaryColor, fontSize: 14.0, fontWeight: FontWeight.w800);

const TextStyle bold20Primary =
    TextStyle(color: primaryColor, fontSize: 20.0, fontWeight: FontWeight.w700);

const TextStyle bold18Primary =
    TextStyle(color: primaryColor, fontSize: 18.0, fontWeight: FontWeight.w700);

const TextStyle bold16Primary =
    TextStyle(color: primaryColor, fontSize: 16.0, fontWeight: FontWeight.w700);

const TextStyle bold14Primary =
    TextStyle(color: primaryColor, fontSize: 14.0, fontWeight: FontWeight.w700);

const TextStyle bold12Primary =
    TextStyle(color: primaryColor, fontSize: 12.0, fontWeight: FontWeight.w700);

const TextStyle bold20White =
    TextStyle(color: whiteColor, fontSize: 20.0, fontWeight: FontWeight.w700);

const TextStyle bold18White =
    TextStyle(color: whiteColor, fontSize: 18.0, fontWeight: FontWeight.w700);

const TextStyle bold16White =
    TextStyle(color: whiteColor, fontSize: 16.0, fontWeight: FontWeight.w700);

const TextStyle bold14White =
    TextStyle(color: whiteColor, fontSize: 14.0, fontWeight: FontWeight.w700);

const TextStyle bold22Black =
    TextStyle(color: blackColor, fontSize: 22.0, fontWeight: FontWeight.w700);

const TextStyle bold18Black =
    TextStyle(color: blackColor, fontSize: 18.0, fontWeight: FontWeight.w700);

const TextStyle bold20Black =
    TextStyle(color: blackColor, fontSize: 20.0, fontWeight: FontWeight.w700);

const TextStyle bold16Black =
    TextStyle(color: blackColor, fontSize: 16.0, fontWeight: FontWeight.w700);

const TextStyle bold18Grey =
    TextStyle(color: greyColor, fontSize: 18.0, fontWeight: FontWeight.w700);

const TextStyle bold14Grey =
    TextStyle(color: greyColor, fontSize: 14.0, fontWeight: FontWeight.w700);

const TextStyle bold14Orange =
    TextStyle(color: orangeColor, fontSize: 14.0, fontWeight: FontWeight.w700);

const TextStyle semibold16White =
    TextStyle(color: whiteColor, fontSize: 16.0, fontWeight: FontWeight.w600);

const TextStyle semibold14White =
    TextStyle(color: whiteColor, fontSize: 14.0, fontWeight: FontWeight.w600);

const TextStyle semibold18Black =
    TextStyle(color: blackColor, fontSize: 18.0, fontWeight: FontWeight.w600);

const TextStyle semibold16Black =
    TextStyle(color: blackColor, fontSize: 16.0, fontWeight: FontWeight.w600);

const TextStyle semibold15Black =
    TextStyle(color: blackColor, fontSize: 15.0, fontWeight: FontWeight.w600);

const TextStyle semibold14Black =
    TextStyle(color: blackColor, fontSize: 14.0, fontWeight: FontWeight.w600);

const TextStyle semibold16Black33 =
    TextStyle(color: black33Color, fontSize: 16.0, fontWeight: FontWeight.w600);

const TextStyle semibold15Black33 =
    TextStyle(color: black33Color, fontSize: 15.0, fontWeight: FontWeight.w600);

const TextStyle semibold16Grey =
    TextStyle(color: greyColor, fontSize: 16.0, fontWeight: FontWeight.w600);

const TextStyle semibold14Grey =
    TextStyle(color: greyColor, fontSize: 14.0, fontWeight: FontWeight.w600);

const TextStyle medium16White =
    TextStyle(color: whiteColor, fontSize: 16.0, fontWeight: FontWeight.w500);

const TextStyle medium14White =
    TextStyle(color: whiteColor, fontSize: 14.0, fontWeight: FontWeight.w500);

const TextStyle medium16Black =
    TextStyle(color: blackColor, fontSize: 16.0, fontWeight: FontWeight.w500);

const TextStyle medium14Black =
    TextStyle(color: blackColor, fontSize: 14.0, fontWeight: FontWeight.w500);

const TextStyle medium12Black =
    TextStyle(color: blackColor, fontSize: 12.0, fontWeight: FontWeight.w500);

const TextStyle medium15Black =
    TextStyle(color: black33Color, fontSize: 15.0, fontWeight: FontWeight.w500);

const TextStyle medium16Grey =
    TextStyle(color: greyColor, fontSize: 16.0, fontWeight: FontWeight.w500);

const TextStyle medium15Grey =
    TextStyle(color: greyColor, fontSize: 15.0, fontWeight: FontWeight.w500);

const TextStyle medium14Grey =
    TextStyle(color: greyColor, fontSize: 14.0, fontWeight: FontWeight.w500);

const TextStyle medium12Grey =
    TextStyle(color: greyColor, fontSize: 12.0, fontWeight: FontWeight.w500);

const TextStyle medium15Black33 =
    TextStyle(color: black33Color, fontSize: 15.0, fontWeight: FontWeight.w500);


Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
