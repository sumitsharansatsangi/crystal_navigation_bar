 import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
 

   final CrystalNavigationBarItem item;
   final bool isSelected;
    /// The color of the icon and text when the item is selected.
  final Color? selectedItemColor;
  final Duration  animationDuration;
  /// The color of the icon and text when the item is not selected.
  final Color? unselectedItemColor;
  final Curve curve;

  const NavItem(
    { super.key,
     required this.item,
     required this.isSelected, this.selectedItemColor, this.unselectedItemColor, required this.animationDuration, required this.curve, 
   });

   @override
   Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemColor = isSelected
        ? ( selectedItemColor ?? item.selectedColor ?? theme.colorScheme.primary)
        : ( unselectedItemColor ??
            item.unselectedColor ??
            theme.textTheme.bodyLarge?.color?.withAlpha(150) ??
            Colors.grey);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: item.height - 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: animationDuration,
            curve: curve,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? itemColor.withAlpha(40)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(
                    begin: 0.0,
                    end: isSelected ? 1.0 : 0.0,
                  ),
                  curve: Curves.easeOutBack,
                  duration: animationDuration,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, -4 * value),
                      child: Transform.scale(
                        scale: 1.0 + (0.2 * value),
                        child: Icon(
                         isSelected ? item.icon : item.unselectedIcon ?? item.icon,
                          color: itemColor.withAlpha(200),
                          size: item.iconSize,
                        ),
                      ),
                    );
                  },
                ),
                if (item.showBadge && item.badgeCount > 0) 
                       Positioned(
                        right: -10,
                        top: -10,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.elasticOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: 
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.error,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.error
                                          .withAlpha(200),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 18,
                                  minHeight: 18,
                                ),
                                child: Text(
                                  item.badgeCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
          if ( isSelected)
            AnimatedSlide(
              duration: animationDuration,
              curve: curve,
              offset: Offset(0, isSelected ? 0 : 0.2),
              child: AnimatedOpacity(
                duration: animationDuration,
                curve: curve,
                opacity: isSelected ? 1 : 0.7,
                child: Padding(
                padding: const EdgeInsets.only(top: 4),
                  child:item.text
                ),
              ),
            ),
        ],
      ),
    );
  }
}