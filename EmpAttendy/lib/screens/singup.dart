import 'package:flutter/material.dart';

class singup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 40),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Cardo',
                        fontSize: 35,
                        color: Color(0xff0c2551),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
