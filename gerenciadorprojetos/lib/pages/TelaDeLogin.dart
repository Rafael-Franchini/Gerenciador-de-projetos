
import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  TelaLogin({super.key});
  final  TextEditingController Email = TextEditingController();
  final TextEditingController Senha = TextEditingController();
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
                    TextField(
                      controller: Email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
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
                      controller: Senha,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                          color: Color(0xFF327AEA),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: Login,
                        child: Text(
                          'Login' ,
                          style: TextStyle(
                              color: Color(0xFFFFFAFF),
                              fontSize: 20,
                          ),
                        ),
                    )
                  ],
                ),
          ),
          ),
      );
  }
  void Login(){
    print(Email.text);
    print(Senha.text);
  }
}
