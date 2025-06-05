import 'package:countries/countries.dart';
import 'package:flutter/material.dart';

class PhoneFormWidget extends StatelessWidget {
  final TextEditingController codeController;
  final TextEditingController phoneController;
  final ValueChanged<Country> onSelectCountry;

  const PhoneFormWidget({super.key,
    required this.codeController,
    required this.phoneController,
    required this.onSelectCountry,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showCountriesBottomSheet(
              context,
              onValuePicked: onSelectCountry,
            );
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Text('+${codeController.text}'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
