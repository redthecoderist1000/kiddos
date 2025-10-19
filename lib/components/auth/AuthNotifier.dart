import 'package:flutter/material.dart';
import 'package:kiddos/components/auth/AuthService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? user;

  AuthNotifier() {
    _authService.supabase.auth.onAuthStateChange.listen((data) {
      user = data.session?.user;
      notifyListeners();
    });
  }

  bool get isAuthenticated => user != null;
}
