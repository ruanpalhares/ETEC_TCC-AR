import 'package:automcao_residencial/presentation/pages/help_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

bool goodtogo = true;
final DBref = FirebaseDatabase.instance.ref();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            const Row(),
            Expanded(
              child: Padding(
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
                  padding: const EdgeInsets.only(bottom: 60, left: 35),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HelpPage(),
                            ));
                      },
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
