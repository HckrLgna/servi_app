import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/services/services.dart';
import 'package:service_app/screens/screens.dart';
void main() => runApp(const MyApp());

class AppState extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: ( _ ) => VehicleService()),
      ],
      child: const MyApp()
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service App',
      initialRoute: 'home',
      routes:{
        'home': ( _ ) => const RegisterVehicle(),
      },
    );
  }
}