import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:service_app/providers/providers.dart';
import 'package:service_app/services/services.dart';

class RegisterVehicle extends StatelessWidget {
  const RegisterVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleService = Provider.of<VehicleService>(context);
    return ChangeNotifierProvider(
        create: ( _ ) => VehicleFormProvider(vehicleService.selectedVehicle),
        child: _VehicleScreenBody(
          vehicleService: vehicleService,
        )
      );
  }
}

class _VehicleScreenBody extends StatelessWidget {
  const _VehicleScreenBody({ 
    required this.vehicleService,
   });
  final VehicleService vehicleService;
  @override
  Widget build(BuildContext context) {
    final vehicleForm = Provider.of<VehicleFormProvider>(context);
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
                        icon: Icon(Icons.arrow_back, color: Colors.white),
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
              child: _VehicleForm(vehicleService: vehicleService),
            ),
          ),
        ],
      ),
    );
  }
}

class _VehicleForm extends StatelessWidget {
  const _VehicleForm({required this.vehicleService, super.key});
  final VehicleService vehicleService;
  @override
  Widget build(BuildContext context) {
    final vehicleForm = Provider.of<VehicleFormProvider>(context);
    final vehicle = vehicleForm.vehicle;
    String selectedFuelType = "Gasolina";
    List<String> fuelTypes = ['Gasolina', 'Diésel', 'Eléctrico'];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        //decoration: _buildBoxDecoration(),
        child: Form(
          key: vehicleForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16.0),
              const Text(
                'Registra un sin fin de vehículos',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Marca',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: vehicle.brand,
                onChanged: (value) => vehicle.brand = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo es obligatorio';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Introduce la marca del vehículo',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Modelo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: vehicle.model,
                onChanged: (value) => vehicle.model = value,
                decoration: const InputDecoration(
                  hintText: 'Introduce el modelo del vehículo',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Tipo de combustible',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedFuelType,
                    hint: const Text('Selecciona el tipo de combustible'),
                    items: fuelTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      vehicle.typeCombustible = value!;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Foto de la placa y vehículo.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final XFile? pickedFile = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 100,
                  );
                  if (pickedFile == null) return;
                  vehicleService.updateSelectedVehicleImage(pickedFile.path);
                },
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  color: Colors.grey[300],
                  child: Icon(Icons.camera_alt,
                      color: Colors.grey[600], size: 50.0),
                ),
              ),
              const SizedBox(height: 8.0),
              const Center(
                child: Text(
                  '2450 HKG',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: vehicleService.isSaving
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: vehicleService.isSaving
                            ? null
                            : () async {
                                if (!vehicleForm.isValidForm()) return;
                                final String? imagePath =
                                    await vehicleService.uploadImage();
                                if (imagePath != null) {
                                  vehicleForm.vehicle.pathImage = imagePath;
                                  await vehicleService
                                      .saveOrCreateVehicle(vehicleForm.vehicle);
                                }
                              },
                        child: const Text(
                          'Solicitar registro',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
