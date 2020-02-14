import 'package:dr_words/core/domain/entities/dictionary_word.dart';
import 'package:dr_words/features/word_details/presentation/pages/headword_entries_page.dart';
import 'package:dr_words/injection.iconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/routes_path.dart' as routes;
import 'core/presentation/pages/home_page/home_page.dart';
import 'features/query_search/presentation/bloc/query_search_bloc.dart';
import 'features/query_search/presentation/pages/search_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.HomeRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case routes.SearchRoute:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => getIt<QuerySearchBloc>(),
          child: SearchPage(),
        ),
      );
    case routes.HeadwordEntriesRoute:
      final dictionaryWord = settings.arguments as DictionaryWord;

      return MaterialPageRoute(
        builder: (context) => HeadwordEntriesPage(dictionaryWord),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
