import 'package:get/get.dart';
import 'dart:math';

class SnakeGameModel {
  final int gridSize = 20;
  final int cellSize = 20;
  final List<Point> snake = [];
  Point? food;
  var direction = Direction.right;
  var score = 0.obs;
  var isGameOver = false.obs;
  var highScore = 0.obs;
  var isPaused = false.obs;

  void initGame() {
    snake.clear();
    snake.add(Point(5, 5));
    generateFood();
    direction = Direction.right;
    score.value = 0;
    isGameOver.value = false;
    isPaused.value = false;
  }

  void generateFood() {
    final random = Random();
    do {
      food = Point(
        random.nextInt(gridSize),
        random.nextInt(gridSize),
      );
    } while (snake.contains(food));
  }

  void move() {
    if (isGameOver.value || isPaused.value) return;

    final head = snake.first;
    Point newHead;

    switch (direction) {
      case Direction.up:
        newHead = Point(head.x, head.y - 1);
        break;
      case Direction.down:
        newHead = Point(head.x, head.y + 1);
        break;
      case Direction.left:
        newHead = Point(head.x - 1, head.y);
        break;
      case Direction.right:
        newHead = Point(head.x + 1, head.y);
        break;
    }

    if (isCollision(newHead)) {
      isGameOver.value = true;
      if (score.value > highScore.value) {
        highScore.value = score.value;
      }
      return;
    }

    snake.insert(0, newHead);

    if (newHead == food) {
      score.value += 10;
      generateFood();
    } else {
      snake.removeLast();
    }
  }

  bool isCollision(Point point) {
    if (point.x < 0 ||
        point.x >= gridSize ||
        point.y < 0 ||
        point.y >= gridSize) {
      return true;
    }
    return snake.contains(point);
  }

  void changeDirection(Direction newDirection) {
    if (isGameOver.value || isPaused.value) return;

    switch (newDirection) {
      case Direction.up:
        if (direction != Direction.down) direction = Direction.up;
        break;
      case Direction.down:
        if (direction != Direction.up) direction = Direction.down;
        break;
      case Direction.left:
        if (direction != Direction.right) direction = Direction.left;
        break;
      case Direction.right:
        if (direction != Direction.left) direction = Direction.right;
        break;
    }
  }

  void togglePause() {
    isPaused.value = !isPaused.value;
  }
}

enum Direction { up, down, left, right }
