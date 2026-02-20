import 'package:b3/config/accessibility/app_semantics.dart';
import 'package:b3/config/themes/app_colors.dart';
import 'package:b3/features/home/domain/models/stock.dart';
import 'package:b3/features/wallet/presenter/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToWalletButton extends StatelessWidget {
  const AddToWalletButton({
    super.key,
    required this.stock,
    this.size = 40,
    this.iconSize = 22,
    this.foreground = Colors.white,
    this.backgroundOpacity = 0.15,
  });

  final Stock stock;
  final double size;
  final double iconSize;
  final Color foreground;
  final double backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    final wallet = WalletController.to;

    return Obx(
      () {
        final isInWallet = wallet.isInWallet(stock.stock);
        return Semantics(
          button: true,
          label: isInWallet
              ? AppSemantics.removeFromWallet(stock.stock)
              : AppSemantics.addToWallet(stock.stock),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => wallet.toggle(stock),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: foreground.withValues(alpha: backgroundOpacity),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isInWallet
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  size: iconSize,
                  color: isInWallet
                      ? AppColors.accent
                      : foreground.withValues(alpha: 0.9),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
