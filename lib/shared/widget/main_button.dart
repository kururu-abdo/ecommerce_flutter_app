import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final bool? isLoading;
  const MainButton({super.key, 
    required this.text,
    required this.onPressed,
    this.color = AppColors.primary, // Default color is blue
    this.width = double.infinity, // Full width by default
    this.height = 50.0, this.isLoading=false, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Builder(
        builder: (context) {
          if (isLoading!) {
            return Center(child: CircularProgressIndicator(),);
          }
          return ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              
              backgroundColor: color, // Button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        }
      ),
    );
  }
}
