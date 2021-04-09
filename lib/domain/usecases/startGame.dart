import 'package:snake/domain/usecases/update.dart';

class StartGame {
  final Duration duration;
  final UpdateSnake updateSnake;

  StartGame({this.duration});

  void startGame() {
    var snakeposition = [45, 65, 85, 105, 125];
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
}
