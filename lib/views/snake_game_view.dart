import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import '../controllers/snake_game_controller.dart';
import '../models/snake_game_model.dart';

class SnakeGameView extends GetView<SnakeGameController> {
  const SnakeGameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.pauseGame();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Yılan Oyunu'),
          actions: [
            IconButton(
              icon: Obx(() => Icon(
                    controller.gameModel.isPaused.value
                        ? Icons.play_arrow
                        : Icons.pause,
                  )),
              onPressed: controller.pauseGame,
            ),
          ],
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          'Skor: ${controller.gameModel.score.value}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )),
                    Obx(() => Text(
                          'En Yüksek Skor: ${controller.gameModel.highScore.value}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GameWidget(
                      game: SnakeGame(controller),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_left, color: Colors.white),
                      onPressed: controller.moveLeft,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_upward, color: Colors.white),
                      onPressed: controller.moveUp,
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_downward, color: Colors.white),
                      onPressed: controller.moveDown,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right, color: Colors.white),
                      onPressed: controller.moveRight,
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

class SnakeGame extends FlameGame with TapDetector {
  final SnakeGameController controller;
  late final SnakeComponent snakeComponent;
  late final FoodComponent foodComponent;
  double _timeSinceLastMove = 0;

  SnakeGame(this.controller) : super();

  @override
  Future<void> onLoad() async {
    // Oyun alanını ayarla
    camera.viewfinder.zoom = 1.0;
    camera.viewfinder.anchor = Anchor.topLeft;

    // Bileşenleri oluştur
    snakeComponent = SnakeComponent(controller);
    foodComponent = FoodComponent(controller);

    // Bileşenleri ekle
    add(snakeComponent);
    add(foodComponent);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (controller.gameModel.isGameOver.value) {
      controller.restartGame();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (controller.gameModel.isGameOver.value) {
      pauseEngine();
      return;
    }

    if (!controller.gameModel.isPaused.value) {
      _timeSinceLastMove += dt;
      if (_timeSinceLastMove >= 0.2) {
        controller.gameModel.move();
        if (controller.gameModel.isGameOver.value) {
          controller.gameOver();
        }
        _timeSinceLastMove = 0;
      }
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // Oyun alanını ortala
    camera.viewfinder.position = Vector2(
      size.x / 2 -
          (controller.gameModel.gridSize * controller.gameModel.cellSize) / 2,
      size.y / 2 -
          (controller.gameModel.gridSize * controller.gameModel.cellSize) / 2,
    );
  }
}

class SnakeComponent extends Component {
  final SnakeGameController controller;

  SnakeComponent(this.controller) : super();

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.green;
    final cellSize = controller.gameModel.cellSize.toDouble();

    for (var point in controller.gameModel.snake) {
      canvas.drawRect(
        Rect.fromLTWH(
          point.x * cellSize,
          point.y * cellSize,
          cellSize - 1,
          cellSize - 1,
        ),
        paint,
      );
    }
  }
}

class FoodComponent extends Component {
  final SnakeGameController controller;

  FoodComponent(this.controller) : super();

  @override
  void render(Canvas canvas) {
    if (controller.gameModel.food != null) {
      final paint = Paint()..color = Colors.red;
      final cellSize = controller.gameModel.cellSize.toDouble();
      final food = controller.gameModel.food!;

      canvas.drawRect(
        Rect.fromLTWH(
          food.x * cellSize,
          food.y * cellSize,
          cellSize - 1,
          cellSize - 1,
        ),
        paint,
      );
    }
  }
}
