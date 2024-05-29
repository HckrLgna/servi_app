import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_app/models/models.dart';
import 'package:http/http.dart' as http;

class VehicleService extends ChangeNotifier {
  final String _baseUrl = "http://192.168.0.5:8080/api/vehicles";
  final List<Vehicle> vehicles = [];
  late Vehicle selectedVehicle;

  XFile? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;

  VehicleService() {
    loadVehicles();
  }
  Future<List<Vehicle>> loadVehicles() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(_baseUrl); // Corregir la creación de la URL
    final resp = await http.get(url);
    final Map<String, dynamic> vehiclesMap = json.decode(resp.body);
    //print(vehiclesMap);

    vehiclesMap.forEach((key, value) {
      print(value);
      final tempVehicle = Vehicle.fromMap(value);
      tempVehicle.id = key;
      vehicles.add(tempVehicle);
    });
    isLoading = false;
    notifyListeners();
    return vehicles;
  }

  Future saveOrCreateVehicle(Vehicle vehicle) async {
    isSaving = true;
    notifyListeners();
    //TODO: check both
    if (vehicle.id == null) {
      await createVehicle(vehicle);
    } else {
      await updateVehicle(vehicle);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> createVehicle(Vehicle vehicle) async {
    final url = Uri.https(_baseUrl);
    final resp = await http.post(url, body: vehicle.toJson());
    final decodedData = json.decode(resp.body);
    vehicle.id = decodedData['name'];
    vehicles.add(vehicle);
    return vehicle.id!;
  }

  Future<String> updateVehicle(Vehicle vehicle) async {
    final url = Uri.https('$_baseUrl/${vehicle.id}');
    final resp = await http.put(url, body: vehicle.toJson());
    final decodedData = json.decode(resp.body);
    final index = vehicles.indexWhere((element) => element.id == vehicle.id);
    vehicles[index] = vehicle;
    return vehicle.id!;
  }

  void updateSelectedVehicleImage(String path) {
    selectedVehicle.pathImage = path;
    newPictureFile = XFile(path);
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;
    isSaving = true;
    notifyListeners();
    //TODO: check
    final url = Uri.parse('$_baseUrl');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    imageUploadRequest.files.add(http.MultipartFile.fromBytes(
        'file', File(newPictureFile!.path).readAsBytesSync(),
        filename: newPictureFile!.path.split('/').last));
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Something went wrong');
      return null;
    }
    final decodedData = json.decode(resp.body);
    isSaving = false;
    notifyListeners();
    return decodedData['secure_url'];
  }
}
