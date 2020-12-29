import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EmpAttendy/screens/custom_input_box.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    bool showProgress = false;
    String email, password;

    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    var safeArea = SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 40),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Cardo',
                          fontSize: 35,
                          color: Color(0xff0C2551),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      //
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 40, top: 5, bottom: 10),
                      child: Text(
                        'For Admin Only',
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  ClipOval(
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(
                            _image,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                  FloatingActionButton(
                    onPressed: getImage,
                    tooltip: 'Pick Image',
                    child: Icon(Icons.add_a_photo),
                  ),
                  //
                  SizedBox(
                    height: 5,
                  ),
                  //
                  MyCustomInputBox(
                    label: 'Name',
                    inputHint: 'Amit Raj Sharma',
                  ),
                  //
                  SizedBox(
                    height: 5,
                  ),
                  //
                  MyCustomInputBox(
                    label: 'Date Of Birth',
                    inputHint: '18/04/1990',
                  ),
                  //
                  SizedBox(
                    height: 5,
                  ),
                  //
                  MyCustomInputBox(
                    label: 'Mobile No',
                    inputHint: '+91 0000000000',
                  ),
                  //
                  SizedBox(
                    height: 5,
                  ),
                  //
                  MyCustomInputBox(
                    label: 'Designation',
                    inputHint: 'Manager',
                  ),
                  //
                  SizedBox(
                    height: 5,
                  ),
                  //
                  MyCustomInputBox(
                    label: 'Employee ID',
                    inputHint: 'Emp-90-C1',
                  ),
                  //
                  MyCustomInputBox(
                    label: 'Email',
                    inputHint: 'example@example.com',
                  ),
                  //
                  SizedBox(
                    height: 5,
                  ),
                  //
                  MyCustomInputBox(
                    label: 'Password',
                    inputHint: '8+ Characters,1 Capital letter',
                  ),
                  //
                  SizedBox(
                    height: 5,
                  ),
                  //
                  Text(
                    "Creating an account means you are agree with\nour Terms of Service and Privacy Policy",
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8f9db5).withOpacity(0.45),
                    ),
                    //
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: scrWidth * 0.85,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8f9db5).withOpacity(0.45),
                          ),
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff90b7ff),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(
                        'Sign up with',
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  //
                  SizedBox(
                    height: 10,
                  ),
                  //
                  Container(
                    child: Column(
                      children: [
                        NeuButton(
                          char: 'G',
                        ),
                        SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ClipPath(
                clipper: OuterClippedPart(),
                child: Container(
                  color: Colors.blue,
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              //
              ClipPath(
                clipper: InnerClippedPart(),
                child: Container(
                  color: Color(0xff0C2551),
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return safeArea;
  }
}

// ignore: camel_case_types
// ignore: must_be_immutable
class NeuButton extends StatelessWidget {
  NeuButton({this.char});
  String char;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(12, 11),
            blurRadius: 26,
            color: Color(0xffaaaaaa).withOpacity(0.1),
          )
        ],
      ),
      //
      child: Center(
        child: Text(
          char,
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);
    //
    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    //
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);

    //
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
