import 'dart:async';

import 'package:b3/features/home/domain/models/get_quote_list_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/models/stock.dart';
import '../../domain/usecases/fetch_stocks_usecase.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final FetchStocksUsecase fetchStocksUsecase;
  HomeController({required this.fetchStocksUsecase});

  final scrollController = ScrollController();

  final RxList<Stock> stocks = <Stock>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final hasNextPage = false.obs;

  static const _loadMoreThreshold = 200.0;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    fetchStocks();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (!hasNextPage.value || isLoading.value || isLoadingMore.value) return;
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - _loadMoreThreshold) {
      loadMoreStocks();
    }
  }

  Future<void> fetchStocks() async {
    final completerStocks = Completer<void>();

    Future(() async {
      isLoading.value = true;
      errorMessage.value = '';
      currentPage.value = 1;

      final result = await fetchStocksUsecase.call(
        GetQuoteListParams(page: 1, limit: 20),
      );

      result.fold(
        (error) {
          errorMessage.value = error;
          if (!completerStocks.isCompleted) completerStocks.complete();
        },
        (response) {
          stocks.value = response.stocks;
          currentPage.value = response.currentPage;
          totalPages.value = response.totalPages;
          hasNextPage.value = response.hasNextPage;
          if (!completerStocks.isCompleted) completerStocks.complete();
        },
      );

      isLoading.value = false;
    });

    return completerStocks.future;
  }

  Future<void> loadMoreStocks() async {
    if (!hasNextPage.value || isLoadingMore.value) return;

    isLoadingMore.value = true;
    final completer = Completer<void>();
    final nextPage = currentPage.value + 1;

    Future(() async {

      final result = await fetchStocksUsecase.call(
        GetQuoteListParams(page: nextPage, limit: 20),
      );

      result.fold(
        (_) => completer.complete(),
        (response) {
          stocks.addAll(response.stocks);
          currentPage.value = response.currentPage;
          totalPages.value = response.totalPages;
          hasNextPage.value = response.hasNextPage;
          completer.complete();
        },
      );

      isLoadingMore.value = false;
    });

    return completer.future;
  }
}