class Credencial {
  final String tarjeta;
  final String clave;

  Credencial(this.tarjeta, this.clave);
}

class ATMModel {
  final List<Credencial> credenciales = [
    Credencial('13024214105', '0114'),
    Credencial('3024214105', '0113'),
    Credencial('301578', '0115')
  ];

  String obtenerNumeroTarjetaPorClave(String clave) {
    for (var credencial in credenciales) {
      if (credencial.clave == clave) {
        return credencial.tarjeta;
      }
    }
    return 'Clave no encontrada';
  }
  
  final List<int> billetes = [10000, 20000, 50000, 100000];
  Map<String, int> intentosClave = {};
  int? codigoTemporal;
  int tiempocodigo = 0;
  final int codigofijo = 654321;

  bool autenticar(String tarjeta, String clave) {
    if (intentosClave[tarjeta] != null && intentosClave[tarjeta]! >= 3) {
      return false;
    }

    final credencial = credenciales.firstWhere(
      (credencial) => credencial.tarjeta == tarjeta,
      orElse: () => Credencial('', ''),
    );

    if (credencial.clave == clave) {
      intentosClave[tarjeta] = 0;
      return true;
    } else {
      if (intentosClave[tarjeta] == null) {
        intentosClave[tarjeta] = 1;
      } else {
        intentosClave[tarjeta] = intentosClave[tarjeta]! + 1;
      }
      return false;
    }
  }

  void generarCodigoTemporal() {
    codigoTemporal = 100000 + (DateTime.now().millisecondsSinceEpoch % 900000);
    tiempocodigo = DateTime.now().millisecondsSinceEpoch;
  }

  bool verificarCodigoTemporal(int codigoIngresado) {
    final int tiempoActual = DateTime.now().millisecondsSinceEpoch;
    if (codigoTemporal == null || tiempoActual - tiempocodigo > 40000) { 
      return false;
    }
    return codigoIngresado == codigoTemporal;
  }

  List<int> calcularBilletesUsados(int cantidad) {
    List<int> billetesUsados = [];
    int cantidadActual = 0;
    int n = 0;

    while (cantidadActual < cantidad) {
      for (int i = n; i < billetes.length; i++) {
        if ((cantidadActual + billetes[i]) <= cantidad) {
          cantidadActual += billetes[i];
          billetesUsados.add(billetes[i]);
        }
      }
      n += 1;
      if (n == billetes.length) {
        n = 0;
      }
    }
    return billetesUsados;
  }

  int obtenerCodigoEstatico(String tarjeta) {
    if (tarjeta == obtenerNumeroTarjetaPorClave('0114')) {
      return codigofijo;
    }
    return -1;
  }
}
