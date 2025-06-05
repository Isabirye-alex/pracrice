import 'package:countries/countries.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class CountriesController extends GetxController {
  var country = Rxn<Country>();
  @override
  void onInit(){
    super.onInit();
    country.value = CountriesRepo.getCountryByPhoneCode('256');
  }

  void showCountryPickerDialog(BuildContext context) async {
    final selected = await showDialog<Country> (
      context: context,
      builder: (context){
        return StatefulBuilder(builder: (context, setState){
          return AlertDialog();
        });
      }
    );
  }

}