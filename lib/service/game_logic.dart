import '../models/game_model.dart';

class GameLogic {
  static List<List<int>> winningPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],

    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],

    [0, 4, 8],
    [2, 4, 6],
  ];

  static void playMove(GameModel game, int index) {
    if (game.board[index] != '' || game.gameOver) {
      return;
    }

    /// SAVE HISTORY
    game.history.add(List.from(game.board));

    /// PLACE MOVE
    game.board[index] = game.isXTurn ? 'X' : 'O';

    /// CHECK WINNER
    checkWinner(game);

    /// ONLY CHECK DRAW
    /// IF NO WINNER
    if (!game.gameOver) {
      checkDraw(game);
    }

    /// SWITCH TURN
    if (!game.gameOver) {
      game.isXTurn = !game.isXTurn;
    }
  }

  static void checkWinner(GameModel game) {
    for (var pattern in winningPatterns) {
      String a = game.board[pattern[0]];
      String b = game.board[pattern[1]];
      String c = game.board[pattern[2]];

      if (a != '' && a == b && b == c) {
        game.winner = a;

        game.gameOver = true;

        game.winningIndexes = pattern;

        if (a == 'X') {
          game.xScore++;
        } else {
          game.oScore++;
        }

        return;
      }
    }
  }

  static void checkDraw(GameModel game) {
    bool boardFull = !game.board.contains('');

    if (boardFull && game.winner.isEmpty) {
      game.winner = 'Draw';

      game.gameOver = true;
    }
  }

  static void undoMove(GameModel game) {
    if (game.history.isNotEmpty) {
      game.board = game.history.removeLast();
      game.gameOver = false;
      game.winner = '';
      game.winningIndexes = [];
      game.isXTurn = !game.isXTurn;
    }
  }

  static void resetGame(GameModel game) {
    game.board = List.filled(9, '');

    game.isXTurn = true;

    game.gameOver = false;

    game.winner = '';

    game.winningIndexes = [];

    game.history.clear();
  }
}
