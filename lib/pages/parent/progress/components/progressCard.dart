import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  final dynamic item;

  const ProgressCard({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          width: double.infinity,
          height: 500,
          padding: EdgeInsets.only(top: 70),
          margin: EdgeInsets.only(top: 65),
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent[100],
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                CircularPercentIndicator(
                  arcType: ArcType.HALF,
                  reverse: true,
                  arcBackgroundColor: Colors.grey[100],
                  progressColor: Colors.greenAccent,
                  lineWidth: 10,
                  radius: 60,
                  percent: 0.50,
                  center: Text(
                    '100%',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'All Done!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.rocket_launch_rounded,
                      size: 50,
                      color: Colors.amberAccent,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'current trophies:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '123',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // recent task
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'recent tasks:',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 7),
                            decoration: BoxDecoration(
                              color: Colors.grey[100]?.withAlpha(100),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              'walis sala',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          radius: 65,
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.face_5_rounded, size: 100),
        ),
      ],
    );
  }
}
