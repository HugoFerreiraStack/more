import 'package:b3/features/shared/controllers/app_controller.dart';
import 'package:b3/features/wallet/presenter/controllers/wallet_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController(), permanent: true);
    Get.put<WalletController>(WalletController(), permanent: true);
  }
}