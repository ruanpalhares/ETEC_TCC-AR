import 'package:flutter/material.dart';

bool goodtogo = true;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iluminação Residencial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(),
            Expanded(
              child: 
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: ElevatedButton(
                  onPressed: () {
                    if (!goodtogo) {
                      return;
                    }
                    if (goodtogo) {
                      var message = '';
                      bool conexao = false;
                      if (conexao == true) {
                        message = 'Conexão estabelecida!';
                      } else {
                        message = 'Conexão não encontrada!';
                      }
                      goodtogo = false;
              
                      var snackbar = SnackBar(content: Text(message));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
              
                      Future.delayed(const Duration(milliseconds: 5000), () {
                        goodtogo = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(400, 400),
                      shape: const CircleBorder()),
                  child: Image.asset('image/light.png'),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60, left: 20),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black12,
                            fixedSize: const Size(100, 100),
                            shape: const CircleBorder()),
                        child: Image.asset('image/interr.png'),
                        ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
