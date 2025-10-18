import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final String? imagePath; // Add image path parameter
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const Header({
    Key? key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.imagePath,
    this.onBackPressed,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                if (onBackPressed != null)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: onBackPressed,
                  ),
                const Spacer(),
                if (actions != null) ...actions!,
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  child: imagePath != null
                      ? Image.asset(
                          imagePath!,
                          width: 40,
                          height: 40,
                        )
                      : Icon(
                          icon ?? Icons.help,
                          color: Colors.blue.shade600,
                          size: 24,
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}