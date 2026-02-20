import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/domain/models/stock.dart';
import 'package:flutter/material.dart';

class StockDisplayHelper {
  StockDisplayHelper._();

  static Color changeColor(Stock stock) =>
      stock.isPositive ? AppColors.success : AppColors.error;

  static String changePrefix(Stock stock) => stock.isPositive ? '+' : '';

  static String changeText(Stock stock) =>
      '${changePrefix(stock)}${stock.change.toStringAsFixed(2)}%';

  static String priceText(Stock stock) =>
      'R\$ ${stock.close.toStringAsFixed(2)}';

  static String formatVolume(int volume) {
    if (volume >= 1000000000) return '${(volume / 1000000000).toStringAsFixed(1)}B';
    if (volume >= 1000000) return '${(volume / 1000000).toStringAsFixed(1)}M';
    if (volume >= 1000) return '${(volume / 1000).toStringAsFixed(1)}K';
    return volume.toString();
  }

  static String formatMarketCap(double value) {
    if (value >= 1e12) return 'R\$ ${(value / 1e12).toStringAsFixed(1)}T';
    if (value >= 1e9) return 'R\$ ${(value / 1e9).toStringAsFixed(1)}B';
    if (value >= 1e6) return 'R\$ ${(value / 1e6).toStringAsFixed(1)}M';
    return 'R\$ ${value.toStringAsFixed(2)}';
  }
}
