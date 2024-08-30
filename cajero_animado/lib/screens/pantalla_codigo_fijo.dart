import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/atm_controller.dart';

class PantallaCodigoFijo extends StatelessWidget {
  final ATMController controller = Get.find();
  final TextEditingController codigoController = TextEditingController();

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
          Container(
            margin: EdgeInsets.only(
              top: 100,
              left: 130,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white24,
            ),
            child: Image.asset(
              'assets/bancoagil.png',
              width: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 40),
                  child: AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(seconds: 2),
                    child: Text(
                      'Código Generado: ${controller.atmModel.codigofijo}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: codigoController,
                    decoration: InputDecoration(
                        labelText: 'Ingrese Código Fijo',
                        labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                        filled: true,
                        suffixIcon: Icon(Icons.numbers),
                        suffixIconColor: Colors.blue,
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.white),
                        )),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    if (controller.verificarCodigoFijo(
                        int.tryParse(codigoController.text) ?? 0)) {
                      Get.toNamed('/retiro');
                    } else if (controller.intentos >= 3) {
                      Get.offAllNamed('/');
                    }
                  },
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          'Verificar',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 7),
                        Icon(
                          Icons.arrow_forward,
                          size: 24,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
