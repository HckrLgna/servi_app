import 'dart:io';

import 'package:flutter/material.dart';

class VehicleImage extends StatelessWidget {
  const VehicleImage({super.key, this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( left: 10, right: 10, top: 10 ),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: 45,
        height: 45,
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
                borderRadius: const BorderRadius.all(  Radius.circular( 10 )),
            child: getImage(url)
          ),
        ),
      ),
    );
  }
  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.black,
    borderRadius: const BorderRadius.all(  Radius.circular( 10 )),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0,5)
      )
    ]
  );
   Widget getImage( String? picture ) {

    if ( picture == null ) {
      return const Image(
          image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover,
        );
    }

    if ( picture.startsWith('http') ) {
      return FadeInImage(
          image: NetworkImage( url! ),
          placeholder: const AssetImage('assets/jar-loading.gif'),
          fit: BoxFit.cover,
        );
    }


    return Image.file(
      File( picture ),
      fit: BoxFit.cover,
    );
  }
}