import 'package:ecommerce_app/login/page/login.dart';
import 'package:ecommerce_app/providers/login_provider.dart';
import 'package:ecommerce_app/shared/widget/main_button.dart';
import 'package:ecommerce_app/shared/widget/normal_textfield.dart';
import 'package:ecommerce_app/shared/widget/password_textfield.dart';
import 'package:ecommerce_app/utils/images.dart';
import 'package:ecommerce_app/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
    final _nameController = TextEditingController();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

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
    String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    return null;
  }


  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _signUp(BuildContext context)async {
             final auth = ref.watch(authProvider.notifier);

    if (_formKey.currentState!.validate()) {

      // Implement sign up logic here
      print('Email: ${_emailController.text}, Password: ${_passwordController.text}');
   
    if (_formKey.currentState!.validate()) {
       final error = await auth.signup(
        _nameController.text,
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
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                }
    }
    }

  }

  @override
  Widget build(BuildContext context) {
             final auth = ref.watch(authProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Sign Up')
      
      , backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(

            children: [

            //  SizedBox(
            //     height: MediaQuery.sizeOf(context).height/16,
            //   ),
Image.asset(Images.logo, width: 200,height: 200,),
NormalextFormField(
                controller: _nameController,
                hintText: 'Name',
                // decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.text,
                validator: _validateName,
              ),
              SizedBox(
                height: 
                 AppSpacing.pagePadding.top,
               ),
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
              SizedBox(
                height: 
                 AppSpacing.pagePadding.top,
               ),
              CustomPasswordTextFormField(
                hintText:  'Confirm Password',
                controller: _confirmPasswordController,
                // decoration: const InputDecoration(labelText: 'Confirm Password'),
                // obscureText: true,
                validator: _validateConfirmPassword,
              ),
              const SizedBox(height: 20),
              
              MainButton(
                isLoading: ref.watch(authProvider),
              text: "Signup",
              onPressed:()=> _signUp(context),
              color: Theme.of(context).primaryColor
            ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to login screen
                },
                child:
                
                 Text.rich(TextSpan(children: [ 

const TextSpan(
  text: 'Already have an account? ', 
  style: TextStyle(color: Colors.black)
) ,

TextSpan(
  text: 'Login', 
  style: TextStyle(color: Theme.of(context).primaryColor)
) ,
                ]))
                
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
