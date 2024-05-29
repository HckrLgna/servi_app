import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/providers/providers.dart';
import 'package:service_app/services/services.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleService = Provider.of<VehicleService>(context);
    return ChangeNotifierProvider(
        create: (_) => VehicleFormProvider(vehicleService.selectedVehicle),
        builder: (context, child) {
          // No longer throws
          return _ProfileScreenBody(vehicleService: vehicleService);
        });
  }
}

class _ProfileScreenBody extends StatelessWidget {
  const _ProfileScreenBody({super.key, required this.vehicleService});
  final VehicleService vehicleService;
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
                          NetworkImage('https://example.com/profile_image.jpg'),
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
                          return ListTile(
                            title: Text(vehicleService.vehicles[index].brand),
                            subtitle: Text(vehicleService.vehicles[index].brand),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Acción al presionar el botón (por ejemplo, editar perfil)
                      },
                      child: Text('Editar Perfil'),
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
