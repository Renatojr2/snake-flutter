import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake/widget/food.dart';
import 'package:snake/widget/pixel.dart';
import 'package:snake/widget/snake.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> snakeposition = [45, 65, 85, 105, 125];
  int numberOfSquares = 600;
  int numberInRow = 20;
  static var randomNumber = Random();
  int food = randomNumber.nextInt(580);
  var direction = 'down';

  void startGame() {
    snakeposition = [45, 65, 85, 105, 125];
    const duration = const Duration(milliseconds: 300);

    Timer.periodic(
      duration,
      (Timer timer) {
        updateSnake();

        if (gameOver()) {
          timer.cancel();
          _showDialogGameOver();
        }
      },
    );
  }

  bool gameOver() {
    for (var i = 0; i < snakeposition.length; i++) {
      int count = 0;
      for (var j = 0; j < snakeposition.length; j++) {
        if (snakeposition[i] == snakeposition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void generateNewFood() {
    food = randomNumber.nextInt(580);
  }

  void _showDialogGameOver() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('GAME OVER'),
          content: Text(
            'Pontos: ${(snakeposition.length - 5)}',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                startGame();
                Navigator.of(context).pop();
              },
              child: Text(
                'Jogar de novo',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakeposition.last > 580) {
            snakeposition.add(snakeposition.last + 20 - 600);
            print(snakeposition.last);
          } else {
            snakeposition.add(snakeposition.last + 20);
            print(snakeposition.last);
          }
          break;

        case 'up':
          if (snakeposition.last < 20) {
            snakeposition.add(snakeposition.last - 20 + 600);
            print(snakeposition.last);
          } else {
            print(snakeposition.last);
            snakeposition.add(snakeposition.last - 20);
          }
          break;

        case 'left':
          if (snakeposition.last % 20 == 0) {
            snakeposition.add(snakeposition.last - 1 + 20);
          } else {
            snakeposition.add(snakeposition.last - 1);
          }
          break;

        case 'right':
          if ((snakeposition.last + 1) % 20 == 0) {
            snakeposition.add(snakeposition.last + 1 - 20);
          } else {
            snakeposition.add(snakeposition.last + 1);
          }
          break;

        default:
      }

      if (snakeposition.last == food) {
        generateNewFood();
      } else {
        snakeposition.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Score:   ${snakeposition.length - 5}',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (direction != 'up' && details.delta.dy > 0) {
                    direction = 'down';
                  } else if (direction != 'down' && details.delta.dy < 0) {
                    direction = 'up';
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (direction != 'left' && details.delta.dx > 0) {
                    direction = 'right';
                  } else if (direction != 'right' && details.delta.dx < 0) {
                    direction = 'left';
                  }
                },
                child: Container(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow),
                    itemBuilder: (context, index) {
                      if (snakeposition.contains(index)) {
                        return Snake();
                      }
                      if (index == food) {
                        return Food();
                      } else {
                        return Container(
                          child: Pixel(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey[900],
              height: 116,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: startGame,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                        color: Colors.green,
                        child: Text(
                          'Start',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        snakeposition = [45, 65, 85, 105, 125];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                        color: Colors.red,
                        child: Text(
                          'Stop',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
