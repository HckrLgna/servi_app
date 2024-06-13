import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = "http://18.117.162.59/auth/login";
  final String _baseUrlRegister = "http://18.117.162.59/auth/signup";

  final storage = const FlutterSecureStorage();

  // Si retornamos algo, es un error, si no, todo bien!
  Future<String?> createUser(String username, String email, String password) async {
    final Map<String, dynamic> authData = {
      'username': username,
      'email': email,
      'password': password,
      'roles': ["CLIENT"],

    };
    final url = Uri.parse(_baseUrlRegister);
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'}, 
      body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    if (decodedResp.containsKey('token')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['token']);
      // decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error'] ?? 'Error desconocido';
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'username': email,
      'password': password,
    };

    final url = Uri.parse(_baseUrl);
    print(url);
    final resp = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('token')) {
      // Token hay que guardarlo en un lugar seguro
      print(decodedResp['token']);
      await storage.write(key: 'token', value: decodedResp['token']);
      //await storage.write(key: 'id_usuario', value: decodedResp['data']['id_usuario']);
      return null;
    } else {
      return decodedResp['error'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
