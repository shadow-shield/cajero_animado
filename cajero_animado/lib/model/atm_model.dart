class ATMModel {
  final Map<String, String> credenciales = {
    '11234567890': '1234',
    '01234567890': '4321',
  };

  final List<int> billetes = [10000, 20000, 50000, 100000];
  Map<String, int> intentosClave = {};
  int? codigoTemporal;
  int tiempocodigo = 0;
  final int codigofijo = 654321; 

  bool autenticar(String tarjeta, String clave) {
    if (intentosClave[tarjeta] != null && intentosClave[tarjeta]! >= 3) {
      return false;
    }

    if (credenciales[tarjeta] == clave) {
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
    if (codigoTemporal == null || tiempoActual - tiempocodigo > 120000) {
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
    if (tarjeta == '11234567890') {
      return codigofijo;
    }
    return -1; 
  }
}
