import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/UI/widgets/custum_button.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

class QA extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

bool isStartPressed = false;

class _MyAppState extends State<QA> {
  TextEditingController _questionController = TextEditingController();
  String _answer = '';
  TextToSpeech _tts = TextToSpeech();
  stt.SpeechToText _stt = stt.SpeechToText();
  bool _isListening = false;
  String _transcription = '';
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // await _tts.init();
    });
  }

  Future<void> _fetchAnswer(String question) async {
    if (question.isEmpty) return;

    final queryParameters = {'question': question};
    final url = Uri.http('192.168.1.9:3000', '/api/query', queryParameters);

    try {
      final response = await http.get(url);
      final decodedResponse = json.decode(response.body);

      if (decodedResponse.containsKey('answer')) {
        _answer = decodedResponse['answer'];
        _speakAnswer(_answer);
      } else if (decodedResponse.containsKey('error')) {
        _answer = 'Error: ${decodedResponse['error']}';
      } else {
        _answer = 'No results found';
      }
    } catch (e) {
      _answer = 'An error occurred';
    }
    setState(() {});
  }

  void _speakAnswer(String answer) {
    Future.delayed(Duration(seconds: 5)).then((value) => _tts.setVolume(1.0));
    _tts.setRate(1.0);
    _tts.setPitch(1.0);
    _tts.speak(answer);
    setState(() {
      _isPlaying = true;
    });
  }

  void _stopSpeaking() {
    _tts.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _startListening() async {
    isStartPressed = true;
    if (!_isListening) {
      bool available = await _stt.initialize(
        onStatus: (status) {},
        onError: (error) {},
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _stt.listen(
          onResult: (result) {
            setState(() {
              _transcription = result.recognizedWords;
              _questionController.text = _transcription;
            });
          },
        );
      }
    }
  }

  void _stopListening() {
    isStartPressed = false;
    if (_isListening) {
      _stt.stop();
      setState(() {
        _isListening = false;
      });
      _fetchAnswer(_transcription);
      //  _speakAnswer(_answer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ab(
          'Questions & Answers'.tr(),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Entered question:'),
              ),
              SizedBox(height: 16.0),
              elevatedButon(
                onPressed: () {
                  Future.delayed(Duration(seconds: 5));

                  _fetchAnswer(_questionController.text);
                  _speakAnswer(_answer);
                },
                text: ('Get Answer'.tr()),
              ),
              SizedBox(height: 16.0),
              Text(
                _answer,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: MyColors.color3,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        boldWhiteText('Start Speaking'.tr()),
                        IconButton(
                          icon: Icon(Icons.mic),
                          onPressed: _startListening,
                          iconSize: 40,
                          color: isStartPressed ? Colors.red : Colors.black,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        boldWhiteText('Stop Speaking'.tr()),
                        IconButton(
                          icon: Icon(Icons.stop),
                          onPressed: _stopListening,
                          iconSize: 40,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        boldWhiteText('Answer -play sound'),
                        IconButton(
                          icon: Icon(_isPlaying
                              ? Icons.stop_circle
                              : Icons.play_circle),
                          onPressed: _isPlaying ? _stopSpeaking : null,
                          iconSize: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
