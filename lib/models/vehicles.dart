import 'dart:convert';

class Vehicle{
  Vehicle({
    this.id,
    this.brand,
    this.model,
    required this.typeCombustible,
    required this.plate,
    this.picture
  });
  String? id;
  String? brand;
  String? model;
  String typeCombustible;
  String plate;
  String? picture;

  factory Vehicle.fromJson(String str) => Vehicle.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());
  
  factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
    brand: json["brand"],
    model: json["model"],
    typeCombustible: json["typeCombustible"],
    plate: json["plate"],
    picture: json["picture"],
  );

  Map<String, dynamic> toMap()=>{
    "brand": brand,
    "model": model,
    "typeCombustible": typeCombustible,
    "plate": plate,
    "picture": picture,
  };

}