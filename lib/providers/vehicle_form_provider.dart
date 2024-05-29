import 'package:flutter/material.dart';
import 'package:service_app/models/models.dart';

class VehicleFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Vehicle vehicle;
  VehicleFormProvider(this.vehicle);
  bool isValidForm(){
    print(vehicle.brand,);
    print(vehicle.model);
    print(vehicle.plate);
    return formKey.currentState?.validate() ?? false;
  }
}