import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:crystal_navigation_bar/src/nav_item.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.curve,
    required this.duration,
    required this.selectedItemColor,
    required this.theme,
    required this.unselectedItemColor,
    required this.onTap,
    required this.itemPadding,
    required this.indicatorColor,
    this.splashBorderRadius,
    this.splashColor,
  });

  final List<CrystalNavigationBarItem> items;
  final int currentIndex;
  final Curve curve;
  final Duration duration;
  final Color? selectedItemColor;
  final ThemeData theme;
  final Color? unselectedItemColor;
  final Function(int index) onTap;
  final EdgeInsets itemPadding;
  final Color? indicatorColor;
  final Color? splashColor;
  final double? splashBorderRadius;

  @override
  Widget build(BuildContext context) {
    final primaryColor = theme.primaryColor;
    final defaultUnselectedColor = theme.iconTheme.color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          items.map((item) {
            final index = items.indexOf(item);
            final isSelected = index == currentIndex;
            final selectedColor =
                item.selectedColor ?? selectedItemColor ?? primaryColor;
            final unselectedColor =
                item.unselectedColor ??
                unselectedItemColor ??
                defaultUnselectedColor;

            return TweenAnimationBuilder<double>(
              tween: Tween(end: isSelected ? 1.0 : 0.0),
              curve: curve,
              duration: duration,
              builder: (context, t, _) {
                return Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(splashBorderRadius ?? 8),
                  clipBehavior: Clip.antiAlias,
                  child: Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerUp: (_) => onTap(index),
                    child: NavItem(
                      item: item,
                      isSelected: isSelected,
                      selectedItemColor: selectedColor,
                      unselectedItemColor: unselectedColor,
                      animationDuration: duration,
                      curve: curve,
                    ),
                  ),
                );
              },
            );
          }).toList(),
    );
  }
}
