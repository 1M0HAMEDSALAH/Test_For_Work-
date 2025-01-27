import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(WordleApp());
}

class WordleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WordleGame(),
    );
  }
}

class WordleGame extends StatefulWidget {
  @override
  _WordleGameState createState() => _WordleGameState();
}

class _WordleGameState extends State<WordleGame> {
  static const List<String> wordList = [
    "apple", "brick", "chair", "table", "grape"
  ]; // Add more words as needed.
  String targetWord = "";
  List<String> guesses = [];
  String currentGuess = "";
  
  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    targetWord = wordList[Random().nextInt(wordList.length)];
    guesses.clear();
    currentGuess = "";
    setState(() {});
  }

  void onKeyTap(String key) {
    if (key == "ENTER") {
      if (currentGuess.length == 5) {
        guesses.add(currentGuess);
        if (currentGuess == targetWord) {
          showResultDialog("Congratulations! You guessed the word!");
        } else if (guesses.length == 6) {
          showResultDialog("Game Over! The word was $targetWord.");
        }
        currentGuess = "";
      }
    } else if (key == "DEL") {
      if (currentGuess.isNotEmpty) {
        currentGuess = currentGuess.substring(0, currentGuess.length - 1);
      }
    } else {
      if (currentGuess.length < 5) {
        currentGuess += key;
      }
    }
    setState(() {});
  }

  void showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: Text("Play Again"),
          ),
        ],
      ),
    );
  }

  Widget buildKeyboard() {
    const keys = [
      "QWERTYUIOP",
      "ASDFGHJKL",
      "ZXCVBNM"
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.split("").map((letter) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () => onKeyTap(letter),
                child: Text(letter),
              ),
            );
          }).toList(),
        );
      }).toList()
        ..add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => onKeyTap("DEL"),
              child: Text("DEL"),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => onKeyTap("ENTER"),
              child: Text("ENTER"),
            ),
          ],
        )),
    );
  }

  Widget buildGuessRow(String guess) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        Color color = Colors.grey;
        if (index < guess.length) {
          if (guess[index] == targetWord[index]) {
            color = Colors.green;
          } else if (targetWord.contains(guess[index])) {
            color = Colors.yellow;
          }
        }
        return Container(
          margin: EdgeInsets.all(4.0),
          width: 40,
          height: 40,
          color: color,
          child: Center(
            child: Text(
              index < guess.length ? guess[index].toUpperCase() : "",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wordle Clone"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return buildGuessRow(
                  index < guesses.length ? guesses[index] : currentGuess,
                );
              }),
            ),
          ),
          buildKeyboard(),
        ],
      ),
    );
  }
}
