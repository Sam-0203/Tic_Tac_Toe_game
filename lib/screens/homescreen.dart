import 'package:flutter/material.dart';

import '../models/game_model.dart';
import '../service/game_logic.dart';
import '../widgets/game_cell.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GameModel game = GameModel.initial();

  @override
  void initState() {
    super.initState();

    askPlayerNames();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void askPlayerNames() {
    TextEditingController xController = TextEditingController();

    TextEditingController oController = TextEditingController();

    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,

        barrierDismissible: false,

        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,

            child: Container(
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff6A11CB), Color(0xff2575FC)],

                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                borderRadius: BorderRadius.circular(30),

                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  /// TITLE
                  const Icon(
                    Icons.sports_esports,
                    size: 70,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Tic Tac Toe',

                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Enter Player Names',

                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),

                  const SizedBox(height: 30),

                  /// PLAYER X
                  TextField(
                    controller: xController,

                    style: const TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.white.withOpacity(0.15),

                      hintText: 'Player X',

                      hintStyle: const TextStyle(color: Colors.white70),

                      prefixIcon: const Icon(Icons.close, color: Colors.blue),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// PLAYER O
                  TextField(
                    controller: oController,

                    style: const TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.white.withOpacity(0.15),

                      hintText: 'Player O',

                      hintStyle: const TextStyle(color: Colors.white70),

                      prefixIcon: const Icon(
                        Icons.circle_outlined,
                        color: Colors.red,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// START BUTTON
                  SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,

                        foregroundColor: Colors.deepPurple,

                        elevation: 8,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      onPressed: () {
                        setState(() {
                          game.playerX = xController.text.trim().isEmpty
                              ? 'Player X'
                              : xController.text;

                          game.playerO = oController.text.trim().isEmpty
                              ? 'Player O'
                              : oController.text;
                        });

                        Navigator.pop(context);
                      },

                      child: const Text(
                        'START GAME',

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  void onCellTap(int index) {
    setState(() {
      GameLogic.playMove(game, index);

      if (game.gameOver && game.winner != 'Draw') {}
    });

    /// POPUP
    if (game.gameOver) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showDialog(
          context: context,

          barrierDismissible: false,

          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),

              title: Center(
                child: Text(
                  game.winner == 'Draw' ? 'Game Draw 🤝' : 'Winner 🎉',

                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              content: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Icon(
                    game.winner == 'Draw'
                        ? Icons.handshake
                        : Icons.emoji_events,

                    size: 80,

                    color: game.winner == 'Draw' ? Colors.orange : Colors.amber,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    game.winner == 'Draw'
                        ? 'Nobody Wins!'
                        : game.winner == 'X'
                        ? '${game.playerX} Wins!'
                        : '${game.playerO} Wins!',

                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              actions: [
                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,

                      padding: const EdgeInsets.symmetric(vertical: 14),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),

                    onPressed: () {
                      Navigator.pop(context);

                      setState(() {
                        GameLogic.resetGame(game);
                      });
                    },

                    icon: const Icon(Icons.refresh, color: Colors.white),

                    label: const Text(
                      'Restart',

                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      });
    }
  }

  String getStatusText() {
    if (game.winner == 'Draw') {
      return 'Game Draw';
    }

    if (game.winner == 'X') {
      return '${game.playerX} Wins!';
    }

    if (game.winner == 'O') {
      return '${game.playerO} Wins!';
    }

    return game.isXTurn ? "${game.playerX}'s Turn" : "${game.playerO}'s Turn";
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = game.isDarkMode;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xff121212)
          : const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.transparent,

        centerTitle: true,

        title: Text(
          'Tic Tac Toe',

          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),

            child: IconButton(
              onPressed: () {
                setState(() {
                  game.isDarkMode = !game.isDarkMode;
                });
              },

              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,

                size: 30,

                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),

            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  /// SCOREBOARD
                  Container(
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xff1E1E1E) : Colors.white,

                      borderRadius: BorderRadius.circular(24),

                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        /// PLAYER X
                        Column(
                          children: [
                            Text(
                              game.playerX,

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,

                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'X',

                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),

                            Text(
                              '${game.xScore}',

                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,

                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),

                        Container(height: 90, width: 1, color: Colors.grey),

                        /// PLAYER O
                        Column(
                          children: [
                            Text(
                              game.playerO,

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,

                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'O',

                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),

                            Text(
                              '${game.oScore}',

                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,

                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// STATUS
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),

                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: game.winner.isNotEmpty
                            ? [Colors.green, Colors.greenAccent]
                            : [Colors.deepPurple, Colors.purpleAccent],
                      ),

                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Text(
                      getStatusText(),

                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// GRID
                  SizedBox(
                    height: MediaQuery.of(context).size.width - 40,

                    child: Container(
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xff1A1A1A)
                            : const Color(0xffF8F9FC),

                        borderRadius: BorderRadius.circular(30),

                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black12,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),

                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),

                        itemCount: 9,

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,

                              crossAxisSpacing: 10,

                              mainAxisSpacing: 10,
                            ),

                        itemBuilder: (context, index) {
                          return GameCell(
                            value: game.board[index],

                            onTap: () => onCellTap(index),

                            isWinningCell: game.winningIndexes.contains(index),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          /// CONFETTI
        ],
      ),
    );
  }
}
