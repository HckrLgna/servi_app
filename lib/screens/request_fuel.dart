import 'package:flutter/material.dart';

class RequestFuel extends StatelessWidget {
  const RequestFuel({super.key});

  @override
  Widget build(BuildContext context) {
    return const _VehicleScreenBody();
  }
}

class _VehicleScreenBody extends StatelessWidget {
  const _VehicleScreenBody();
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
                            'Solicitud Carga',
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
              child: _FuelForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FuelForm extends StatelessWidget {
  const _FuelForm({super.key});
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? _tipoCombustible;
    String? _tanque;
    String? _bomba;
    String? _cantidadLts;
    String? _cantidadBs;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Tipo de combustible',
              ),
              items: <String>['Gasolina', 'Diesel', 'Gas Natural']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                _tipoCombustible = newValue;
              },
              validator: (value) =>
                  value == null ? 'Seleccione un tipo de combustible' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Selecciona Tanque',
              ),
              items: <String>['Tanque 1', 'Tanque 2', 'Tanque 3']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                _tanque = newValue;
              },
              validator: (value) =>
                  value == null ? 'Seleccione un tanque' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Selecciona la Bomba',
              ),
              items:
                  <String>['Bomba 1', 'Bomba 2', 'Bomba 3'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                _bomba = newValue;
              },
              validator: (value) =>
                  value == null ? 'Seleccione una bomba' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Cantidad',
                      suffixText: 'Lts',
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _cantidadLts = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese la cantidad en litros';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: '',
                      suffixText: 'Bs.',
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _cantidadBs = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese la cantidad en Bs.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
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
                   
                  Navigator.pushNamed(context, 'request_pay');
                },
                child: const Text(
                  'Soliciar Carga',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
