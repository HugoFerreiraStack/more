import 'dart:async';

import 'package:b3/features/home/domain/models/get_quote_list_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/models/stock.dart';
import '../../domain/usecases/fetch_stocks_usecase.dart';

enum StockSort { name, price, change }

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final FetchStocksUsecase fetchStocksUsecase;
  HomeController({required this.fetchStocksUsecase});

  final scrollController = ScrollController();
  final searchController = TextEditingController();

  final RxList<Stock> stocks = <Stock>[].obs;
  final RxString searchQuery = ''.obs;
  final Rxn<StockSort> sortBy = Rxn<StockSort>();
  final RxBool sortDescending = false.obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final hasNextPage = false.obs;
  final RxInt tabIndex = 0.obs;

  void setTabIndex(int i) => tabIndex.value = i;

  static const _loadMoreThreshold = 200.0;

  List<Stock> get filteredStocks {
    final query = searchQuery.value.trim().toLowerCase();
    var list = query.isEmpty
        ? stocks.toList()
        : stocks.where((s) {
            return s.stock.toLowerCase().contains(query) ||
                s.name.toLowerCase().contains(query);
          }).toList();
    final sort = sortBy.value;
    if (sort != null) {
      list = _sorted(list, sort, sortDescending.value);
    }
    return list;
  }

  List<Stock> _sorted(List<Stock> list, StockSort sort, bool descending) {
    final copy = List<Stock>.from(list);
    final mult = descending ? -1 : 1;
    switch (sort) {
      case StockSort.name:
        copy.sort((a, b) => mult * a.name.compareTo(b.name));
        break;
      case StockSort.price:
        copy.sort((a, b) => mult * a.close.compareTo(b.close));
        break;
      case StockSort.change:
        copy.sort((a, b) => mult * a.change.compareTo(b.change));
        break;
    }
    return copy;
  }

  void onSearchChanged(String value) => searchQuery.value = value;

  void setSort(StockSort sort) {
    if (sortBy.value == sort) {
      if (sortDescending.value) {
        sortBy.value = null;
      } else {
        sortDescending.value = true;
      }
    } else {
      sortBy.value = sort;
      sortDescending.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    fetchStocks();
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
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