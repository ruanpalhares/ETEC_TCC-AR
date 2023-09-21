import 'package:automcao_residencial/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

int ledStatus = 0;
var buttonColor = Colors.grey;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<FirebaseApp> _fireApp = currentFirebaseApp();
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref('LED_STATUS');
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    super.initState();

    dbRef.child('LED_STATUS').onValue.listen((event) {
      var snapshot = event.snapshot;

      setState(() {
        buttonColor = snapshot.value == 1 ? Colors.orange : Colors.grey;
        ledStatus = snapshot.value! as int;
        _text = '';
      });
    });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == stt.SpeechToText.listeningStatus) {
            setState(() {
              _isListening = true;
            });
          }
        },
        onError: (error) {
          print('Erro: $error');
        },
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords.toLowerCase();
              if (_text == 'acender')
                dbRef.child('LED_STATUS').set(1);
              else if (_text == 'apagar') dbRef.child('LED_STATUS').set(0);
            });
          },
        );
      }
    } else {
      _speech.stop();

      setState(() {
        _isListening = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _speech.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iluminação Residencial'),
      ),
      body: FutureBuilder(
        future: _fireApp,
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          _isListening
                              ? 'Ouvindo: $_text'
                              : 'Pressione para Iniciar',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        ElevatedButton(
                          onPressed: _listen,
                          child: Text(_isListening
                              ? 'Parar'
                              : 'Iniciar Reconhecimento'),
                        ),
                      ],
                    ),
                  ),
                ]),
                const Row(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: ElevatedButton(
                      onPressed: () => buttonPressed(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
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
                          onPressed: () =>
                              Navigator.pushNamed(context, '/help'),
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
          );
        },
      ),
    );
  }

  void buttonPressed() async {
    ledStatus == 0
        ? dbRef.child('LED_STATUS').set(1)
        : dbRef.child('LED_STATUS').set(0);
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
