import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../core/network/dio_client.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();
  late final DioClient dioClient;

  Dio get dio => dioClient.dio;

  @override
  void onInit() {
    super.onInit();
    dioClient = DioClient();
  }
}