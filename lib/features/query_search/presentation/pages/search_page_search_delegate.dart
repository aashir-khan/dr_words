import 'package:dr_words/core/presentation/widgets/loading_indicator/loading_indicator.dart';
import 'package:dr_words/features/query_search/data/models/dictionary_word_model.dart';
import 'package:dr_words/features/query_search/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordQuerySearch extends SearchDelegate<Map<dynamic, dynamic>> {
  final Bloc<QuerySearchEvent, QuerySearchState> bloc;

  WordQuerySearch(this.bloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  TextInputAction get textInputAction => TextInputAction.done;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, Map()),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      bloc.add(GetRecentlySearchedWordsEvent());
    } else {
      bloc.add(ModifyQueryEvent(query: query));
    }

    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is Empty) {
          return Center(
            child: Text('Enter a query to search from'),
          );
        } else if (state is Loading) {
          return LoadingIndicator();
        } else if (state is QuerySearchErrorState) {
          return Text(state.message);
        } else if (state is QuerySearchRecentlySearchedWordsLoadedState) {
          return ListView.builder(
            itemCount: state.recentlySearchedWords.length,
            itemBuilder: (context, index) => InkWell(
              child: Container(
                child: Text(state.recentlySearchedWords[index].label),
                // child: Text('foo'),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
              ),
              onTap: () {},
            ),
          );
        } else if (state is QuerySearchLoadedState) {
          return (state?.querySearchResults?.results ?? []).length == 0
              ? Center(
                  child: Text('No results found'),
                )
              : ListView.builder(
                  itemCount: state.querySearchResults.results.length,
                  itemBuilder: (context, index) => InkWell(
                    child: Container(
                      child: Text(state.querySearchResults.results[index].label),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                    ),
                    onTap: () {
                      final querySingleSearchResult = state.querySearchResults.results[index];
                      bloc.add(AddNewRecentlySearchedWordEvent(newRecentlySearchedWord: querySingleSearchResult));
                      close(context, (querySingleSearchResult as DictionaryWordModel).toJson());
                    },
                  ),
                );
        }
        return Scaffold();
      },
    );
  }
}
