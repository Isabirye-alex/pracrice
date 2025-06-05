import 'package:flutter/material.dart';
import 'package:networking/demo/object_class.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ObjectWidget extends StatefulWidget {
  const ObjectWidget({super.key});

  @override
  State<ObjectWidget> createState() => _ObjectWidgetState();
}

class _ObjectWidgetState extends State<ObjectWidget> {
  final TextEditingController controller = TextEditingController();
  late Future<UssdViewObject> _futureResults;
  late String sessionText = '';

  @override
  void initState(){
    super.initState();
    setState(() {
      sessionText = controller.text.trim();
      _futureResults = sendUssdRequestWithResponse(sessionText);
    });
  }

  Future<UssdViewObject> sendUssdRequestWithResponse(String userInput) async {
    try {
      final response = await http.post(Uri.parse('https://newtest.mcash.ug/wallet/api/client/ussd'),
      body: <String, String> {
        'phoneNumber': '+256706432259',
        'text': sessionText,
      }
      );
      if(response.statusCode == 201 || response.statusCode == 200){
        return UssdViewObject.fromUssdString(
          response.body,
          phoneNumber: '+256706432259'
        );
      }else {
        throw Exception('Good Morning: ${response.reasonPhrase}');
      }
    } catch (e){
      throw Exception('Error: $e');
    }
  }

  FutureBuilder<UssdViewObject> buildFutureBuilder() {
    return FutureBuilder<UssdViewObject>(
      future: _futureResults,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError){
          return Text('${snapshot.error}');
        } else if (snapshot.hasData){
          final ussdObject = snapshot.data!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: ussdObject.options?.length ?? 0,
                      itemBuilder: (context, index){
                        if(ussdObject.options == null ||
                            index >= ussdObject.options!.length
                        ){
                          return ListTile(title: Text('No options available'));
                        }
                        final option = ussdObject.options![index];
                        return ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text(option, style: TextStyle(fontSize: 16)),
                        );
                      }
                  )
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(),
                  maxLines: 1,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                margin: EdgeInsets.only(left: 16, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          final currentInput = controller.text.trim();
                          if (currentInput.isNotEmpty) {
                            setState(() {
                              sessionText = sessionText.isEmpty
                                  ? currentInput
                                  : '$sessionText*$currentInput';
                              _futureResults = sendUssdRequestWithResponse(
                                sessionText,
                              );
                              controller.clear();
                            });
                            print('Full sessionText: $sessionText');
                          }
                        });
                      },
                      child: const Text(
                        'SEND',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

        } else {
          throw Exception('Black and Wait: ${snapshot.error}');
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(70),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.all(
            20,
          ), // Controls space around the dialog
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9, // Custom width
              child: Material(child: buildFutureBuilder()),
            ),
          ),
        ),
      ),
    );
  }
}
