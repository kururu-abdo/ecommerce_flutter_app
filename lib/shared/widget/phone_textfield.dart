import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneFormField extends StatelessWidget {
  final String hintText;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const PhoneFormField({
    super.key,
    required this.hintText,
    this.height = 60.0,
    this.borderRadius = 12.0,
    this.backgroundColor = const Color(0xFFE0E0E0), // Default light gray
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,  // Set the height of the TextField
      child: TextFormField(

        inputFormatters: [_NumberTextInputFormatter(966)],
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,  // Add validation
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: backgroundColor, // Background color
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



class _NumberTextInputFormatter extends TextInputFormatter {
      final int _whichNumber;
      _NumberTextInputFormatter(this._whichNumber);

      @override
      TextEditingValue formatEditUpdate(
        TextEditingValue oldValue,
        TextEditingValue newValue,
      ) {
        final int newTextLength = newValue.text.length;
        int selectionIndex = newValue.selection.end;
        int usedSubstringIndex = 0;
        final StringBuffer newText = StringBuffer();
        switch (_whichNumber) {
          case 1:
            {
              if (newTextLength >= 1 ) {
                newText.write('(');
                if (newValue.selection.end >= 1) selectionIndex++;
              }
              if (newTextLength >= 4 ) {
                newText.write(
                    '${newValue.text.substring(0, usedSubstringIndex = 3)}) ');
                if (newValue.selection.end >= 3) selectionIndex += 2;
              }
              if (newTextLength >= 7 ) {
                newText.write(
                    '${newValue.text.substring(3, usedSubstringIndex = 6)}-');
                if (newValue.selection.end >= 6) selectionIndex++;
              }
              if (newTextLength >= 11 ) {
                newText.write(
                    '${newValue.text.substring(6, usedSubstringIndex = 10)} ');
                if (newValue.selection.end >= 10) selectionIndex++;
              }
              break;
            }
          case 91:
            {
              if (newTextLength >= 5) {
                newText.write(
                    '${newValue.text.substring(0, usedSubstringIndex = 5)} ');
                if (newValue.selection.end >= 6) selectionIndex++;
              }
              break;
            }
        }
        // Dump the rest.
        if (newTextLength >= usedSubstringIndex)
          newText.write(newValue.text.substring(usedSubstringIndex));
        return TextEditingValue(
          text: newText.toString(),
          selection: TextSelection.collapsed(offset: selectionIndex),
        );
      }
    }
