import 'package:b3/config/themes/app_assets.dart';
import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/splash/presenter/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(
            begin: controller.animationBegin,
            end: controller.animationEnd,
          ),
          duration: controller.animationDuration,
          curve: controller.animationCurve,
          builder: (context, value, child) {
            return Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: Transform.scale(
                scale: value,
                child: child,
              ),
            );
          },
          child: SizedBox(
            width: controller.logoWidth,
            height: controller.logoHeight,
            child: Image.asset(
              AppAssets.logo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
