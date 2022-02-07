import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_merhods.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/text_form_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  Uint8List ? _image;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passController.clear();
    bioController.clear();
    userNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
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
              Stack(
                children: [
               _image != null ? CircleAvatar(
                    radius: 59,
                    backgroundImage:MemoryImage(_image!)
                  ):   CircleAvatar(
                    radius: 59,
                    backgroundImage: NetworkImage(
                        'https://static.remove.bg/remove-bg-web/a6eefcd21dff1bbc2448264c32f7b48d7380cb17/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png'),
                  ),
                  Positioned(
                      bottom: -10,
                      left: 70,
                      child: IconButton(
                          onPressed: () => selectImage(),
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          )))
                ],
              ),
              SizedBox(
                height: 23,
              ),
              TextFormInputField(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                controller: userNameController,
              ),
              SizedBox(
                height: 23,
              ),
              TextFormInputField(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                controller: emailController,
              ),
              SizedBox(
                height: 23,
              ),
              TextFormInputField(
                hintText: 'Enter your password',
                textInputType: TextInputType.visiblePassword,
                controller: passController,
                isPass: true,
              ),
              SizedBox(
                height: 23,
              ),
              TextFormInputField(
                hintText: 'Enter your Bio',
                textInputType: TextInputType.text,
                controller: bioController,
              ),
              SizedBox(
                height: 23,
              ),
              InkWell(
                onTap: () async {
                  String rse = await AuthMethods().signUpUser(
                      email: emailController.text,
                      pass: passController.text,
                      bio: bioController.text,
                      username: userNameController.text);
                      print(rse);
                },
                
                child: Container(
                  height: 60,
                  child: Text('Register'),
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
                    child: Text(
                      "Already an account ?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 9),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => LoginScreen()));
                    },
                    child: Container(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 9),
                    ),
                  )
                ],
              )
            ],
        ),
      ),
          )),
    );
  }
  
  /// Select Image From Gallery
  selectImage() async{
    Uint8List ui = await pickImage(ImageSource.gallery);
   setState(() {
     _image = ui;
   });
  }
}
