 

import 'package:flutter/material.dart';


class FuelFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey =  GlobalKey<FormState>();

  String data    = '';
  double price = 0.0;
  double quantity    = 0.0;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  
  bool isValidForm() {

    print(formKey.currentState?.validate());

  
    return formKey.currentState?.validate() ?? false;
  }

}