import 'package:get/get.dart';
import '../model/atm_model.dart';

class ATMController extends GetxController {
  final ATMModel atmModel = ATMModel();

  String? numeroTarjeta;
  String? clave;
  int? cantidadRetiro;
  List<int>? billetesUsados;

  get codigoTemporal => null;

  void autenticar(String tarjeta, String clave) {
    numeroTarjeta = tarjeta;
    this.clave = clave;
    update();
  }

  bool verificarAutenticacion() {
    return atmModel.autenticar(numeroTarjeta!, clave!);
  }

  void generarCodigoTemporal() {
    atmModel.generarCodigoTemporal();
    update();
  }
  bool validarCantidad(int cantidad) {
  return cantidad > 0 && cantidad % 10000 == 0;
}


  bool verificarCodigoTemporal(int codigo) {
    return atmModel.verificarCodigoTemporal(codigo);
  }

  void calcularBilletes(int cantidad) {
  cantidadRetiro = cantidad;
  billetesUsados = atmModel.calcularBilletesUsados(cantidad);
  billetesUsados!.sort((a, b) => b.compareTo(a));  // Ordenar de mayor a menor
}


}
