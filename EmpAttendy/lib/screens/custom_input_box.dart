import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyCustomInputBox extends StatefulWidget {
  String label;
  String inputHint;

  MyCustomInputBox({this.label, this.inputHint});
  @override
  _MyCustomInputBoxState createState() => _MyCustomInputBoxState();
}

class _MyCustomInputBoxState extends State<MyCustomInputBox> {
  bool isSubmitted = false;
  final checkBoxIcon = 'assets/checkbox.svg';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 50.0,
              bottom: 8,
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 15,
                color: Color(0xff8f9db5),
              ),
            ),
          ),
        ),
        //
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
          child: TextFormField(
            obscureText: widget.label == 'Password' ? true : false,
            // this can be changed based on usage -
            // such as - onChanged or onFieldSubmitted
            onChanged: (value) {
              setState(() {
                isSubmitted = true;
              });
            },
            style: TextStyle(
                fontSize: 12,
                color: Color(0xff0C2551),
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: widget.inputHint,
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[350],
                  fontWeight: FontWeight.w600),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              focusColor: Colors.blue,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xff0962ff)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.grey[350],
                ),
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}
