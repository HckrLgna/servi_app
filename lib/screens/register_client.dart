import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:service_app/models/models.dart';
import 'package:service_app/providers/providers.dart';
import 'package:service_app/services/services.dart';

class RegisterClient extends StatelessWidget {
  const RegisterClient({super.key});

  @override
  Widget build(BuildContext context) {
    //final vehicleService = Provider.of<VehicleService>(context);
    return //ChangeNotifierProvider(
        //create: ( _ ) => VehicleFormProvider( vehicleService.selectedVehicle ),
        //child:
        _VehicleScreenBody();
  }
}

class _VehicleScreenBody extends StatelessWidget {
  //final VehicleService vehicleService;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 150.0, // Altura del AppBar
                color: Colors.blue,
                child: SafeArea(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          // Acción al presionar el botón de regreso
                        },
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Registro de vehículo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    150.0, // Resto de la pantalla
                color: Colors.blue, // Fondo azul para el resto de la pantalla
              ),
            ],
          ),
          Positioned(
            top: 120.0, // Ajusta esta posición para solapar el AppBar
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height -
                  120.0, // Ajusta la altura
              child: _ClientForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClientForm extends StatelessWidget {
  // const _ClientForm({required this.vehicleService, super.key});
  //final VehicleService vehicleService;
  @override
  Widget build(BuildContext context) {
    //final vehicleForm = Provider.of<VehicleFormProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        //key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Registro Cliente',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombres',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese sus nombres';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su e-mail';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su contraseña';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Registrarse'),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  // Aquí puedes manejar la navegación al login
                },
                child: Text(
                  '¿Ya tienes una cuenta?',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
