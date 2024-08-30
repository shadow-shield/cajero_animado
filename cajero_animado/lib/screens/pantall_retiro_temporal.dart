import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/atm_controller.dart';

class PantallaRetiroTemporal extends StatelessWidget {
  final ATMController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondoapp.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: deprecated_member_use
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  // ignore: deprecated_member_use
                  child: WavyAnimatedTextKit(
                    text: ['Eliga valor a retirar'],
                    textStyle: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: Duration(milliseconds: 300),
                    isRepeatingAnimation: true,
                    textAlign: TextAlign.start,
                    repeatForever: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _botonCantidad(
                        context, 20000, Colors.blueAccent.withOpacity(1)),
                    _botonCantidad(
                        context, 50000, Colors.blueAccent.withOpacity(1)),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _botonCantidad(
                        context, 100000, Colors.blueAccent.withOpacity(1)),
                    _botonCantidad(
                        context, 400000, Colors.blueAccent.withOpacity(1)),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _botonCantidad(
                        context, 600000, Colors.blueAccent.withOpacity(1)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green.withOpacity(1.0),
                      ),
                      onPressed: () {
                        _mostrarDialogoOtroValor(context);
                      },
                      child: Text('Otro Valor'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _botonCantidad(BuildContext context, int cantidad, Color? color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
      ),
      onPressed: () {
        controller.calcularBilletes(cantidad);
        Get.toNamed('/codigo-temporal');
      },
      child: Text('\$ ${cantidad ~/ 1000}.000'),
    );
  }

  void _mostrarDialogoOtroValor(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 16,
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: 220,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ingrese cantidad',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(color: Colors.blue),
                    hintText: 'Ingrese valor deseado',
                  ),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        int cantidad = int.tryParse(_controller.text) ?? 0;
                        if (controller.validarCantidad(cantidad)) {
                          controller.calcularBilletes(cantidad);
                          Navigator.of(context).pop();
                          Get.toNamed('/recibo');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Ingrese un múltiplo de 10,000'),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        'Aceptar',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
