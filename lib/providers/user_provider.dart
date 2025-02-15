import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/utils/Strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UtilNotifier extends StateNotifier {
  UtilNotifier() : super(null);



Future<bool> checkIfloggedIn() async {
    state = null;

   return  globalSharedPrefs.getBool(Strings.IS_LOGGED_IN)??false;
  }
String? getAuthToken()  {
late String token;
    //  SharedPreferences.getInstance().then((prefs)async{
 token =globalSharedPrefs.getString(Strings.USER_TOKEN)??'';
    //  });
    return token;
  }

  // Clear user data
  Future<void> logout() async {
    state = null;

    // Remove data from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Strings.IS_LOGGED_IN);
        prefs.remove(Strings.USER_TOKEN);

  }
}

// Riverpod provider for user login data
final userProvider = StateNotifierProvider<UtilNotifier, void>((ref) {
  return UtilNotifier();
});
