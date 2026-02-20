import 'package:b3/config/accessibility/app_semantics.dart';
import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/presenter/widgets/widgets.dart';
import 'package:b3/features/wallet/presenter/controllers/wallet_controller.dart';
import 'package:b3/features/wallet/presenter/widgets/wallet_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletPage extends GetView<WalletController> {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const WalletHeader(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seus ativos',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Busque e acompanhe os ativos da sua carteira',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  StockSearchBar(
                    controller: controller.searchController,
                    onChanged: controller.onSearchChanged,
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () {
              final filtered = controller.filteredStocks;
              final isSearching = controller.searchQuery.value.isNotEmpty;
              if (filtered.isEmpty) {
                return SliverToBoxAdapter(
                  child: Semantics(
                    label: isSearching
                        ? AppSemantics.emptyWalletSearch
                        : AppSemantics.emptyWallet,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ExcludeSemantics(
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: AppColors.accentSoft,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isSearching
                                      ? Icons.search_off_rounded
                                      : Icons.account_balance_wallet_outlined,
                                  size: 48,
                                  color: AppColors.accent.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              isSearching
                                  ? 'Nenhum ativo encontrado'
                                  : 'Carteira vazia',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isSearching
                                  ? 'Tente outro termo na sua carteira'
                                  : 'Toque no ícone de estrela nos cards de ações para adicionar',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final stock = filtered[index];
                      return StockCard(stock: stock, showWalletButton: true);
                    },
                    childCount: filtered.length,
                  ),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
