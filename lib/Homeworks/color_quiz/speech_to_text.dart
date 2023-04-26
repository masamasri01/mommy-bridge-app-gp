import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gp/Homeworks/color_quiz/color_quiz.dart';
import 'package:gp/Homeworks/playSound.dart';
import 'package:gp/Providers/QuizProvider.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/cupertino.dart';

class SpeechSampleApp extends StatefulWidget {
  @override
  _SpeechSampleAppState createState() => _SpeechSampleAppState();
}

/// An example that demonstrates the basic functionality of the
/// SpeechToText plugin for using the speech recognition capability
/// of the underlying platform.
class _SpeechSampleAppState extends State<SpeechSampleApp> {
  bool _hasSpeech = false;
  bool _logEvents = false;
  bool _onDevice = false;
  final TextEditingController _pauseForController =
      TextEditingController(text: '3');
  final TextEditingController _listenForController =
      TextEditingController(text: '300');
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
  }

  /// This initializes SpeechToText. That only has to be done
  /// once per application, though calling it again is harmless
  /// it also does nothing. The UX of the sample app ensures that
  /// it can only be called once.
  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
  }

  final childKey = GlobalKey<ColorsQuizState>();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentColor =
        Provider.of<QuizProvider>(context, listen: false).color;
    // This is called each time the users wants to start a new speech
    // recognition session
    void startListening() async {
      _logEvent('start listening');
      lastWords = '';
      lastError = '';
      final pauseFor = int.tryParse(_pauseForController.text);
      final listenFor = int.tryParse(_listenForController.text);
      // Note that `listenFor` is the maximum, not the minimun, on some
      // systems recognition will be stopped before this value is reached.
      // Similarly `pauseFor` is a maximum not a minimum and may be ignored
      // on some devices.
      await speech.listen(
        onResult: (result) {
          _logEvent(
              'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
          setState(() {
            lastWords = '${result.recognizedWords} - ${result.finalResult}';
          });

          //  Check if the user has finished speaking
          if (result.finalResult) {
            //  print('Speech recognized: ${result.recognizedWords}');

            _performVoice(context, result.recognizedWords);
            // Perform the desired function here

          }
        },
        listenFor: Duration(seconds: listenFor ?? 3000),
        pauseFor: Duration(seconds: pauseFor ?? 3),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation,
        onDevice: _onDevice,
      );
      setState(() {});
    }

    return Scaffold(
      appBar: ab('Colors Quiz'),
      body: SingleChildScrollView(
        child: Column(children: [
          // HeaderWidget(),
          Container(
            child: Column(
              children: <Widget>[
                InitSpeechWidget(_hasSpeech, initSpeechState),

                _hasSpeech
                    ? Column(
                        children: [
                          ColorsQuiz(
                            key: childKey,
                            recognizedWord: lastWords,
                          ),
                          Container(
                            height: 150,
                            child: RecognitionResultsWidget(
                                lastWords: lastWords, level: level),
                          ),
                          SpeechControlWidget(_hasSpeech, speech.isListening,
                              startListening, stopListening, cancelListening),
                        ],
                      )
                    : Container()

                // SessionOptionsWidget(
                //   _currentLocaleId,
                //   _switchLang,
                //   _localeNames,
                //   _logEvents,
                //   _switchLogging,
                //   _pauseForController,
                //   _listenForController,
                //   _onDevice,
                //   _switchOnDevice,
                // ),
              ],
            ),
          ),

          // Expanded(
          //   flex: 1,
          //   child: ErrorWidget(lastError: lastError),
          // ),
          _hasSpeech
              ? Column(
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    SpeechStatusWidget(speech: speech),
                    SizedBox(
                      height: 3,
                    ),
                    RightAnswer(),
                    SizedBox(
                      height: 3,
                    ),
                    yourPoints()
                  ],
                )
              : SizedBox()
        ]),
      ),
    );
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }

  void _switchOnDevice(bool? val) {
    setState(() {
      _onDevice = val ?? false;
    });
  }

  void _performVoice(BuildContext context, String recognizedWords) {
    if (isTrueAnswer(recognizedWords,
        Provider.of<QuizProvider>(context, listen: false).color['name'])) {
      Provider.of<QuizProvider>(context, listen: false).setrightAnswer(true);
      Provider.of<QuizProvider>(context, listen: false).incrementPoints();
      playrightAnswerSound();
      Future.delayed(Duration(seconds: 3)).then(
        (value) => {childKey.currentState?.generateQuestion()},
      );
    } else {
      playWrongAnswerSound();
      Provider.of<QuizProvider>(context, listen: false).setrightAnswer(false);
      Provider.of<QuizProvider>(context, listen: false).decrementPoints();
    }
  }
}

