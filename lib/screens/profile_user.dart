import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/models/models.dart';
import 'package:service_app/providers/providers.dart';
import 'package:service_app/screens/loading_screen.dart';
import 'package:service_app/services/services.dart';
import 'package:service_app/widgets/vehicle_card.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleService = Provider.of<VehicleService>(context);
    if (vehicleService.isLoading) return const LoadingScreen();
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
                            'Perfil de usuario',
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/002/002/403/small/man-with-beard-avatar-character-isolated-icon-free-vector.jpg'),
                    ),
                    const SizedBox(height: 16),
                    const Text('Nombre: Juan Pérez',
                        style: TextStyle(fontSize: 18)),
                    const Text('Correo electrónico: juan@example.com',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: vehicleService.vehicles.length,
                        itemBuilder: (context, index) {
                          return VehicleCard(vehicle: vehicleService.vehicles[index]);
                        },
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                            vehicleService.selectedVehicle = Vehicle(
                              brand: "",
                              model: "",
                              typeCombustible: "",  
                            );
                            Navigator.pushNamed(context, 'register');
                        },
                              
                        child: const Text(
                          'Nuevo registro',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  
  }
}
