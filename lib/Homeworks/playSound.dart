import 'package:audioplayers/audioplayers.dart';

final player = AudioCache();
playSpecificSound(String file) {
  player.play(file);
}

playrightAnswerSound() {
  player.play('true.mp3');
}

playWrongAnswerSound() {
  player.play('wrong.mp3');
}

playrightAnswerSoundA() {
  player.play('trueA.mp3');
}

playWrongAnswerSoundA() {
  player.play('wrongA.mp3');
}

Future<void> playSoundWhatColorIsThis() async {
  final player = AudioCache();
  player.play('whatcolor.mp3');
}

Future<void> playSoundWhatShapeIsThis() async {
  final player = AudioCache();
  player.play('whatshapeisthis.mp3');
}

Future<void> playSoundWhatAnimalIsThis() async {
  final player = AudioCache();
  player.play('whoisthisanimal.mp3');
}
