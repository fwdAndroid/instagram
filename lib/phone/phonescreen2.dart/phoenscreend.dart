import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:instagram/phone/phonescreen2.dart/otcontroller.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({ Key? key }) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  String dialCodeDigits = "+92";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            width: 300,
            height: 100,
            child: CountryCodePicker(onChanged: (country){
              setState(() {
                dialCodeDigits = country.dialCode!;
              });
              
            },
            initialSelection: "PK",
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            favorite:["+92","PAK"]
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Phone Number",
                prefix: Padding(padding: EdgeInsets.all(10),child: Text(dialCodeDigits,style: TextStyle(color: Colors.black),),),
                
              ),
              keyboardType:TextInputType.number,
              controller: _controller,
            ),

            
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder) =>Ot(
              phone:_controller.text,
              codeDigits: dialCodeDigits
            )));
          }, child: Text('Fawad'))
        ],
      ),
    );
  }
}