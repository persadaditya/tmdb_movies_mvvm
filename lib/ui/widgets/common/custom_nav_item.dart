import 'package:flutter/material.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Use GestureDetector to detect taps
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        // Add styling for selected/unselected state
        decoration: BoxDecoration(
          color: isSelected ? appColorPrimarySoft : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          // Use Row for side-by-side arrangement
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? appColorPrimaryBlueAccent : Colors.grey,
            ),
            if (isSelected) // Optionally show label only when selected
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: appColorPrimaryBlueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
