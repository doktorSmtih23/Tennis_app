import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/models/usuarios_response.dart';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get('${Environment.apiUrl}/usuarios', headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;

    } catch (e) {
      return [];
    }

  }

  Future<void> saveUserFcmToken(String fcmToken) async {
    try {
      var body = jsonEncode({'fcmToken': fcmToken});
      await http.post('${Environment.apiUrl}/fcm-token', body: body);
    } catch (err) {
      print("error $err");
    }
  }
}
