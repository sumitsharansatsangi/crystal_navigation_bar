import 'package:flutter/material.dart';

/// A tab to display in a [CrystalNavigationBar]
class CrystalNavigationBarItem {
  /// An icon to display.
  final IconData icon;

  final Text? text;

  final bool showBadge;

  /// An icon to display.
  final IconData? unselectedIcon;

  ///badge notification count
  final int badgeCount;

  /// A primary color to use for this tab.
  final Color? selectedColor;

  /// The color to display when this tab is not selected.
  final Color? unselectedColor;

  final double height ;
  final double iconSize; 

  CrystalNavigationBarItem( {
    required this.icon,
    this.text,
    this.unselectedIcon,
    this.selectedColor,
    this.unselectedColor,
    this.showBadge= false,
    this.badgeCount =0,
    this.height=70,
    this.iconSize=24,
  });
}
