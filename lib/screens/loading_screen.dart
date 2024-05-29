import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("loading screen");
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
              child:  const CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
