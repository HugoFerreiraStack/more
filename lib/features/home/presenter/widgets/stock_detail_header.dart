import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/domain/models/stock.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StockDetailHeader extends StatelessWidget {
  const StockDetailHeader({super.key, required this.stock});

  final Stock stock;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Colors.white,
          ),
        ),
        onPressed: () => Get.back(),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primaryLight,
              AppColors.primary,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 72, right: 24, bottom: 48),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  _buildLogo(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stock.stock,
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          stock.name,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
            child: CachedNetworkImage(
              imageUrl: stock.logo,
              fit: BoxFit.contain,
              placeholder: (_, __) => const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              errorWidget: (_, __, ___) => Icon(
                Icons.candlestick_chart_rounded,
                color: Colors.white.withValues(alpha: 0.9),
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
