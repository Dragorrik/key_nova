import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<String> whiteKeys = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];
  final List<String> blackKeys = ['C#', 'D#', 'F#', 'G#', 'A#'];
  bool isKeyPressed = false;
  String? pressedKey;

  void playSound(String note) {
    audioPlayer.play(AssetSource('notes/$note.mp3'));
  }

  void onKeyPressed(String key) {
    setState(() {
      isKeyPressed = true;
      pressedKey = key;
    });
    playSound(key);
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        isKeyPressed = false;
        pressedKey = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              const Color.fromARGB(255, 167, 176, 180)
            ],
          ),
        ),
        child: Column(
          children: [
            // White Keys
            Expanded(
              child: Row(
                children: whiteKeys.map((key) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onKeyPressed(key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: pressedKey == key && isKeyPressed
                              ? Colors
                                  .grey[300] // Lighten the color when pressed
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            key,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: pressedKey == key && isKeyPressed
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Black Keys
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  // Space
                  const Expanded(flex: 1, child: SizedBox()),
                  // Black keys
                  ...whiteKeys.map((key) {
                    if (blackKeys.contains('$key#')) {
                      return Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () => onKeyPressed('$key#'),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: pressedKey == '$key#' && isKeyPressed
                                  ? Colors.grey[
                                      800] // Lighten the color when pressed
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '$key#',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: pressedKey == '$key#' && isKeyPressed
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Expanded(flex: 2, child: SizedBox());
                    }
                  }),
                  // Spacer for the last white key (B)
                  const Expanded(flex: 1, child: SizedBox()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
