import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/mensajes_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioFrom;

  Future<List<Mensaje>> getChat(String usuarioId) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse('${Enviroment.apiUrl}/mensajes/$usuarioId'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token.toString(),
        },
      );

      final mensajesResponse = mensajesResponseFromJson(resp.body);

      return mensajesResponse.mensajes;
    } catch (e) {
      return [];
    }
  }
}
