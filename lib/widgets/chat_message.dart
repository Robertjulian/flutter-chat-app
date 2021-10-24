import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage(
      {Key? key,
      required this.texto,
      required this.uid,
      required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        child: Container(
          child:
              uid == authService.usuario.uid ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 7,
          right: 5,
          left: 50,
        ),
        padding: EdgeInsets.all(10),
        child: Text(
          texto,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff4d9Ef6),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 7,
          right: 50,
          left: 5,
        ),
        padding: EdgeInsets.all(10),
        child: Text(
          texto,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffE4E5E8),
        ),
      ),
    );
  }
}
