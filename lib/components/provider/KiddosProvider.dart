import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KiddosProvider with ChangeNotifier {
  Map<String, dynamic>? _userDetails = {'user_name': ''};

  Map<String, dynamic>? get userDetails => _userDetails;

  void setUserDetails(Map<String, dynamic> details) {
    _userDetails = details;
    notifyListeners();
  }

  void updateUserDetails(Map<String, dynamic> details) {
    if (_userDetails != null) {
      _userDetails = {..._userDetails!, ...details};
      notifyListeners();
    }
  }

  // void autoUpdateUserDetails() {
  //   final supabase = Supabase.instance.client;
  //   final user = supabase.auth.currentUser;

  //   if (_userDetails != null) {
  //     notifyListeners();
  //   }
  // }
}
