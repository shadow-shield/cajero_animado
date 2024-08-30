import 'package:get/get.dart';
import '../model/atm_model.dart';

class ATMController extends GetxController {
  final ATMModel atmModel = ATMModel();

  String? numeroTarjeta;
  String? clave;
  int? cantidadRetiro;
  List<int>? billetesUsados;
  int intentos = 0;
  int? codigoTemporal;
  int? codigoEstatico;

  void autenticar(String tarjeta, String clave) {
    numeroTarjeta = tarjeta;
    this.clave = clave;
    update();

    if (numeroTarjeta == '11234567890') {
      codigoEstatico = atmModel.obtenerCodigoEstatico(numeroTarjeta!);
      update();
    }
  }

  bool verificarAutenticacion() {
    return atmModel.autenticar(numeroTarjeta!, clave!);
  }

  void generarCodigoTemporal() {
    if (numeroTarjeta == '01234567890') {
      atmModel.generarCodigoTemporal();
      codigoTemporal = atmModel.codigoTemporal;
      update();
    }
  }

  bool validarCantidad(int cantidad) {
    return cantidad > 0 && cantidad % 10000 == 0;
  }

  bool verificarCodigoTemporal(int codigoTemporal) {
    if (intentos >= 3) {
      Get.snackbar(
          'Cuenta Bloqueada', 'Has superado el número de intentos permitidos.');

      Get.offAllNamed('/');
      return false;
    }

    if (atmModel.codigoTemporal == codigoTemporal) {
      intentos = 0;
      return true;
    } else {
      intentos++;
      Get.snackbar(
          'Error', 'Código Temporal Incorrecto. Intento ${intentos}/3');
      return false;
    }
  }

  bool verificarCodigoFijo(int codigoFijo) {
    if (intentos >= 3) {
      Get.snackbar(
          'Cuenta Bloqueada', 'Has superado el número de intentos permitidos.');

      Get.offAllNamed('/');
      return false;
    }

    if (atmModel.codigofijo == codigoFijo) {
      intentos = 0;
      return true;
    } else {
      intentos++;
      Get.snackbar(
          'Error', 'Código Fijo Incorrecto. Intento restantes ${intentos}/3');
      return false;
    }
  }

  void calcularBilletes(int cantidad) {
    cantidadRetiro = cantidad;
    billetesUsados = atmModel.calcularBilletesUsados(cantidad);
    billetesUsados!.sort((a, b) => b.compareTo(a));
  }
}
