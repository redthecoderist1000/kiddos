import 'package:flutter/material.dart';
import 'package:kiddos/components/Header.dart';
import 'package:kiddos/pages/parent/rewardPage/rewardTab/rewardList/rewardList.dart';
import 'package:kiddos/pages/parent/rewardPage/rewardTab/pendingReward/pendingReward.dart';
import 'package:kiddos/pages/parent/rewardPage/rewardTab/rewardHistory/rewardHistory.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({Key? key}) : super(key: key);

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double horizontalPadding = width < 400
        ? 12
        : width < 600
        ? 18
        : 22;
    double verticalPadding = width < 400
        ? 6
        : width < 600
        ? 8
        : 10;
    double fontSize = width < 400
        ? 12
        : width < 600
        ? 13
        : 15;
    double borderRadius = width < 400 ? 8 : 12;

    final tabData = [
      {'label': 'Reward List', 'color': const Color(0xFF2972FE)},
      {'label': 'Pending', 'color': const Color(0xFFFF5E3A)},
      {'label': 'History', 'color': const Color(0xFF16C98D)},
    ];

    return Column(
      children: [
        const Header(
          title: 'Rewards',
          subtitle: 'Create rewards your kids can earn with points',
          imagePath: 'assets/gift.png',
        ),
        // custome tabs
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(tabData.length, (index) {
                  final isSelected = _tabController.index == index;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index < tabData.length - 1 ? 8 : 0,
                      ),
                      child: GestureDetector(
                        onTap: () => _onTabSelected(index),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: verticalPadding,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? tabData[index]['color'] as Color
                                : Colors.white,
                            borderRadius: BorderRadius.circular(borderRadius),
                            boxShadow: isSelected
                                ? [
                                    const BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2,
                                    ),
                                  ]
                                : [],
                            border: Border.all(color: Colors.transparent),
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
        ),

        // Tab Views - Fixed height container
        Expanded(
          // height: MediaQuery.of(context).size.height * 0.8,
          child: TabBarView(
            controller: _tabController,
            children: const [
              RewardList(),
              PendingRewardPage(),
              RewardHistory(),
            ],
          ),
        ),
        // SizedBox(height: 20),
      ],
    );
  }
}
