import 'package:flutter/material.dart';
import 'package:service_app/models/models.dart';

class VehicleFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Vehicle vehicle;
  VehicleFormProvider( this.vehicle );

  bool isValidForm() {
    print(
      vehicle.brand,
    );
    print(vehicle.model);
    print(vehicle.licensePlate);
    return formKey.currentState?.validate() ?? false;
  }
}
