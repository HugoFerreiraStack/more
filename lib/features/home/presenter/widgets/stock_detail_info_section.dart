import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/domain/models/stock.dart';
import 'package:b3/features/home/presenter/utils/stock_display_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StockDetailInfoSection extends StatelessWidget {
  const StockDetailInfoSection({super.key, required this.stock});

  final Stock stock;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informações',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _InfoTile(
                icon: Icons.bar_chart_rounded,
                label: 'Volume',
                value: StockDisplayHelper.formatVolume(stock.volume),
              ),
              if (stock.marketCap != null) ...[
                const _InfoDivider(),
                _InfoTile(
                  icon: Icons.account_balance_rounded,
                  label: 'Valor de mercado',
                  value: StockDisplayHelper.formatMarketCap(stock.marketCap!),
                ),
              ],
              const _InfoDivider(),
              _InfoTile(
                icon: Icons.category_rounded,
                label: 'Tipo',
                value: stock.type == 'stock' ? 'Ação' : stock.type,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: AppColors.accent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _InfoDivider extends StatelessWidget {
  const _InfoDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 1,
        color: AppColors.textMuted.withValues(alpha: 0.2),
      ),
    );
  }
}
