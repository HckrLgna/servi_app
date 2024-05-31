import 'package:flutter/material.dart';
import 'package:service_app/models/models.dart';
import 'package:service_app/models/vehicles.dart';

class VehicleFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Vehicle vehicle;
  VehicleFormProvider( this.vehicle );

  bool isValidForm() {
    print(vehicle.brand);
    return formKey.currentState?.validate() ?? false;
  }
}
