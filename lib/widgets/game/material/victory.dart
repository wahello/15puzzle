import 'package:fifteenpuzzle/data/result.dart';
import 'package:fifteenpuzzle/links.dart';
import 'package:fifteenpuzzle/play_games.dart';
import 'package:fifteenpuzzle/widgets/game/format.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GameVictoryDialog extends StatelessWidget {
  final Result result;

  final String Function(int) timeFormatter;

  GameVictoryDialog({
    @required this.result,
    this.timeFormatter: formatElapsedTime,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormatted = timeFormatter(result.time);
    return AlertDialog(
      title: Center(
        child: Text(
          "Congratulations!",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
              "You've successfuly completed the ${result.size}x${result.size} puzzle"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Time:',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    timeFormatted,
                    style: Theme.of(context).textTheme.display1.copyWith(
                          color: Theme.of(context).textTheme.body1.color,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Steps:',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    '${result.steps}',
                    style: Theme.of(context).textTheme.display1.copyWith(
                          color: Theme.of(context).textTheme.body1.color,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Leaderboard"),
          onPressed: () {
            final playGames = PlayGamesContainer.of(context);
            playGames.showLeaderboard(
              key: PlayGames.getLeaderboardOfSize(result.size),
            );
          },
        ),
        new FlatButton(
          child: new Text("Share"),
          onPressed: () {
            Share.share("I have solved the Game of Fifteen's "
                "${result.size}x${result.size} puzzle in $timeFormatted "
                "with just ${result.steps} steps! Check it out: $URL_REPOSITORY");
          },
        ),
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
