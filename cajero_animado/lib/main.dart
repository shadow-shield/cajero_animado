import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/pantalla_principal.dart';
import 'screens/pantalla_codigo.dart';
import 'screens/pantalla_codigo_temporal.dart';
import 'screens/pantalla_retiro.dart';
import 'screens/pantalla_recibo.dart';

void main() {
  runApp(CajeroApp());
}

class CajeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cajero Automático',
      initialRoute: '/',
      routes: {
        '/': (context) => PantallaPrincipal(),
        '/codigo': (context) => PantallaCodigo(),
        '/codigo-temporal': (context) => PantallaCodigoTemporal(),
        '/retiro': (context) => PantallaRetiro(),
        '/recibo': (context) => PantallaRecibo(),
      },
    );
  }
}
