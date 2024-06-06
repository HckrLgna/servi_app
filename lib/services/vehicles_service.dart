import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_app/models/models.dart';
import 'package:http/http.dart' as http;

class VehicleService extends ChangeNotifier {
  final String _baseUrl = "http://10.29.9.165:8080/api/vehicles";
  final String _uploadUrl = "http://10.29.9.165:8080/api/vehicles/upload";
  final List<Vehicle> vehicles = [];
  late Vehicle selectedVehicle;
  late String nameImage;
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
    print("entro saveOrCreateVehicle");
    isSaving = true;
    notifyListeners();
    print("vehicle id: ${vehicle.id}");
    if (vehicle.id == null) {
      await createVehicle(vehicle);
    } else {
      await updateVehicle(vehicle);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> createVehicle(Vehicle vehicle) async {
    print("entro a create");
    final url = Uri.parse(_baseUrl);
    print("modelo vehiculo :${vehicle.model}");
    final body = vehicle.toJson();

    print(body);
    final resp = await http.post(
                                url, 
                                body: body,
                                headers: {'Content-Type': 'application/json'},);
    final decodedData = json.decode(resp.body);
  
    print(decodedData);
    vehicle.licensePlate = decodedData['vehicle']['licensePlate'];
    vehicle.id = decodedData['vehicle']['_id'];
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
    final url = Uri.parse(_uploadUrl);
    print('URL: $url');
    final imageUploadRequest = http.MultipartRequest('POST', url);

    imageUploadRequest.files.add(http.MultipartFile.fromBytes(
        'image', File(newPictureFile!.path).readAsBytesSync(),
        filename: newPictureFile!.path.split('/').last));

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    print(resp.statusCode);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Something went wrong');
      return null;
    }
    final decodedData = json.decode(resp.body);
    isSaving = false;
    notifyListeners();
    print(decodedData);
    nameImage = decodedData['nameImage'];
    return decodedData['pathImage'];
  }
}
