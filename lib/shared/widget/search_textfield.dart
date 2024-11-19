import 'package:flutter/material.dart';

class SearchTextFormField extends StatelessWidget {
  final String hintText;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const SearchTextFormField({
    super.key,
    required this.hintText,
    this.height = 60.0,
    this.borderRadius = 12.0,
    this.backgroundColor = const  Color(0xFFE0E0E0), // Default light gray
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,  // Set the height of the TextField
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,  // Add validation
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
          hintText: hintText,
          filled: true,
          fillColor: backgroundColor.withOpacity(.5), // Background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
            borderSide: BorderSide.none,                       // No visible border
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: height * 0.3,  // Adjust based on height
            horizontal: 16.0,        // Padding inside the TextField
          ),
        ),
        style: const TextStyle(fontSize: 16), // Adjust font size if needed
      ),
    );
  }
}