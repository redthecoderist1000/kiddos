import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  final dynamic item;

  const ProgressCard({super.key, this.item});

  getAction(status) {
    switch (status) {
      case 'Assigned':
        return 'was assigned';
      case 'Under Review':
        return 'submitted to review';
      case 'Completed':
        return 'completed';
      default:
        return 'performed an action';
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = item['total_tasks'] == 0
        ? 0.0
        : item['completed_task'] / item['total_task'];

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
                item['total_task'] > 0
                    ? CircularPercentIndicator(
                        arcType: ArcType.HALF,
                        reverse: true,
                        arcBackgroundColor: Colors.grey[100],
                        progressColor: progress == 1.0
                            ? Colors.greenAccent
                            : progress >= 0.5
                            ? Colors.amberAccent
                            : Colors.redAccent,
                        lineWidth: 10,
                        radius: 60,
                        percent: progress > 1.0 ? 1.0 : progress,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          '${(progress * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'no assigned tasks yet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                Text(
                  item['user_name'],
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                item['total_task'] > 0
                    ? Text(
                        progress == 1.0
                            ? 'All Done!'
                            : progress >= 0.5
                            ? 'In Progress!'
                            : 'Keep up bro!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : SizedBox(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.stars_outlined,
                      size: 50,
                      color: Colors.amberAccent,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'current points:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${item['current_points']}',
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
                item['recent_task'] == null
                    ? SizedBox()
                    : Padding(
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
                              itemCount: item['recent_task'].length > 3
                                  ? 3
                                  : item['recent_task'].length,
                              itemBuilder: (context, index) {
                                final task = item['recent_task'][index];
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 7),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100]?.withAlpha(50),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: getAction(task['status']),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ${task['task_name']}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
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
