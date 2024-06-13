import 'package:flutter/material.dart';
 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final vehicleService = Provider.of<VehicleService>(context);
    //if ( vehicleService.isLoading ) return const LoadingScreen();
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
                            'Menu principal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed:() {
                          Navigator.pushNamed(context, 'profile');
                        }, 
                        icon: const Icon( Icons.person_outline_sharp)
                        )
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
              child:  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tank Levels',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const TankLevelIndicator(tankName: 'Tank 1', level: 0.75),
                  const SizedBox(height: 10),
                  const TankLevelIndicator(tankName: 'Tank 2', level: 0.50),
                  const SizedBox(height: 10),
                  const TankLevelIndicator(tankName: 'Tank 3', level: 0.30),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Aquí puedes añadir la lógica para solicitar cargar
                      Navigator.pushNamed(context, 'request_fuel');
                      print('Request to load fuel');
                    },
                    child: const Text('Request Load'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'profile');
                    },
                    child: const Text('Go to Profile'),
                  ),
                ],
              ),
            ),
    ))
        ]
      )
    );
  }
}
class TankLevelIndicator extends StatelessWidget {
  final String tankName;
  final double level;

  const TankLevelIndicator({
    Key? key,
    required this.tankName,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$tankName: ${(level * 100).toStringAsFixed(0)}%',
          style: TextStyle(fontSize: 18),
        ),
        LinearProgressIndicator(
          value: level,
          minHeight: 20,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ],
    );
  }
}
