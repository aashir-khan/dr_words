import 'package:dr_words/locator.dart';
import 'package:dr_words/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:dr_words/constants/routes_path.dart' as routes;

class HomeViewModel extends ChangeNotifier {
  final navigationService = locator<NavigationService>();

  String appBarText;
  List<String> popupMenuChoices;

  void initialise(BuildContext context) {
    appBarText = 'Favorites';

    popupMenuChoices = ['Settings', 'Help', 'About'];
  }

  void beginSearch(context) async {
    this.navigateToSearch();
  }

  void handlePopupMenuSelection(String choice) {
    // print(choice);
  }

  void navigateToSearch() {
    // navigationService.navigateTo(routes.SearchRoute);
    navigationService.navigateWithReplacement(routes.SearchRoute);
  }
}
