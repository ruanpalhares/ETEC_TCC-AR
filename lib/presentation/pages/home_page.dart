import 'package:automcao_residencial/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:firebase_auth/firebase_auth.dart';

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
  final Auth _auth = Auth();
  late stt.SpeechToText _speech;
  bool _loading = true;
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
      });
    });
    
  }

  void signIn() async {
    User? user = await _auth.signInWithEmailAndPassword(
        'ruanpalhares489@gmail.com', '12345678');
    setState(() {
      _loading = false;
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
            setState(
              () {
                _text = result.recognizedWords.toLowerCase();
                if (_text == 'acender') {
                  dbRef.child('LED_STATUS').set(1);

                  _speech.stop();
                  _isListening = false;
                  _text = '';
                } else if (_text == 'apagar') {
                  dbRef.child('LED_STATUS').set(0);

                  _speech.stop();
                  _isListening = false;
                  _text = '';
                }
              },
            );
          },
        );
      }
    } else {
      _speech.stop();

      setState(() {
        _isListening = false;
        _text = '';
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
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            )
          : FutureBuilder(
              future: _fireApp,
              builder: (context, snapshot) {
                return Column(
                  children: [
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
                          IconButton(
                            icon: const Icon(Icons.mic_external_on_sharp),
                            onPressed: _listen,
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder()),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: ElevatedButton(
                          onPressed: () => buttonPressed(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: const CircleBorder()),
                          child: Image.asset('image/light.png'),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: SizedBox(
                            height: 75,
                            width: 75,
                            child: CircleAvatar(
                              backgroundColor: Colors.black12,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.question_mark,
                                  color: Colors.black,
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/help'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('error');
    }
    return null;
  }
}
