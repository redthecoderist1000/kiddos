import 'package:flutter/material.dart';

class TaskTabsP extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TaskTabsP({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double horizontalPadding = width < 400 ? 12 : width < 600 ? 18 : 22;
    double verticalPadding = width < 400 ? 6 : width < 600 ? 8 : 10;
    double fontSize = width < 400 ? 12 : width < 600 ? 13 : 15;
    double borderRadius = width < 400 ? 8 : 12;

    final tabData = [
      {
        'label': 'On Going',
        'color': const Color(0xFF2972FE),
      },
      {
        'label': 'Pending',
        'color': const Color(0xFFFF5E3A),
      },
      {
        'label': 'Completed',
        'color': const Color(0xFF16C98D),
      },
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(tabData.length, (index) {
              final isSelected = selectedIndex == index;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < tabData.length - 1 ? 8 : 0),
                  child: GestureDetector(
                    onTap: () => onTabSelected(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? tabData[index]['color'] as Color : Colors.white,
                        borderRadius: BorderRadius.circular(borderRadius),
                        boxShadow: isSelected
                            ? [const BoxShadow(color: Colors.black12, blurRadius: 2)]
                            : [],
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        tabData[index]['label'] as String,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}