
import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  TelaLogin({super.key});
  final  TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFF),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                    Image.asset(
                      'assets/images/logobranca.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color(0xFF327AEA),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: senha,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                          color: Color(0xFF327AEA),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF327AEA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: Login,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:60.0),
                          child: Text(
                            'Login' ,
                            style: TextStyle(
                                color: Color(0xFFFFFAFF),
                                fontSize: 20,
                            ),
                          ),
                        ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: registrar,
                        child: Text("Registrar-se"),
                    )
                  ],
                ),
          ),
          ),
      );
  }
  void Login(){
    String senha= senha.text;
    String email= email.text;
  }
  void registrar(){
    print("Registrar");
  }
}
