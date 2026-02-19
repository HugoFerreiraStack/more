import 'package:b3/features/home/presenter/bindings/home_binding.dart';
import 'package:b3/features/home/presenter/pages/home_page.dart';
import 'package:b3/features/splash/presenter/bindings/splash_binding.dart';
import 'package:b3/features/splash/presenter/pages/splash_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
