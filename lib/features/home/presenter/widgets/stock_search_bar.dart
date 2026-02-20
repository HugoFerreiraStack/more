import 'package:b3/config/accessibility/app_semantics.dart';
import 'package:b3/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StockSearchBar extends StatelessWidget {
  const StockSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.focusNode,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Buscar ativos (ex: PETR4, Vale)',
          hintStyle: GoogleFonts.inter(
            fontSize: 15,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: ExcludeSemantics(
            child: Icon(
              Icons.search_rounded,
              size: 22,
              color: AppColors.textMuted,
            ),
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (_, value, __) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return Semantics(
                label: AppSemantics.searchClear,
                button: true,
                child: IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: AppColors.textMuted,
                  ),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                  splashRadius: 24,
                ),
              );
            },
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.accent, width: 1.5),
          ),
        ),
      ),
    );
  }
}
