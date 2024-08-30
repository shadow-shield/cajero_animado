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
  Map<String, int> intentosPorCuenta =
      {}; // Mapa para contar intentos por cuenta
  Map<String, bool> cuentasBloqueadas = {};

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

  bool verificarCodigoTemporal(String cuenta, int codigoTemporal) {
    if (cuentasBloqueadas[cuenta] == true) {
      Get.snackbar('Cuenta Bloqueada', 'La cuenta ya está bloqueada.');
      // Redirigir a la pantalla de inicio
      Get.offAllNamed('/');
      return false;
    }

    if (!intentosPorCuenta.containsKey(cuenta)) {
      intentosPorCuenta[cuenta] = 0; // Inicializar intentos si no existe
    }

    if (intentosPorCuenta[cuenta]! >= 3) {
      cuentasBloqueadas[cuenta] = true;
      Get.snackbar(
          'Cuenta Bloqueada', 'Has superado el número de intentos permitidos.');
      // Redirigir a la pantalla de inicio
      Get.offAllNamed('/');
      return false;
    }

    if (atmModel.codigoTemporal == codigoTemporal) {
      intentosPorCuenta[cuenta] =
          0; // Resetea los intentos si el código es correcto
      return true;
    } else {
      intentosPorCuenta[cuenta] = (intentosPorCuenta[cuenta] ?? 0) + 1;
      Get.snackbar('Error',
          'Código Temporal Incorrecto. Intento ${intentosPorCuenta[cuenta]}/3');
      return false;
    }
  }

  bool verificarCodigoFijo(String cuenta, int codigoFijo) {
    if (cuentasBloqueadas[cuenta] == true) {
      Get.snackbar('Cuenta Bloqueada', 'La cuenta ya está bloqueada.');
      // Redirigir a la pantalla de inicio
      Get.offAllNamed('/');
      return false;
    }

    if (!intentosPorCuenta.containsKey(cuenta)) {
      intentosPorCuenta[cuenta] = 0; // Inicializar intentos si no existe
    }

    if (intentosPorCuenta[cuenta]! >= 3) {
      cuentasBloqueadas[cuenta] = true;
      Get.snackbar(
          'Cuenta Bloqueada', 'Has superado el número de intentos permitidos.');
      // Redirigir a la pantalla de inicio
      Get.offAllNamed('/');
      return false;
    }

    if (atmModel.codigofijo == codigoFijo) {
      intentosPorCuenta[cuenta] =
          0; // Resetea los intentos si el código es correcto
      return true;
    } else {
      intentosPorCuenta[cuenta] = (intentosPorCuenta[cuenta] ?? 0) + 1;
      Get.snackbar('Error',
          'Código Fijo Incorrecto. Intento ${intentosPorCuenta[cuenta]}/3');
      return false;
    }
  }

  void calcularBilletes(int cantidad) {
    cantidadRetiro = cantidad;
    billetesUsados = atmModel.calcularBilletesUsados(cantidad);
    billetesUsados!.sort((a, b) => b.compareTo(a));
  }
}
