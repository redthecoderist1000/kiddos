import 'package:flutter/material.dart';
import 'package:kiddos/components/provider/KiddosProvider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<void> signUp(
    BuildContext context,
    String email,
    String password,
    String uname,
    String role,
  ) async {
    await supabase.auth.signUp(email: email, password: password);
    await supabase.from('tbl_user').insert({
      'user_name': uname,
      'role': role,
      'email': email,
    });
    await userDetails(context);
  }

  Future<void> signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
    await userDetails(context);
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  User? get currentUser => supabase.auth.currentUser;

  Future<void> userDetails(BuildContext context) async {
    final userDetails = await supabase
        .from('vw_owninfo')
        .select()
        .maybeSingle();

    final provider = Provider.of<KiddosProvider>(context, listen: false);
    provider.setUserDetails(userDetails!);
  }
}
