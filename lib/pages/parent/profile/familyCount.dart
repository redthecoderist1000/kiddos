import 'package:flutter/material.dart';

class FamilyCount extends StatelessWidget {
  final bool isSmall;

  const FamilyCount({required this.isSmall, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _CountCard(
            count: 1,
            label: 'Parent',
            color: Color(0xFF8B3EFF),
            isSmall: isSmall,
          ),
        ),
        SizedBox(width: isSmall ? 8 : 16),
        Expanded(
          child: _CountCard(
            count: 1,
            label: 'Children',
            color: Color(0xFFFFC700),
            isSmall: isSmall,
          ),
        ),
      ],
    );
  }
}

class _CountCard extends StatelessWidget {
  final int count;
  final String label;
  final Color color;
  final bool isSmall;

  const _CountCard({
    required this.count,
    required this.label,
    required this.color,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isSmall ? 80 : 120,
      padding: EdgeInsets.symmetric(vertical: isSmall ? 10 : 18),
      margin: EdgeInsets.symmetric(horizontal: isSmall ? 0 : 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmall ? 8 : 12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: isSmall ? 20 : 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: isSmall ? 2 : 4),
          Text(
            label,
            style: TextStyle(
              fontSize: isSmall ? 12 : 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}