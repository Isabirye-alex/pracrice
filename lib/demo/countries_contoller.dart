import 'package:countries/countries.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class CountriesController extends GetxController {
  static CountriesController get instance => Get.find();
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
        String query = '';
        List<Country> filteredList = CountriesRepo.countryList;
        return StatefulBuilder(builder: (context, setState){
          return AlertDialog(
            title: TextField(
              decoration: InputDecoration(
                hintText: 'Search country.....',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
                ),
          ),
              onChanged: (value) {
                setState((){
                  query = value.toLowerCase();
                  filteredList= CountriesRepo.countryList.where((c)=> c.name.toLowerCase().contains(query) || c.phoneCode.toLowerCase().contains(query)).toList();
                });
              },
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.55,
              child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index){
                    final c = filteredList[index];
                return ListTile(
                  leading: CountryFlagWidget(c, width: 30),
                  title: Text(c.name),
                  subtitle: Text('+${c.phoneCode}'),
                  onTap:()=> Navigator.of(context).pop(c),
                );
              }),
            ),
          );
        });
      }
    );
    if(selected != null){
      country.value = selected;
    }
  }

}