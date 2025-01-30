import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<String> whiteKeys = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];
  final List<String> blackKeys = ['C#', 'D#', 'E#', 'F#', 'G#', 'A#', 'B#'];

  void playSound(String note) {
    audioPlayer.play(AssetSource('notes/$note.mp3'));
  }

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: whiteKeys.map((key) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => playSound(key),
                  child: Container(
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(child: Text(key)),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Row(
                children: whiteKeys.map((key) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.all(1),
                      color: Colors.transparent,
                    ),
                  );
                }).toList(),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Row(
                  children: whiteKeys.map((key) {
                    if (blackKeys.contains('$key#')) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => playSound('$key#'),
                          child: Container(
                            margin: EdgeInsets.all(1),
                            width: 40, // Adjust width for black keys
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white),
                            ),
                            child: Center(
                              child: Text(
                                '$key#',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Expanded(child: Container());
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
