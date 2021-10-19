import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: 180.0,
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/tag-logo.png'),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
