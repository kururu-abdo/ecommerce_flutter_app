import 'package:flutter/material.dart';

class OrderStatusWidget extends StatelessWidget {
  final String? title;
  final int? index;
  final int? selecedIndex;
  final Function(int)? onSelect;
  const OrderStatusWidget({super.key, this.title, this.index, this.selecedIndex, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onSelect!(index!);
      },
      child: SizedBox(
        width: 80,
        child: Column(
          spacing: 5,
          
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
        Text(title.toString()), 
        Visibility(
          visible: index==selecedIndex,
          child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 10,height: 10, 
          decoration: const BoxDecoration(
            shape: BoxShape.circle , 
            color: Colors.black
          ),
        ))
        ],
        
        ),
      ),
    );
  }
}