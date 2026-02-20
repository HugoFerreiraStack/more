import 'package:b3/config/accessibility/app_semantics.dart';
import 'package:b3/config/themes/app_assets.dart';
import 'package:b3/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  static const _expandedHeight = 120.0;
  static const _compactHeight = 72.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: _expandedHeight,
      toolbarHeight: _compactHeight,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final rawT = ((constraints.maxHeight - _compactHeight) /
                  (_expandedHeight - _compactHeight))
              .clamp(0.0, 1.0);
          final t = Curves.easeInOutCubic.transform(rawT);
          return Container(
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
                padding: EdgeInsets.fromLTRB(
                  24,
                  _lerp(12, 16, t),
                  24,
                  _lerp(10, 20, t),
                ),
                child: Semantics(
                  container: true,
                  label: AppSemantics.header,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(_lerp(4, 8, t)),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(
                                    _lerp(10, 12, t),
                                  ),
                                ),
                                child: ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  child: ExcludeSemantics(
                                    child: Image.asset(
                                      AppAssets.logo,
                                      height: _lerp(20, 28, t),
                                      width: _lerp(20, 28, t),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'A Bolsa do Brasil',
                                    style: GoogleFonts.inter(
                                      fontSize: _lerp(15, 20, t),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Opacity(
                                    opacity: t,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: _lerp(0, 2, t)),
                                        Text(
                                          'Cotações em tempo real',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: Colors.white.withValues(alpha: 0.9),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;
}
