import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 65,
            ),
            SizedBox(
              height: 63,
            ),
            TextFormInputField(
              hintText: 'Enter youe email',
              textInputType: TextInputType.emailAddress,
              controller: emailController,
            ),
            SizedBox(
              height: 23,
            ),
            TextFormInputField(
              
              hintText: 'Enter youe password',
              textInputType: TextInputType.visiblePassword,
              controller: passController,
              isPass: true,
            ),
            SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: (){},
              child: Container(
                height: 60,
                child: Text('Login'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 22),
                decoration: ShapeDecoration(
                  color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Don't have an account ?",style: TextStyle(  color: Colors.white,),),
                  padding: EdgeInsets.symmetric(vertical: 9),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => SignUp()));
                  },
                  child: Container(
                    child: Text("Sign Up",style: TextStyle(  color: Colors.white,),),
                    padding: EdgeInsets.symmetric(vertical: 9),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
