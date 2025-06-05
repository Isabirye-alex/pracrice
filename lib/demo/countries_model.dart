import 'package:countries/countries.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:networking/demo/countries_contoller.dart';
class CountriesModel extends StatefulWidget {
  const CountriesModel({super.key});

  @override
  State<CountriesModel> createState() => _CountriesModelState();
}

class _CountriesModelState extends State<CountriesModel> {
  final countriesController = Get.put(CountriesController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: size.width*0.9,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: ()=> countriesController.showCountryPickerDialog(context),
                   child: Obx((){
                     final selectedCountry = countriesController.country.value;
                     return Container(
                       decoration: BoxDecoration(border: Border.all()),
                       child: Row(
                         children: [
                           if(selectedCountry != null) ... [
                             CountryFlagWidget(selectedCountry, width: 30),
                             Flexible(child: Text(selectedCountry.name)),
                             Flexible(child: Text('+${selectedCountry.phoneCode}')),

                           ]
                           else
                             Text('Select'),
                              Spacer(),
                              Icon(Icons.arrow_drop_down)
                         ],
                       ),
                     );
                   })),
                  ),
              Expanded(
                  flex: 7,
                  child: TextField(
                    // controller: countriesController.country.value.phoneCode,
                    inputFormatters: [],
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
