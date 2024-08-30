import 'package:get/get.dart';
import '../model/atm_model.dart';

class ATMController extends GetxController {
  final ATMModel atmModel = ATMModel();

  String? numeroTarjeta;
  String? clave;
  int? cantidadRetiro;
  List<int>? billetesUsados;

  int? codigoTemporal; // Añadido para almacenar el código temporal
  int? codigoEstatico; // Añadido para almacenar el código estático

  void autenticar(String tarjeta, String clave) {
    numeroTarjeta = tarjeta;
    this.clave = clave;
    update();
    // Establece el código estático si la tarjeta es la esperada
    if (numeroTarjeta == '11234567890') {
      codigoEstatico = atmModel.obtenerCodigoEstatico(numeroTarjeta!);
      update();
    }
  }

  bool verificarAutenticacion() {
    return atmModel.autenticar(numeroTarjeta!, clave!);
  }

  void generarCodigoTemporal() {
    if (numeroTarjeta == '01234567890') { // Genera código solo para esta cuenta
      atmModel.generarCodigoTemporal();
      codigoTemporal = atmModel.codigoTemporal; // Almacena el código en el controlador
      update();
    }
  }

  bool validarCantidad(int cantidad) {
    return cantidad > 0 && cantidad % 10000 == 0;
  }

  bool verificarCodigoTemporal(int codigo) {
    if (numeroTarjeta == '11234567890') {
      
      return true;
    }
    return atmModel.verificarCodigoTemporal(codigo);
  }

  bool verificarCodigoFijo(int codigoFijo) {
    
    return atmModel.codigofijo == codigoFijo;
  }

  void calcularBilletes(int cantidad) {
    cantidadRetiro = cantidad;
    billetesUsados = atmModel.calcularBilletesUsados(cantidad);
    billetesUsados!.sort((a, b) => b.compareTo(a)); 
  }
}
