import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class DioClient {
  late final Dio _dio;

  Dio get dio => _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Authorization': 'Bearer ${ApiConstants.apiKey}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }
}
