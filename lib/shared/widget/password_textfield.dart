import 'package:flutter/material.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  final String hintText;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomPasswordTextFormField({
    super.key,
    required this.hintText,
    this.height = 50.0,
    this.borderRadius = 12.0,
    this.backgroundColor = const Color(0xFFE0E0E0), // Default light gray
    this.controller,
    this.validator,
  });

  @override
  _CustomPasswordTextFormFieldState createState() => _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState extends State<CustomPasswordTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height, // Set the height of the TextField
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscure, // Toggles visibility of the text
        validator: widget.validator, // Add validation logic here
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: widget.backgroundColor, // Background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius), // Rounded corners
            borderSide: BorderSide.none, // No visible border
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.height * 0.3, // Adjust padding based on height
            horizontal: 16.0, // Horizontal padding
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
        style: const TextStyle(fontSize: 16), // Adjust font size if needed
      ),
    );
  }
}
