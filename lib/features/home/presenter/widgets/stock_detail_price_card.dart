import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/domain/models/stock.dart';
import 'package:b3/features/home/presenter/utils/stock_display_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StockDetailPriceCard extends StatelessWidget {
  const StockDetailPriceCard({super.key, required this.stock});

  final Stock stock;

  @override
  Widget build(BuildContext context) {
    final changeColor = StockDisplayHelper.changeColor(stock);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preço atual',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    StockDisplayHelper.priceText(stock),
                    style: GoogleFonts.inter(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -1,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: changeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      stock.isPositive
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      size: 20,
                      color: changeColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      StockDisplayHelper.changeText(stock),
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: changeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (stock.sector != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.accentSoft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                stock.sector!,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
