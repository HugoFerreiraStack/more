import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/presenter/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StockSortButtons extends StatelessWidget {
  const StockSortButtons({
    super.key,
    required this.currentSort,
    required this.sortDescending,
    required this.onSortChanged,
  });

  final StockSort? currentSort;
  final bool sortDescending;
  final ValueChanged<StockSort> onSortChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Ordenar lista por',
      child: LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          _SortChip(
            label: 'Nome',
            icon: Icons.business_rounded,
            isSelected: currentSort == StockSort.name,
            sortDescending: currentSort == StockSort.name ? sortDescending : null,
            onTap: () => onSortChanged(StockSort.name),
          ),
          const SizedBox(width: 8),
          _SortChip(
            label: 'Preço',
            icon: Icons.attach_money_rounded,
            isSelected: currentSort == StockSort.price,
            sortDescending: currentSort == StockSort.price ? sortDescending : null,
            onTap: () => onSortChanged(StockSort.price),
          ),
          const SizedBox(width: 8),
          _SortChip(
            label: 'Variação',
            icon: Icons.trending_up_rounded,
            isSelected: currentSort == StockSort.change,
            sortDescending: currentSort == StockSort.change ? sortDescending : null,
            onTap: () => onSortChanged(StockSort.change),
          ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.sortDescending,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool? sortDescending;

  @override
  Widget build(BuildContext context) {
    String semanticsLabel;
    if (isSelected && sortDescending != null) {
      final dir = label == 'Nome'
          ? (sortDescending! ? 'Z a A' : 'A a Z')
          : (sortDescending! ? 'maior primeiro' : 'menor primeiro');
      semanticsLabel =
          'Ordenar por $label, $dir. Toque para inverter ou remover ordenação.';
    } else {
      semanticsLabel = 'Ordenar por $label';
    }

    return Semantics(
      label: semanticsLabel,
      button: true,
      toggled: isSelected,
      child: Material(
        color: isSelected ? AppColors.accent : Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: isSelected ? 0 : 1,
        shadowColor: AppColors.textPrimary.withValues(alpha: 0.08),
        child: InkWell(
          onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ExcludeSemantics(
                child: Icon(
                  icon,
                  size: 18,
                color: isSelected ? Colors.white : AppColors.textMuted,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
