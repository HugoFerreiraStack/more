import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/domain/models/stock.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  final Stock stock;

  const StockCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final changeColor = stock.isPositive ? AppColors.success : AppColors.error;
    final changePrefix = stock.isPositive ? '+' : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                left: BorderSide(color: AppColors.primary, width: 4),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildLogo(),
                const SizedBox(width: 14),
                Expanded(child: _buildInfo()),
                _buildPrice(changeColor, changePrefix),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: stock.logo,
        width: 44,
        height: 44,
        fit: BoxFit.contain,
        placeholder: (_, __) => _buildLogoPlaceholder(),
        errorWidget: (_, __, ___) => _buildLogoError(),
      ),
    );
  }

  Widget _buildLogoPlaceholder() {
    return Container(
      width: 44,
      height: 44,
      color: AppColors.accent,
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildLogoError() {
    return Container(
      width: 44,
      height: 44,
      color: AppColors.accent,
      child: Icon(
        Icons.show_chart_rounded,
        color: AppColors.primary.withOpacity(0.5),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              stock.stock,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            if (stock.sector != null) ...[
              const SizedBox(width: 6),
              Flexible(
                child: _buildSectorBadge(stock.sector!),
              ),
            ],
          ],
        ),
        const SizedBox(height: 2),
        Text(
          stock.name,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSectorBadge(String sector) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        sector,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPrice(Color changeColor, String changePrefix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'R\$ ${stock.close.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$changePrefix${stock.change.toStringAsFixed(2)}%',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: changeColor,
          ),
        ),
      ],
    );
  }
}
