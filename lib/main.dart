import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_app/screens/register_client.dart';
import 'package:service_app/services/services.dart';
import 'package:service_app/screens/screens.dart';
void main() => runApp( const AppState());

class AppState extends StatelessWidget{
  const AppState({super.key});
  @override 
  Widget build(BuildContext context){
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => VehicleService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp()
    );
  }
}


class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service App',
      navigatorKey: navigatorKey,
      initialRoute: 'login',
      routes:{
        'login': ( _ ) => const LoginScreen(),
        'home': ( _ ) => const HomeScreen(),
        'register_vehicle': ( _ ) => const RegisterVehicle(), // Se agrega la ruta 'register
        'register_client': ( _ ) => const RegisterClient(), // Se agrega la ruta 'register
        'profile': ( _ ) => const ProfileUser(),
        'request_fuel': ( _ ) => const RequestFuel(),
        'request_pay': ( _ ) => const RequestPay(),
      },
    );
  }
}