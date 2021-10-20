import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final String text;
  final bool isDisabled;
  final Function onPressed;

  const ButtonBlue({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : () => this.onPressed(),
      child: Container(
        height: 58.0,
        width: double.infinity,
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            fontSize: 17.0,
          ),
        )),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 2.0,
        shape: StadiumBorder(),
      ),
    );
  }
}
