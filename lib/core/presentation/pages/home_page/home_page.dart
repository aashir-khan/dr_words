import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dr_words/core/presentation/routes/router.gr.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> popupMenuChoices = ['Settings', 'Help', 'About'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.searchPage),
          ),
          PopupMenuButton<String>(
            // ! TODO
            onSelected: (_) {},
            itemBuilder: (context) => popupMenuChoices
                .map(
                  (choice) => PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
