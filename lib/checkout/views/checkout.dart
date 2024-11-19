import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalCost;

  CheckoutScreen({required this.totalCost});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cardNumberController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  }

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      // Implement payment processing here
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment processed successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Delivery Address', style: Theme.of(context).textTheme.displayMedium),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(hintText: 'Enter your delivery address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Payment Information', style: Theme.of(context).textTheme.displayMedium),
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(hintText: 'Card Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.length != 16) {
                    return 'Please enter a valid card number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: Theme.of(context).textTheme.headlineMedium),
                  Text('\$${widget.totalCost.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Confirm Payment'),
                  onPressed: _processPayment,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
