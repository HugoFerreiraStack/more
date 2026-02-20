import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/presenter/controllers/home_controller.dart';
import 'package:b3/features/home/presenter/pages/home_page.dart';
import 'package:b3/features/wallet/presenter/pages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainTabPage extends GetView<HomeController> {
  const MainTabPage({super.key});

  static final _pages = [HomePage(), WalletPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          onTap: controller.setTabIndex,
          selectedItemColor: AppColors.accent,
          unselectedItemColor: AppColors.textMuted,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Carteira',
            ),
          ],
        ),
      ),
    );
  }
}
