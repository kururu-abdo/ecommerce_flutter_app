import 'dart:io';

import 'package:ecommerce_app/search/view/search_screen.dart';
import 'package:ecommerce_app/utils/route.dart';
import 'package:flutter/material.dart';

class HomeSearchButton extends StatefulWidget {
  const HomeSearchButton({super.key});

  @override
  State<HomeSearchButton> createState() => _HomeSearchButtonState();
}

class _HomeSearchButtonState extends State<HomeSearchButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, 
        
        RouteManager.buildRoute(const SearchScreen(), Platform.isIOS)
        );
      },
      child: Container( 
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), 
          color: Colors.grey[100], 
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      Icon(Icons.search, 
          color: Colors.grey[500], 
      
      
      ), 
      Text("Search the entire shop", 
      style: TextStyle(
         color: Colors.grey[500], 
      ),
      )
      
      
          ],
        ),
      ),
    );
  }
}