import 'package:cajero_animado/screens/pantall_retiro_temporal.dart';

import 'package:cajero_animado/screens/pantalla_recibo_temporal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../controllers/atm_controller.dart';

class PantallaCodigoTemporal extends StatefulWidget {
  @override
  _PantallaCodigoTemporalState createState() => _PantallaCodigoTemporalState();
}

class _PantallaCodigoTemporalState extends State<PantallaCodigoTemporal> {
  final ATMController controller = Get.find();
  final TextEditingController codigoController = TextEditingController();
  late Timer _timer;
  int _timeRemaining = 40;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer.cancel();
        _handleTimerExpiration();
      }
    });
  }

  void _handleTimerExpiration() {

    controller.generarCodigoTemporal();

   
    Get.snackbar(
      'Tiempo Expirado',
      'El tiempo del código ha expirado. Se ha generado un nuevo código.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.blue,
    );


    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PantallaRetiroTemporal(), 
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
          Positioned.fill(
            child: Container(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 400
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Código : ${controller.codigoTemporal}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Código Válido por : $_timeRemaining segundos ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 500,),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: codigoController,
                    decoration: InputDecoration(
                      labelText: 'Ingrese Código ',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      filled: true,
                      suffixIcon: Icon(Icons.numbers),
                      suffixIconColor: Colors.blue,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    String cuenta = controller.atmModel.obtenerNumeroTarjetaPorClave('0113');
                    if (controller.verificarCodigoTemporal(
                        cuenta, int.tryParse(codigoController.text) ?? 0)) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              PantallaReciboTemporal(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0); 
                            const end = Offset(0.0, 0.0);
                            const curve = Curves.easeInOut;

                            var tween =
                                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
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
                            fontWeight: FontWeight.bold,
                          ),
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
