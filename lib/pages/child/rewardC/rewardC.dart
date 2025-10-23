import 'package:flutter/material.dart';
import 'package:kiddos/components/Header.dart';
import 'package:kiddos/components/provider/KiddosProvider.dart';
import 'package:kiddos/pages/child/rewardC/components/rewardCard.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RewardC extends StatefulWidget {
  const RewardC({super.key});

  @override
  State<RewardC> createState() => _RewardCState();
}

class _RewardCState extends State<RewardC> {
  final supabase = Supabase.instance.client;

  Future<dynamic> loadData() async {
    try {
      final res = await supabase.from('vw_rewardlistchild').select();

      return res;
    } catch (e) {
      throw Exception('Failed to load rewards. Try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KiddosProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            // no need for scaffold
            const Header(
              title: 'Rewards',
              subtitle:
                  'Treat yourself with something nice for your hard work!',
              imagePath: 'assets/gift.png',
            ),

            // points display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.stars_outlined,
                    color: Color(0xFF9810FA),
                    size: 20,
                  ),
                  Text(
                    '${provider.userDetails!['current_points']} points',
                    style: TextStyle(fontSize: 16, color: Color(0xFF9810FA)),
                  ),
                ],
              ),
            ),

            // grid of rewards
            FutureBuilder(
              future: loadData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error.toString()}'),
                  );
                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return Center(child: Text('No rewards available.'));
                } else {
                  final rewards = snapshot.data;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: rewards.length,
                    itemBuilder: (context, index) {
                      final reward = rewards[index];
                      return RewardCard(reward: reward);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
