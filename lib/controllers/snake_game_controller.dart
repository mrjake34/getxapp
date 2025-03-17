import 'package:get/get.dart';
import '../models/snake_game_model.dart';

class SnakeGameController extends GetxController {
  final SnakeGameModel gameModel = SnakeGameModel();
  var gameLoop = false.obs;
  var isFirstLoad = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (isFirstLoad.value) {
      startGame();
      isFirstLoad.value = false;
    }
  }

  void startGame() {
    gameModel.initGame();
    gameLoop.value = true;
    update();
  }

  void pauseGame() {
    gameModel.togglePause();
    gameLoop.value = !gameLoop.value;
    update();
  }

  void moveUp() {
    gameModel.changeDirection(Direction.up);
    update();
  }

  void moveDown() {
    gameModel.changeDirection(Direction.down);
    update();
  }

  void moveLeft() {
    gameModel.changeDirection(Direction.left);
    update();
  }

  void moveRight() {
    gameModel.changeDirection(Direction.right);
    update();
  }

  void gameOver() {
    gameLoop.value = false;
    update();
  }

  void restartGame() {
    startGame();
  }

  @override
  void onClose() {
    gameLoop.value = false;
    super.onClose();
  }
}
