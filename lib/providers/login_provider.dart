import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/utils/Strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/auth_repo.dart';
class AuthViewModel{
  bool isLoading=false;
}

// Provider for AuthRepository
// final authRepositoryProvider = Provider((ref) => AuthRepository());

// StateNotifier for managing authentication state
class AuthState extends StateNotifier<bool> {
  final AuthRepository authRepository;

  AuthState(this.authRepository) : super(false);
    // state=false;
  Future<String?> login(String email, String password) async {
    try {
      state= true;
      final user = await authRepository.login(email, password);
             state= false;

      if (user != null) {
        // state = user;
        // var sharedPrefs=await SharedPreferences.getInstance();
       globalSharedPrefs.setBool(Strings.IS_LOGGED_IN, true);
              globalSharedPrefs.setString(Strings.USER_ID, user.id);
                 globalSharedPrefs.setString(Strings.USER_TOKEN, user.token.toString());
        return null;
      } else {
        return 'Invalid credentials';
      }
    } catch (e) {
             state= false;

      return 'Login failed: ${e.toString()}';
    }
  }
 Future<String?> signup(String name,String email, String password) async {
    try {
             state= true;

      final user = await authRepository.signup(name,email, password);
             state= false;

      if (user != null) {
        // state = user;
       

        return user;
      } else {
        return 'Registeration Failed';
      }
    } catch (e) {
             state= false;

      return 'Login failed: ${e.toString()}';
    }
  }

  void logout() {
    state = false;
  }
}

// Provider for AuthState
// final authProvider = StateNotifierProvider<AuthState, User?>((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return AuthState(authRepository);
// });
// Provider for AuthStateNotifier
final authProvider = StateNotifierProvider<AuthState,bool>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthState(authRepository);
});