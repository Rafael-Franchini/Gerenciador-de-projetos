import 'package:flutter/material.dart';

MostrarSnackbar(
    {required BuildContext context,
    required String texto,
    bool isErro = true}) {
  SnackBar snackBar = SnackBar(
    padding: EdgeInsets.all(20),
    content: Text(
      texto,
    ),
    backgroundColor: (isErro) ? Colors.red : Colors.green,
    duration: const Duration(seconds: 4),
    action: SnackBarAction(
      label: "Ok",
      textColor: Colors.white,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
