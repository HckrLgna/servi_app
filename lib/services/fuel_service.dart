import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class FuelService extends ChangeNotifier {
  final String _baseUrl = "http://192.168.0.6:5000/api/ventacombustibles/add"; //phyton

  final storage = const FlutterSecureStorage();

  // Si retornamos algo, es un error, si no, todo bien!
  Future<String?> registerFuelSale( double price, double quantity) async {
    final Map<String, dynamic> authData = {
      'fecha': DateTime.now().toString(),
      'precio': price,
      'cantidad': quantity,
      'id_cliente': storage.read(key: 'id_usuario'),

    };
    final url = Uri.parse(_baseUrl);
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'}, 
      body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
      return decodedResp['error'] ?? 'Error desconocido';
    
  }

}
