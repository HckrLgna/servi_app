import 'dart:convert';

class Vehicle {
    String? id;
    String brand;
    String model;
    String typeCombustible;
    String? licensePlate;
    String? pathImage;
    String? nameImage;
    bool? status;    
    Vehicle({
        this.id,
        required this.brand,
        required this.model,
        required this.typeCombustible,
        this.pathImage,
        this.licensePlate
    });

    factory Vehicle.fromJson(String str) => Vehicle.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        brand: json['brand'],
        model: json['model'],
        typeCombustible: json['typeCombustible'],
        pathImage: json['pathImage'],
        
    );

    Map<String, dynamic> toMap() => {
        "brand": brand,
        "model": model,
        "typeCombustible": typeCombustible,
        "pathImage": pathImage,
        "nameImage": nameImage,
    };
}