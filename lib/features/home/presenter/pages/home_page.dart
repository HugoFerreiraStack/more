import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/presenter/controllers/home_controller.dart';
import 'package:b3/features/home/presenter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          CustomScrollView(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              const HomeHeader(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Principais ativos',
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Acompanhe as cotações da B3',
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
                      const SizedBox(height: 16),
                      Obx(
                        () => StockSortButtons(
                          currentSort: controller.sortBy.value,
                          sortDescending: controller.sortDescending.value,
                          onSortChanged: controller.setSort,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () {
                  final filtered = controller.filteredStocks;
                  final isSearching = controller.searchQuery.value.isNotEmpty;
                  if (isSearching && filtered.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Semantics(
                        label: 'Nenhum ativo encontrado. Tente outro termo, por exemplo PETR4 ou Vale.',
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 48),
                          child: Center(
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ExcludeSemantics(
                                child: Icon(
                                  Icons.search_off_rounded,
                                  size: 48,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Nenhum ativo encontrado',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Tente outro termo (ex: PETR4, Vale)',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: AppColors.textMuted,
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
                          return StockCard(stock: stock);
                        },
                        childCount: filtered.length,
                      ),
                    ),
                  );
                },
              ),
              Obx(
                () => controller.isLoadingMore.value
                    ? SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: SizedBox(
                              width: 26,
                              height: 26,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter(child: SizedBox.shrink()),
              ),
              Obx(
                () => controller.errorMessage.value.isNotEmpty
                    ? SliverToBoxAdapter(
                        child: Semantics(
                        label: 'Erro ao carregar. ${controller.errorMessage.value}',
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ExcludeSemantics(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withValues(alpha: 0.08),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.error_outline_rounded,
                                    size: 40,
                                    color: AppColors.error,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                controller.errorMessage.value,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: AppColors.textSecondary,
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Semantics(
                                label: 'Tentar novamente. Recarregar cotações.',
                                button: true,
                                child: FilledButton.icon(
                                  onPressed: () => controller.fetchStocks(),
                                icon: const Icon(Icons.refresh_rounded, size: 20),
                                label: const Text('Tentar novamente'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.accent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            ],
                          ),
                        ),
                        ),
                      )
                    : const SliverToBoxAdapter(child: SizedBox.shrink()),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
          Obx(
            () => controller.isLoading.value
                ? Semantics(
                    label: 'Carregando cotações. Por favor aguarde.',
                    child: Container(
                    color: AppColors.surface.withValues(alpha: 0.95),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 44,
                            height: 44,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: AppColors.accent,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Carregando cotações...',
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
