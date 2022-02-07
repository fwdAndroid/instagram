import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:instagram/phone/otpcontrolleer.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({ Key? key }) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  String dialCodeDigit = "+00";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SizedBox(
            width:400,
            height: 90,
            child: CountryCodePicker(
               onChanged: (country){
                 setState(() {
                   dialCodeDigit = country.dialCode!;

                 });
               },
               initialSelection: 'IT',
               showCountryOnly: false,
               showOnlyCountryWhenClosed: false,
               favorite:["+1","US","+92","PAK"]

              ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                prefix: Padding(padding: EdgeInsets.all(4),
                child: Text(dialCodeDigit),)
              ),
              maxLength: 12,
              controller: controller,
              keyboardType: TextInputType.number,
            ),
          ),
           ElevatedButton(
          
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => OptController(
                phone: controller.text,
                codeDigit :dialCodeDigit
              )));
            },
            child: const Text('Next'),
          ),
        ],
      ),),
    );
  }
}