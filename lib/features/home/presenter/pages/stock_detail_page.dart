import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/domain/models/stock.dart';
import 'package:b3/features/home/presenter/widgets/stock_detail_header.dart';
import 'package:b3/features/home/presenter/widgets/stock_detail_info_section.dart';
import 'package:b3/features/home/presenter/widgets/stock_detail_price_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockDetailPage extends StatelessWidget {
  const StockDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stock = Get.arguments as Stock;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          StockDetailHeader(stock: stock),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StockDetailPriceCard(stock: stock),
                  const SizedBox(height: 32),
                  StockDetailInfoSection(stock: stock),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
