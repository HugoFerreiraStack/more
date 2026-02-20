import 'package:b3/config/accessibility/app_semantics.dart';
import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/config/routes/app_pages.dart';
import 'package:b3/features/home/domain/models/stock.dart';
import 'package:b3/features/home/presenter/widgets/add_to_wallet_button.dart';
import 'package:b3/features/home/presenter/utils/stock_display_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  final bool showWalletButton;

  const StockCard({
    super.key,
    required this.stock,
    this.showWalletButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      button: true,
      label: AppSemantics.stockCard(
        stock.stock,
        stock.name,
        StockDisplayHelper.priceText(stock),
        StockDisplayHelper.changeText(stock),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.toNamed(AppRoutes.stockDetail, arguments: stock),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                _buildLogo(),
                const SizedBox(width: 16),
                Expanded(child: _buildInfo()),
                _buildPrice(),
                if (showWalletButton) ...[
                  const SizedBox(width: 12),
                  AddToWalletButton(
                    stock: stock,
                    size: 44,
                    iconSize: 22,
                    foreground: AppColors.textPrimary,
                    backgroundOpacity: 0.08,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildLogo() {
    return ExcludeSemantics(
      child: Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Icon(
          Icons.candlestick_chart_rounded,
          color: AppColors.accent.withValues(alpha: 0.6),
          size: 24,
        ),
      ),
    ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          stock.stock,
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stock.name,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (stock.sector != null) ...[
          const SizedBox(height: 6),
          Text(
            stock.sector!,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildPrice() {
    final color = StockDisplayHelper.changeColor(stock);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          StockDisplayHelper.priceText(stock),
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            StockDisplayHelper.changeText(stock),
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
