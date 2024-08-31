import 'package:cajero_animado/screens/pantall_retiro_temporal.dart';
import 'package:cajero_animado/screens/pantalla_codigo_fijo.dart';
import 'package:cajero_animado/screens/pantalla_recibo_fijo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/pantalla_principal.dart';
import 'screens/pantalla_codigo.dart';
import 'screens/pantalla_codigo_temporal.dart';
import 'screens/pantalla_Retiro_Fijo.dart';
import 'screens/pantalla_recibo_temporal.dart';

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
        '/codigo-fijo': (context) => PantallaCodigoFijo(),
        '/retiro-temporal': (context) => PantallaRetiroTemporal(),

        '/retiro': (context) => PantallaRetiro(),
        '/recibo': (context) => PantallaReciboTemporal(),
        '/recibofijo': (context) => PantallaReciboFijo()
      },
    );
  }
}
