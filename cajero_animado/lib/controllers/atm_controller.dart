import 'package:cajero_animado/model/atm_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ATMController extends GetxController {
  final ATMModel atmModel = ATMModel();

  String? numeroTarjeta;
  String? clave;
  int? cantidadRetiro;
  List<int>? billetesUsados;
  int intentos = 0;
  int? codigoTemporal;
  int? codigoEstatico;
  Map<String, int> intentosPorCuenta = {}; 
  Map<String, bool> cuentasBloqueadas = {};

  TextEditingController tarjetaController = TextEditingController();

  void autenticar(String tarjeta, String clave) {
    numeroTarjeta = ajustarNumeroTarjeta(tarjeta);
    this.clave = clave;
    update();

    if (numeroTarjeta == atmModel.obtenerNumeroTarjetaPorClave('0114')) {
      codigoEstatico = atmModel.obtenerCodigoEstatico(numeroTarjeta!);
      update();
    } else {
      numeroTarjeta = atmModel.obtenerNumeroTarjetaPorClave('0113');
      generarCodigoTemporal();
      update();
    }
  }

  String ajustarNumeroTarjeta(String tarjeta) {
    if (tarjeta.length < 11) {
      return tarjeta.padLeft(11, '0');
    }
    return tarjeta;
  }

  bool verificarAutenticacion() {
    return atmModel.autenticar(numeroTarjeta!, clave!);
  }

  void generarCodigoTemporal() {
    if (numeroTarjeta == atmModel.obtenerNumeroTarjetaPorClave('0113')) {
      atmModel.generarCodigoTemporal();
      codigoTemporal = atmModel.codigoTemporal;
      update();
    }
  }

  bool validarCantidad(int cantidad) {
    return cantidad > 0 && cantidad % 10000 == 0;
  }

  bool verificarCodigoTemporal(String cuenta, int codigoTemporal) {
  if (verificarCuentaBloqueada(cuenta)) {
    return false; 
  }

  if (!intentosPorCuenta.containsKey(cuenta)) {
    intentosPorCuenta[cuenta] = 0;
  }

  if (intentosPorCuenta[cuenta]! >= 3) {
    cuentasBloqueadas[cuenta] = true;
    Get.snackbar('Cuenta Bloqueada', 'Has superado el número de intentos permitidos.', backgroundColor: Colors.white, colorText: Colors.blue);
    Get.offAllNamed('/');
    return false;
  }

  if (atmModel.verificarCodigoTemporal(codigoTemporal)) {
    intentosPorCuenta[cuenta] = 0;
    return true;
  } else {
    intentosPorCuenta[cuenta] = (intentosPorCuenta[cuenta] ?? 0) + 1;
    Get.snackbar('Error', 'Código Temporal Incorrecto. Intento ${intentosPorCuenta[cuenta]}/3', backgroundColor: Colors.white, colorText: Colors.blue);
    return false;
  }
}


  bool verificarCodigoFijo(String cuenta, int codigoFijo) {
    if (cuentasBloqueadas[cuenta] == true) {
      Get.snackbar('Cuenta Bloqueada', 'La cuenta se encuentra en estado bloqueada.', backgroundColor: Colors.white, colorText: Colors.blue);
      Get.offAllNamed('/');
      return false;
    }

    if (!intentosPorCuenta.containsKey(cuenta)) {
      intentosPorCuenta[cuenta] = 0; 
    }

    if (intentosPorCuenta[cuenta]! >= 3) {
      cuentasBloqueadas[cuenta] = true;
      Get.snackbar('Cuenta Bloqueada', 'Has superado el número de intentos permitidos.', backgroundColor: Colors.white, colorText: Colors.blue);
      Get.offAllNamed('/');
      return false;
    }

    if (atmModel.codigofijo == codigoFijo) {
      intentosPorCuenta[cuenta] = 0; 
      return true;
    } else {
      intentosPorCuenta[cuenta] = (intentosPorCuenta[cuenta] ?? 0) + 1;
      Get.snackbar('Error', 'Código Incorrecto. Intento ${intentosPorCuenta[cuenta]}/3', backgroundColor: Colors.white, colorText: Colors.blue);
      return false;
    }
  }

  void calcularBilletes(int cantidad) {
    cantidadRetiro = cantidad;
    billetesUsados = atmModel.calcularBilletesUsados(cantidad);
    billetesUsados!.sort((a, b) => b.compareTo(a));
  }

  bool verificarCuentaBloqueada(String cuenta) {
  if (cuentasBloqueadas[cuenta] == true) {
    Get.snackbar('Cuenta Bloqueada', 'La cuenta se encuentra en estado bloqueada.', backgroundColor: Colors.white, colorText: Colors.blue);
    Get.offAllNamed('/'); 
    return true;
  }
  return false;
}

}
