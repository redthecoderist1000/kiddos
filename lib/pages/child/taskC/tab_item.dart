import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final Color badgeColor;
  final bool isSelected;
  final VoidCallback onTap;

  const TabItem({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    required this.badgeColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 350;

    return Flexible(
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: isSmall ? 32 : 40,
          margin: EdgeInsets.symmetric(
              horizontal: isSmall ? 2 : 4, vertical: isSmall ? 2 : 4),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(isSmall ? 10 : 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : color,
                size: isSmall ? 16 : 20,
              ),
              SizedBox(width: isSmall ? 3 : 6),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: isSmall ? 12 : 14,
                  ),
                ),
              ),
              SizedBox(width: isSmall ? 3 : 6),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: isSmall ? 5 : 8, vertical: isSmall ? 1 : 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withOpacity(0.2) : badgeColor,
                  borderRadius: BorderRadius.circular(isSmall ? 8 : 12),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmall ? 10 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
