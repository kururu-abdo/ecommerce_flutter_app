import 'package:ecommerce_app/dashboard/views/dashboard.dart';
import 'package:ecommerce_app/login/page/login.dart';
import 'package:ecommerce_app/onBoarding/view/onBoarding_page.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:ecommerce_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Duration of the animation
      vsync: this,
    );

    // Define a fade-in animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Start the animation
    _controller.forward();

    // Navigate to the main screen after a delay
    _navigateToHome();
  }

  // Navigate to the home screen after a delay
  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));
  ref.read(userProvider.notifier).checkIfloggedIn().then((status){
    if (status) {
       Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
    );
    }else{
 Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
    }
  });


   
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize the background color
      body: Center(
        child: FadeTransition(
          opacity: _animation, // Apply the animation to the logo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or splash image
              Image.asset(
                Images.logo, // Replace with the path to your logo asset
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to My App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
