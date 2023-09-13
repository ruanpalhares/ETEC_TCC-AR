import 'package:automcao_residencial/presentation/pages/help_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final DBref = FirebaseDatabase.instance.ref('htpp//automacao-residencial-227d5-default-rtdb.firebaseio.com');
int ledStatus = 0;

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
                  onPressed: () async {
                    
                    await DBref.child('LED_STATUS').set(1);
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

  void buttonPressed() {
    ledStatus == 0
        ? DBref.child('LED_STATUS').set(1)
        : DBref.child('LED_STATUS').set(0);
    if (ledStatus == 0) {
      setState(() {
        ledStatus = 1;
      });
    } else {
      setState(() {
        ledStatus = 0;
      });
    }
  }
}
