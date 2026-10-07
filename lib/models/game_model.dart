class GameModel {
  List<String> board;
  bool isXTurn;
  bool gameOver;
  String winner;
  int xScore;
  int oScore;
  List<int> winningIndexes;
  List<List<String>> history;
  String playerX;
  String playerO;
  bool isDarkMode;

  GameModel({
    required this.board,
    required this.isXTurn,
    required this.gameOver,
    required this.winner,
    required this.xScore,
    required this.oScore,
    required this.winningIndexes,
    required this.history,
    required this.playerX,
    required this.playerO,
    required this.isDarkMode,
  });

  factory GameModel.initial() {
    return GameModel(
      board: List.filled(9, ''),
      isXTurn: true,
      gameOver: false,
      winner: '',
      xScore: 0,
      oScore: 0,
      winningIndexes: [],
      history: [],
      playerX: 'Player X',
      playerO: 'Player O',
      isDarkMode: false,
    );
  }
}
