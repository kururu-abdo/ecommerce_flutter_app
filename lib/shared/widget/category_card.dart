import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryCard extends StatelessWidget {
  // final Category category;
  final String? name;
  final bool? isLoading;
  const CategoryCard({Key? key, required this.name, this.isLoading =false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (isLoading!) {
          return Skeletonizer( 
child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Chip(
            label: Text('category'),
          ),
        ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Chip(
            label: Text(name!),
          ),
        );
      }
    );
  }
}