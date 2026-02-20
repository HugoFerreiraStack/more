import 'dart:convert';

import 'package:b3/features/home/domain/models/stock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletController extends GetxController {
  static WalletController get to => Get.find();

  static const _storageKey = 'wallet_stocks';

  final RxList<Stock> stocks = <Stock>[].obs;
  final searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  List<Stock> get filteredStocks {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return stocks.toList();
    return stocks
        .where((s) =>
            s.stock.toLowerCase().contains(query) ||
            s.name.toLowerCase().contains(query))
        .toList();
  }

  void onSearchChanged(String value) => searchQuery.value = value;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_storageKey);
    if (json != null) {
      try {
        final list = jsonDecode(json) as List;
        stocks.value = list
            .map((e) => Stock.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {
        stocks.value = [];
      }
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = stocks.map((s) => s.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(list));
  }

  bool isInWallet(String ticker) =>
      stocks.any((s) => s.stock.toUpperCase() == ticker.toUpperCase());

  void toggle(Stock stock) {
    final idx = stocks.indexWhere(
      (s) => s.stock.toUpperCase() == stock.stock.toUpperCase(),
    );
    if (idx >= 0) {
      stocks.removeAt(idx);
    } else {
      stocks.add(stock);
    }
    _save();
  }

  void add(Stock stock) {
    if (!isInWallet(stock.stock)) {
      stocks.add(stock);
      _save();
    }
  }

  void remove(Stock stock) {
    stocks.removeWhere(
      (s) => s.stock.toUpperCase() == stock.stock.toUpperCase(),
    );
    _save();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
