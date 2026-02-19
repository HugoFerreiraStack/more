import 'package:b3/config/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Duration get animationDuration => const Duration(milliseconds: 1400);
  Curve get animationCurve => Curves.easeOutBack;
  double get animationBegin => 0;
  double get animationEnd => 1;
  double get logoWidth => 120;
  double get logoHeight => 120;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(animationDuration, () {
      Get.offNamed(AppRoutes.home);
    });
  }
}