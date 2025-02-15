import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  final double productTotal;
  final double discount;
  final double shipping;
  final double tax;
  final double grandTotal;

  const OrderSummaryWidget({
    super.key,
    required this.productTotal,
    required this.discount,
    required this.shipping,
    required this.tax,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 0.0,
      color: Colors.transparent,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(12.0),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Divider(),
            _buildSummaryRow('Product Total', productTotal),
            const SizedBox(height: 8.0),
            _buildSummaryRow('Discount', discount, isNegative: true),
            const SizedBox(height: 8.0),
            _buildSummaryRow('Shipping', shipping),
            const SizedBox(height: 8.0),
            _buildSummaryRow('Tax', tax),
            const Divider(),
            _buildSummaryRow(
              'Grand Total',
              grandTotal,
              isBold: true,
              isLarge: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    double amount, {
    bool isBold = false,
    bool isLarge = false,
    bool isNegative = false,
  }) {
    final textStyle = TextStyle(
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontSize: isLarge ? 18.0 : 16.0,
      color: isNegative ? Colors.red : null,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textStyle),
        Text(
          '${isNegative ? '-' : ''}\$${amount.toStringAsFixed(2)}',
          style: textStyle,
        ),
      ],
    );
  }
}
