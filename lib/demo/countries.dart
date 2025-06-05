import 'package:countries/countries.dart';
import 'package:flutter/material.dart';
import 'phone_form.dart';

void main() => runApp(
  MaterialApp(
    title: 'Countries Demo',
    home: DemoPage(),
  ),
);


class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
  late Country country;

  @override
  void initState() {
    super.initState();
     country = CountriesRepo.getCountryByPhoneCode('90');
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Text('Phone Form'),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () => showCountryPickerDialog(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        CountryFlagWidget(country, width: 24),
                        SizedBox(width: 8),
                        Flexible(child: Text("+${country.phoneCode}", overflow: TextOverflow.ellipsis)),
                        SizedBox(width: 4),
                        Flexible(child: Text(country.name, overflow: TextOverflow.ellipsis)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),

                  ),
                ),
              ),

              SizedBox(width: 10),
              Expanded(
                flex: 7,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),

          // SizedBox(height: 30),
          // Text('Bottom Sheet'),
          // GestureDetector(
          //   onTap: () => showCountriesBottomSheet(
          //     context,
          //     onValuePicked: (v) => setState(() => country = v),
          //   ),
          //   child: CountryFlagWidget(
          //     country,
          //     width: 20,
          //   ),
          // ),
          // SizedBox(height: 30),
          // Text('Dropdown'),
          // CountryPickerDropdown(
          //   onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          //   isDense: false,
          //   onValuePicked: (Country country) {
          //     setState(() => country = country);
          //   },
          //   itemBuilder: (Country country) {
          //     return Row(
          //       children: <Widget>[
          //         SizedBox(width: 8.0),
          //         CountryFlagWidget(country),
          //         SizedBox(width: 8.0),
          //         Expanded(child: Text(country.name)),
          //       ],
          //     );
          //   },
          //   isExpanded: true,
          // ),
          // SizedBox(height: 30),
          // Text("Dialog"),
          // ListTile(
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) => Theme(
          //         data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          //         child: CountryPickerDialog(
          //           searchWidgetStyle: SearchWidgetStyle(
          //             searchCursorColor: Colors.pinkAccent,
          //             searchInputDecoration: InputDecoration(hintText: 'Search...'),
          //           ),
          //           onValuePicked: (Country country) =>
          //               setState(() => country = country),
          //           priorityList: [
          //             CountriesRepo.getCountryByIsoCode('TR'),
          //             CountriesRepo.getCountryByIsoCode('US'),
          //           ].whereType<Country>().toList(), // Safely handle potential nulls
          //         ),
          //       ),
          //     );
          //   },
          //   title: Row(
          //     children: <Widget>[
          //       CountryFlagWidget(country),
          //       SizedBox(width: 8.0),
          //       Text("+${country.phoneCode}"),
          //       SizedBox(width: 8.0),
          //       Flexible(child: Text(country.name)),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 30),
        ],
      ),
    );
  }
}
