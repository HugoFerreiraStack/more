import 'dart:developer';

import 'package:dio/dio.dart';

abstract class Failure {
  final String? message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure({String? message, DioException? dioError}) : super(message) {
    if (dioError != null) {
      log(dioError.error.toString());
    }
    if (message != null) log(message.toString());
  }
}