/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key? key,
    required this.lastWords,
    required this.level,
  }) : super(key: key);

  final String lastWords;
  final double level;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Recognized Words:',
            style: TextStyle(
                fontSize: 22.0, color: Color.fromARGB(255, 90, 89, 89)),
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                color: Theme.of(context).selectedRowColor,
                child: Center(
                  child: Text(
                    lastWords,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Positioned.fill(
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .26,
                            spreadRadius: level * 1.5,
                            color: Colors.black.withOpacity(.05))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () => null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Speech recognition available',
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }
}

/// Display the current error status from the speech
/// recognizer
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    required this.lastError,
  }) : super(key: key);

  final String lastError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Error Status',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Center(
          child: Text(lastError),
        ),
      ],
    );
  }
}

/// Controls to start and stop speech recognition
class SpeechControlWidget extends StatelessWidget {
  SpeechControlWidget(this.hasSpeech, this.isListening, this.startListening,
      this.stopListening, this.cancelListening,
      {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final bool isListening;
  void Function() startListening;
  final void Function() stopListening;
  final void Function() cancelListening;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ElevatedButton(
          onPressed: !hasSpeech || isListening ? null : startListening,
          child: Text('Start'),
        ),
        ElevatedButton(
          onPressed: isListening ? stopListening : null,
          child: Text('Stop'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
        TextButton(
          onPressed: isListening ? cancelListening : null,
          child: Text('Cancel'),
        )
      ],
    );
  }
}

class SessionOptionsWidget extends StatelessWidget {
  const SessionOptionsWidget(
      this.currentLocaleId,
      this.switchLang,
      this.localeNames,
      this.logEvents,
      this.switchLogging,
      this.pauseForController,
      this.listenForController,
      this.onDevice,
      this.switchOnDevice,
      {Key? key})
      : super(key: key);

  final String currentLocaleId;
  final void Function(String?) switchLang;
  final void Function(bool?) switchLogging;
  final void Function(bool?) switchOnDevice;
  final TextEditingController pauseForController;
  final TextEditingController listenForController;
  final List<LocaleName> localeNames;
  final bool logEvents;
  final bool onDevice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Text('Language: '),
              DropdownButton<String>(
                onChanged: (selectedVal) => switchLang(selectedVal),
                value: currentLocaleId,
                items: localeNames
                    .map(
                      (localeName) => DropdownMenuItem(
                        value: localeName.localeId,
                        child: Text(localeName.name),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Row(
            children: [
              Text('pauseFor: '),
              Container(
                  padding: EdgeInsets.only(left: 8),
                  width: 80,
                  child: TextFormField(
                    controller: pauseForController,
                  )),
              Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Text('listenFor: ')),
              Container(
                  padding: EdgeInsets.only(left: 8),
                  width: 80,
                  child: TextFormField(
                    controller: listenForController,
                  )),
            ],
          ),
          Row(
            children: [
              Text('On device: '),
              Checkbox(
                value: onDevice,
                onChanged: switchOnDevice,
              ),
              Text('Log events: '),
              Checkbox(
                value: logEvents,
                onChanged: switchLogging,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InitSpeechWidget extends StatelessWidget {
  const InitSpeechWidget(this.hasSpeech, this.initSpeechState, {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final Future<void> Function() initSpeechState;

  @override
  Widget build(BuildContext context) {
    return hasSpeech
        ? Container()
        : TextButton(
            onPressed: hasSpeech ? null : initSpeechState,
            child: Text('Initialize microphone'),
          );
  }
}

/// Display the current status of the listener
class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    Key? key,
    required this.speech,
  }) : super(key: key);

  final SpeechToText speech;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: speech.isListening
            ? Text(
                "I'm listening...",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Text(
                'Not listening',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}

class RightAnswer extends StatelessWidget {
  const RightAnswer({super.key});

  @override
  Widget build(BuildContext context) {
    bool rightAnswer =
        Provider.of<QuizProvider>(context, listen: false).rightAnswer;
    return Container(
      alignment: Alignment.center,
      child: rightAnswer
          ? boldGreenText('Right  Answer :) ')
          : boldRedText('Wrong  Answer :('),
    );
  }
}

class yourPoints extends StatelessWidget {
  const yourPoints({super.key});

  @override
  Widget build(BuildContext context) {
    int yourPints =
        Provider.of<QuizProvider>(context, listen: false).yourPoints;
    return Container(
        alignment: Alignment.center,
        child: Card(
          child: Padding(
            child: boldText2('Your Points = ${yourPints}'),
            padding: EdgeInsets.all(10),
          ),
        ));
  }
}
