import 'package:ecommerce_app/checkout/views/checkout.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {'name': 'Smartphone', 'price': 699.99, 'quantity': 1},
    {'name': 'Laptop', 'price': 1099.99, 'quantity': 1},
    {'name': 'T-Shirt', 'price': 19.99, 'quantity': 2},
  ];

  double getTotalCost() {
    return cartItems.fold(0, (total, item) => total + (item['price'] * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart items list
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Quantity: ${item['quantity']}'),
                    trailing: Text('\$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            Divider(),
            // Total cost
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: Theme.of(context).textTheme.headlineSmall),
                  Text('\$${getTotalCost().toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
            ),
            // Checkout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Proceed to Checkout'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(totalCost: getTotalCost())));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
