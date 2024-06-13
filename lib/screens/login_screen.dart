import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/providers/providers.dart';
import 'package:service_app/widgets/widgets.dart';

import '../services/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Bienvenido",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 102, 129, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Ingresa tus datos",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child:  _LoginForm(),
                )
              ],
            )),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                print("se presiono olvide contraseña");
              },
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      const Color.fromRGBO(7, 67, 83, 0.9)),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'register_client');
                },
                child: const Text('Necesitas una cuenta? ',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
          //TODO: mantener el key
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Jhon@correo.com',
                    labelText: 'Correo electronico'),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Ingrese un correo valido ';
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: '**************',
                  labelText: 'Password',
                  //prefixIcon: Icons.lock_outline_rounded
                ),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  if (value != null && value.length >= 3) return null;
                  return 'la contraseña debe ser mayor a 6 caracteres';
                },
              ),
              const SizedBox(height: 30),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: const Color.fromRGBO(7, 67, 83, 0.9),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        // TODO: validar si el login es correcto
                        final String? errorMessage = await authService.login(
                            loginForm.email, loginForm.password);

                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          // TODO: mostrar error en pantalla
                           print( errorMessage );
                          //NotificationsService.showSnackbar(errorMessage);
                          loginForm.isLoading = false;
                        }
                      },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Espere...' : 'Ingresar',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          )),
    );
  }
}
