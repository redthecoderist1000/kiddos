import 'package:flutter/material.dart';
import 'package:kiddos/pages/parent/profile/familyMemberTile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FamilyMemberList extends StatefulWidget {
  final bool isSmall;

  const FamilyMemberList({required this.isSmall, super.key});

  @override
  State<FamilyMemberList> createState() => _FamilyMemberListState();
}

class _FamilyMemberListState extends State<FamilyMemberList> {
  final supabase = Supabase.instance.client;
  final childChannel = Supabase.instance.client.channel('public:tbl_user');
  Future<dynamic> fetchChildren() async {
    try {
      final res = await supabase.from('vw_getchild').select('*');

      return res;
    } catch (e) {
      throw Exception('Failed to load children');
    }
  }

  @override
  void initState() {
    super.initState();

    childChannel.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'tbl_user',
      callback: (payload) => {
        print('Change received in tbl_user: $payload'),
        setState(() {}),
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    supabase.removeChannel(childChannel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.isSmall ? 10 : 16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.all(widget.isSmall ? 10 : 16),
      child: FutureBuilder(
        future: fetchChildren(),
        builder: (context, asyncSnapshot) {
          // if loading
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // if error
          if (asyncSnapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Text(
                    '${asyncSnapshot.error}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: widget.isSmall ? 12 : 14,
                    ),
                  ),
                  // refresh button
                  MaterialButton(
                    elevation: 0,
                    onPressed: () => setState(() {}),
                    child: Text(
                      'Retry',
                      style: TextStyle(fontSize: widget.isSmall ? 12 : 14),
                    ),
                  ),
                ],
              ),
            );
          }

          if (!asyncSnapshot.hasData) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Text(
                    'No linked child accounts found.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: widget.isSmall ? 12 : 14,
                    ),
                  ),
                  MaterialButton(
                    elevation: 0,
                    onPressed: () => setState(() {}),
                    child: Text(
                      'Retry',
                      style: TextStyle(fontSize: widget.isSmall ? 12 : 14),
                    ),
                  ),
                ],
              ),
            );
          }

          final members = asyncSnapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.groups,
                    color: Colors.black87,
                    size: widget.isSmall ? 18 : 24,
                  ),
                  SizedBox(width: widget.isSmall ? 4 : 8),
                  Text(
                    'Child Accounts (${members.length})',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.isSmall ? 13 : 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: widget.isSmall ? 2 : 4),
              Text(
                'View child accounts linked to your profile.',
                style: TextStyle(
                  fontSize: widget.isSmall ? 10 : 12,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: widget.isSmall ? 8 : 16),
              ...List.generate(members.length, (index) {
                final member = members[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == members.length - 1
                        ? 0
                        : (widget.isSmall ? 8 : 12),
                  ),
                  child: FamilyMemberTile(
                    name: member['user_name'],
                    email: member['email'],
                    isSmall: widget.isSmall,
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
