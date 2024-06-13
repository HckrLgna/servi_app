import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [const _DarkBlueBox(), const _HeaderIcon(), child],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.only(top: 30),
      child: const Center(
        child: Text('Softidor',
            style: TextStyle(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
      ),
    ));
  }
}

class _DarkBlueBox extends StatelessWidget {
  const _DarkBlueBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _darkBlueDecoration(),
    );
  }

  BoxDecoration _darkBlueDecoration() => const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color.fromRGBO(4, 83, 131, 1), Color.fromRGBO(68, 70, 84, 1)],
      ));
}
