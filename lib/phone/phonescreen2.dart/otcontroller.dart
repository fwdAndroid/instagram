import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/phone/phonescreen2.dart/homess.dart';
import 'package:instagram/screens/home_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Ot extends StatefulWidget {
  final String phone;
  final String codeDigits;
  Ot({required this.phone, required this.codeDigits});

  @override
  State<Ot> createState() => _OtState();
}

class _OtState extends State<Ot> {
  final GlobalKey<ScaffoldState> _scalfoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController controllerpin = TextEditingController();
  final FocusNode pinOTPFocusNode = FocusNode();

  String? verificationCode;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificationPhone();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              child: InkWell(
                child:
                    Text("verification: ${widget.codeDigits}-${widget.phone}"),
              ),
            ),
            Container(
              child: PinPut(
                fieldsCount: 6,
                textStyle: TextStyle(fontSize: 20, color: Colors.black),
                eachFieldHeight: 40,
                eachFieldWidth: 40,
                focusNode: pinOTPFocusNode,
                controller: controllerpin,
                selectedFieldDecoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.circular(20),
                ),
                submittedFieldDecoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 20, 68, 107)),
                  borderRadius: BorderRadius.circular(20),
                ),
                onSubmit: (pin) async{
                 try{
                   await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationCode!, smsCode: pin)).then((value) {
                     if(value.user != null){
                       Navigator.of(context).push(MaterialPageRoute(builder: (builder) => Homess()));
                     }
                   });
                 }catch(e){
                   FocusScope.of(context).unfocus();
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text("Invalide Code"),duration: Duration(seconds: 12),)
                   );
                 }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void verificationPhone() async{
   await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: "${widget.codeDigits + widget.phone}", verificationCompleted: (PhoneAuthCredential credential)async{
     await FirebaseAuth.instance.signInWithCredential(credential).then((value)  {
        if(value.user != null){
                       Navigator.of(context).push(MaterialPageRoute(builder: (builder) => Homess()));
                     }
     });
   }, verificationFailed: (FirebaseException e){
      FocusScope.of(context).unfocus();
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(e.message.toString()),duration: Duration(seconds: 12),)
                   );
   }, codeSent: (String VID, int? resentToken){
     setState(() {
       verificationCode = VID;
     });
   }, codeAutoRetrievalTimeout: (String VID){
       setState(() {
         verificationCode = VID;
       }); 
       
   },
   timeout: Duration(seconds: 50)
   );
   
  }
}
