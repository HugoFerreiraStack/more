import 'package:b3/features/home/data/home_repository_impl.dart';
import 'package:b3/features/home/domain/repositories/home_repository.dart';
import 'package:b3/features/home/domain/usecases/fetch_stocks_usecase.dart';
import 'package:b3/features/home/presenter/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl());
    Get.lazyPut<FetchStocksUsecase>(
      () => FetchStocksUsecase(Get.find<HomeRepository>()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(fetchStocksUsecase: Get.find<FetchStocksUsecase>()),
    );
  }
}