import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RequestPay extends StatelessWidget {
  const RequestPay({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PayScreenBody();
  }
}

class _PayScreenBody extends StatelessWidget {
  const _PayScreenBody();
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
                            'Pagos Pendientes',
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
              child: const _PayForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayForm extends StatelessWidget {
  const _PayForm({super.key});
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    int cantidadSolicitada = 0;
    double precioSolicitado = 0.0;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cargas Pendientes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$cantidadSolicitada',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const Text(
                      'Cantidad solicitada',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$precioSolicitado Bs',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const Text(
                      'Precio Solicitado',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        cantidadSolicitada = 0;
                        precioSolicitado = 0.0;
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.white),
                      onPressed: () {
                        cantidadSolicitada++;
                        precioSolicitado +=
                            10; // Supongamos que cada carga cuesta 10 Bs.
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Pago Total',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Center(
            child: QrImageView(
              data: 'Cantidad: $cantidadSolicitada, Total: $precioSolicitado Bs',
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'home');
              },
              child: const Text(
                'Finalizar Y Pagar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
