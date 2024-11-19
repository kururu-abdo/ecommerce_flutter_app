import 'package:ecommerce_app/dashboard/views/dashboard.dart';
import 'package:ecommerce_app/providers/login_provider.dart';
import 'package:ecommerce_app/shared/widget/main_button.dart';
import 'package:ecommerce_app/shared/widget/normal_textfield.dart';
import 'package:ecommerce_app/shared/widget/password_textfield.dart';
import 'package:ecommerce_app/signup/page/signup.dart';
import 'package:ecommerce_app/utils/images.dart';
import 'package:ecommerce_app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
bool _rememberMe=false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _login(BuildContext context )async{
     final auth = ref.watch(authProvider.notifier);
    if (_formKey.currentState!.validate()) {
       final error = await auth.login(
                  _emailController.text,
                  _passwordController.text,
                );

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error)),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardPage()),
                  );
                }
    }
  }

  @override
  Widget build(BuildContext context) {
         final auth = ref.watch(authProvider.notifier);

    return Scaffold(
      backgroundColor:Colors.white,
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //    backgroundColor: Colors.transparent,
        
      //   title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(

            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height/4,
              ),
Image.asset(Images.logo),
  NormalextFormField(
                controller: _emailController,
                hintText: 'Email',
                // decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
               SizedBox(
                height: 
                 AppSpacing.pagePadding.top,
               ),
            CustomPasswordTextFormField(
                controller: _passwordController,
                hintText: 'Password',
                // decoration: const InputDecoration(labelText: 'Password'),
                // obscureText: true,
                validator: _validatePassword,
              ),
              const SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: _login,
              //   child: Text('Login'),
              // ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text('Remember Me'),
                ],
              ),
                         const SizedBox(height: 10),

               MainButton(
              text: "Login",
              isLoading: ref.watch(authProvider),
              onPressed:()=> _login(context),
              color: Theme.of(context).primaryColor
            ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                child:
                Text.rich(TextSpan(children: [ 

const TextSpan(
  text: 'Don\'t have an account? ', 
  style: TextStyle(color: Colors.black)
) ,

TextSpan(
  text: 'Sign Up', 
  style: TextStyle(color: Theme.of(context).primaryColor)
) ,
                ]))
                
                //  const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
