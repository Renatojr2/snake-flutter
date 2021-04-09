import 'package:snake/data/snakeData.dart';

class UpdateSnake {
  final List<int> snakeposition;
  final Function(Function()) setState;
  final String direction;
  final int food;

  UpdateSnake({this.snakeposition, this.setState, this.direction, this.food});
  void update() {
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
}
