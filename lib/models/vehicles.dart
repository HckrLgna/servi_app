import 'dart:convert';

class Vehicle {
    String? id;
    String brand;
    String model;
    String typeCombustible;
    String? licensePlate;
    String? pathImage;
    bool? status;

    Vehicle({
        this.id,
        required this.brand,
        required this.model,
        required this.typeCombustible,
        this.licensePlate,
        this.pathImage,
        this.status,
    });

    factory Vehicle.fromJson(String str) => Vehicle.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        brand: json['brand'],
        model: json['model'],
        typeCombustible: json['type_combustible'],
        licensePlate: json['license_plate'],
        pathImage: json['path_image'],
        status: json['status'],
    );

    Map<String, dynamic> toMap() => {
        "brand": brand,
        "model": model,
        "type_combustible": typeCombustible,
        "license_plate": licensePlate,
        "path_image": pathImage,
        "status": status,
    };
}