import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    final fcmToken = await firebaseMessaging.getToken();

    this.autenticando = true;

    final data = {'email': email, 'password': password, 'fcmToken': fcmToken};

    final resp = await http.post('${Environment.apiUrl}/login/',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);
      await this._guardarFcmToken(fcmToken);
      print(resp.body);

      return true;
    } else {
      return false;
    }
  }

  Future<String> getfcmToken() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

    await firebaseMessaging.requestNotificationPermissions();

    final fcmtoken = await firebaseMessaging.getToken();

     try {
      var body = jsonEncode({'fcmToken': fcmtoken});
      await http.post('${Environment.apiUrl}/fcm-token', body: body);
    } catch (err) {
      print("error $err");
    }
    print('===================fcmToken=========================');
    print(fcmtoken);
    return fcmtoken;
  }

  Future _guardarFcmToken(String fcmToken) async {
    return await _storage.write(key: 'fcmToken', value: fcmToken);
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;
    final fcmtoken = await firebaseMessaging.getToken();

    final data = {'nombre': nombre, 'email': email, 'password': password,
    'fcmToken':fcmtoken};

    final resp = await http.post('${Environment.apiUrl}/login/new',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    print(data);

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      await this._guardarFcmToken(fcmtoken);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final fcmToken = await this._storage.read(key: 'fcmToken');

    final resp = await http.get('${Environment.apiUrl}/login/renew',
        headers: {'Content-Type': 'application/json', 'x-token': token});
    
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      await this._guardarFcmToken(fcmToken);
      try {
      var body = jsonEncode({'fcmToken': fcmToken});
      await http.post('${Environment.apiUrl}/fcm-token', body: body);
      print(resp.body);

    } catch (err) {
      print("error $err");
    }
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'fcmToken');
  }
}
