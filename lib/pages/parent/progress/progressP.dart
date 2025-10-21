import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kiddos/pages/parent/progress/components/leaderboards.dart';
import 'package:kiddos/pages/parent/progress/components/progressCard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProgressP extends StatefulWidget {
  const ProgressP({super.key});

  @override
  State<ProgressP> createState() => _ProgressPState();
}

class _ProgressPState extends State<ProgressP> {
  final supabase = Supabase.instance.client;

  Future<dynamic> loadData() async {
    try {
      final res = await supabase.from('vw_leaderboards').select();
      return res;
    } catch (e) {
      throw Exception('Failed to load leaderboards');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;

    // List leaderboards = [
    //   {'name': '@nabong', 'score': 0},
    //   {'name': '@yoopewpew', 'score': 0},
    //   {'name': '@momoring', 'score': 0},
    //   {'name': '@shashahsa', 'score': 0},
    //   {'name': '@zyozyo', 'score': 0},
    //   {'name': '@nabong', 'score': 0},
    //   {'name': '@yoopewpew', 'score': 0},
    // ];

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: FutureBuilder(
          future: loadData(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            // Error handling
            if (asyncSnapshot.hasError) {
              return Center(child: Text('Error: ${asyncSnapshot.error}'));
            }

            final leaderboards = asyncSnapshot.data;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Progress',
                    style: TextStyle(
                      fontSize: isSmall ? 24 : 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B3EFF),
                    ),
                  ),
                ),
                SizedBox(height: isSmall ? 4 : 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),

                  child: Text(
                    "Indulge how great your children are doing so far!",
                    style: TextStyle(
                      fontSize: isSmall ? 13 : 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: isSmall ? 16 : 28),

                // Leaderboards
                Leaderboards(data: leaderboards),

                // carousel
                CarouselSlider(
                  items: List.generate(leaderboards.length, (index) {
                    final item = leaderboards[index];

                    return ProgressCard(item: item);
                  }),
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    // aspectRatio: 2.0,
                    enableInfiniteScroll: false,
                    height: 600,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
