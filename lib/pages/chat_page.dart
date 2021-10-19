import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isTextWrite = false;
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 14,
              child: Text(
                'Ro',
                style: TextStyle(fontSize: 11),
              ),
              backgroundColor: Colors.blue.shade100,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Robert Jimenez',
              style: TextStyle(color: Colors.black54, fontSize: 11),
            )
          ],
        ),
      ),
      body: Container(
          child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      )),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      _isTextWrite = true;
                    } else {
                      _isTextWrite = false;
                    }
                  });
                },
                focusNode: _focusNode,
                decoration:
                    InputDecoration.collapsed(hintText: 'Enviar mensaje.'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: IconTheme(
                data: IconThemeData(color: Colors.blue.shade400),
                child: IconButton(
                  onPressed: _isTextWrite
                      ? () => _handleSubmit(_textController.text.trim())
                      : null,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.send,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String texto) {
    if (texto.length > 0) {
      _focusNode.requestFocus();
      _textController.clear();

      final newMessage = ChatMessage(
        texto: texto,
        uid: '123',
        animationController: AnimationController(
          vsync: this,
          duration: Duration(
            milliseconds: 250,
          ),
        ),
      );
      _messages.insert(0, newMessage);
      newMessage.animationController.forward();

      setState(() {
        _isTextWrite = false;
      });
    }
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
