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
                            'Registro',
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
              child: ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(),
                  child:  _ClientForm(),
                )
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
    final clientForm = Provider.of<RegisterFormProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: clientForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
              onChanged: (value) => clientForm.name = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese sus nombres';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'Jhon@correo.com', labelText: 'Correo electronico'),
              onChanged: (value) => clientForm.email = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su e-mail';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: '**************',
                labelText: 'Password',
                //prefixIcon: Icons.lock_outline_rounded
              ),
              onChanged: (value) => clientForm.password = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su contraseña';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromRGBO(7, 67, 83, 0.9),
              onPressed: clientForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final registerService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!clientForm.isValidForm()) return;

                      clientForm.isLoading = true;

                      // TODO: validar si el login es correcto
                      final String? errorMessage = await registerService.createUser( clientForm.name, clientForm.email, clientForm.password);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        // TODO: mostrar error en pantalla
                        print(errorMessage);
                        //NotificationsService.showSnackbar(errorMessage);
                        clientForm.isLoading = false;
                      }

                    },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    clientForm.isLoading ? 'Espere...' : 'Registrar',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
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
