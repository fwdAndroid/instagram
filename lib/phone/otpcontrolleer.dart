import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/phone/homescreen.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OptController extends StatefulWidget {
  final String phone;
  final String codeDigit;

  OptController({required this.phone, required this.codeDigit});

  @override
  _OptControllerState createState() => _OptControllerState();
}

class _OptControllerState extends State<OptController> {
  final GlobalKey<ScaffoldState> _scalfoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOtpController = TextEditingController();
  final FocusNode _otpFocusnOde = FocusNode();
  String? verificationCode;

  final BoxDecoration pinDecp = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.green));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone();
  }    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scalfoldkey,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(
            'OTP Verification',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        Container(
          child: Center(
            child: GestureDetector(
              onTap: (){
                verifyPhone();
              },
              child: Text("Verification: ${widget.codeDigit}-${widget.phone}"),
            ),
          ),
        ),
        Container(
          child: PinPut(
            fieldsCount: 0,
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.lightBlue,
            ),
            eachFieldWidth: 40,
            eachFieldHeight: 50,
            focusNode: _otpFocusnOde,
            controller: _pinOtpController,
            submittedFieldDecoration: pinDecp,
            selectedFieldDecoration: pinDecp,
            followingFieldDecoration: pinDecp,
            pinAnimationType: PinAnimationType.fade,
            onSubmit: (pin) async {
              try {
                await FirebaseAuth.instance
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: verificationCode!, smsCode: pin))
                    .then((value)  {
                        if(value.user != null){
                          Navigator.push(context, MaterialPageRoute(builder: (builder) => HomeScreens()));
                        }
                    });
              } catch (Ex) {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalide'),duration: Duration(seconds: 4),));
              }
            },
          ),
        ),
      ]),
    );
  }

  void verifyPhone() async{
   await FirebaseAuth.instance.verifyPhoneNumber(
     phoneNumber: "${widget.codeDigit + widget.phone}",
    verificationCompleted: (PhoneAuthCredential authCredential) async{
      await FirebaseAuth.instance.signInWithCredential(authCredential).then((value) {
          if(value.user != null){
                          Navigator.push(context, MaterialPageRoute(builder: (builder) => HomeScreens()));
                        }
      });
    }, 
    verificationFailed: (FirebaseException e){
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),duration: Duration(seconds: 4),));

    }, 
    codeSent: (String verificationId, int? resendToken) async{
      setState(() {
        verificationCode = verificationId;
      });
    },
     codeAutoRetrievalTimeout: (String verificationId){
        setState(() {
          verificationCode = verificationId;
        });
     },
     timeout: Duration(seconds: 50)) ;      
  }
}
