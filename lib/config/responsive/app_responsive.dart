import 'package:flutter/material.dart';

class AppResponsive {
  AppResponsive._();

  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;

  static const double headerExpandedMinHeight = 52;
  static const double headerPaddingVertical = 36;

  static ScreenType screenType(double width) {
    if (width >= desktop) return ScreenType.desktop;
    if (width >= tablet) return ScreenType.tablet;
    return ScreenType.mobile;
  }

  static ScreenType screenTypeOf(BuildContext context) {
    return screenType(MediaQuery.sizeOf(context).width);
  }

  static bool isHeaderCompact({
    required double availableHeight,
    double? statusBarHeight,
  }) {
    final topInset = (statusBarHeight ?? 0) + headerPaddingVertical;
    final contentHeight = availableHeight - topInset;
    return contentHeight < headerExpandedMinHeight + 4;
  }

  static bool isHeaderCompactFromConstraints(
    BoxConstraints constraints, [
    BuildContext? context,
  ]) {
    final statusBar = context != null ? MediaQuery.paddingOf(context).top : 0.0;
    return isHeaderCompact(
      availableHeight: constraints.maxHeight,
      statusBarHeight: statusBar,
    );
  }

  static T valueByScreen<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final type = screenTypeOf(context);
    switch (type) {
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.mobile:
        return mobile;
    }
  }

  static double responsiveValue({
    required BuildContext context,
    required double min,
    required double max,
    double? tablet,
    double? desktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    final type = screenType(width);

    switch (type) {
      case ScreenType.desktop:
        return desktop ?? max;
      case ScreenType.tablet:
        return tablet ?? (min + max) / 2;
      case ScreenType.mobile:
        return min;
    }
  }
}

enum ScreenType { mobile, tablet, desktop }
