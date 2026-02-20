import 'package:b3/core/constants/api_constants.dart';
import 'package:b3/core/result/result.dart';
import 'package:b3/features/home/domain/models/get_quote_list_params.dart';
import 'package:b3/features/home/domain/models/quote_list_response.dart';
import 'package:b3/features/home/domain/repositories/home_repository.dart';
import 'package:b3/features/shared/controllers/app_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeRepositoryImpl extends HomeRepository {
  final AppController appController = Get.find<AppController>();

  @override
  Future<Result<QuoteListResponse>> getQuoteList(GetQuoteListParams params) async {
    try {
      final response = await appController.dio.get(
        ApiConstants.list,
        queryParameters: {'page': params.page, 'limit': params.limit},
      );
      return Result.success(QuoteListResponse.fromJson(response.data));
    } on DioException catch (e) {
      final message = e.response?.data?['message'] as String? ??
          e.message ??
          'Erro ao carregar cotações';
      return Result.failure(message);
    } catch (e) {
      return Result.failure('Erro inesperado ao carregar cotações');
    }
  }
}
