import 'package:auto_route/auto_route.dart';
import 'package:dr_words/application/dictionary_word_search/dictionary_word_search_bloc.dart';
import 'package:dr_words/domain/core/entities/dictionary_word.dart';
import 'package:dr_words/injection.dart';
import 'package:dr_words/presentation/core/custom_icons_icons.dart';
import 'package:dr_words/presentation/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordDictionaryWordSearch extends SearchDelegate<DictionaryWord> {
  final Bloc<DictionaryWordSearchEvent, DictionaryWordSearchState> bloc;
  WordDictionaryWordSearch(this.bloc);

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
  TextInputAction get textInputAction => TextInputAction.none;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      bloc.add(const DictionaryWordSearchEvent.getRecentlySearchedWords());
    } else {
      bloc.add(DictionaryWordSearchEvent.modifyQuery(query: query));
    }

    return BlocConsumer<DictionaryWordSearchBloc, DictionaryWordSearchState>(
      listener: (context, state) {
        state.maybeWhen(
          newWordAddedToRecentlySearchedWords: (addedWord) => close(context, addedWord),
          orElse: () => null,
        );
      },
      listenWhen: (_, currentState) => currentState.maybeWhen(
        newWordAddedToRecentlySearchedWords: (_) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return state.when(
          initial: () => const Center(
            child: Text('Enter a query to search from', style: TextStyle(fontSize: 20)),
          ),
          loadInProgress: () => LoadingIndicator(),
          loadSearchResultsSuccess: (words) => words.isEmpty()
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Flexible(
                        child: Text(
                          'No results found',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black54),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Try adjusting your search',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: words.size,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      final querySingleSearchResult = words[index];
                      bloc.add(DictionaryWordSearchEvent.addNewRecentlySearchedWord(
                          newRecentlySearchedWord: querySingleSearchResult));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      child: Text(
                        words[index].label,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
          loadFailure: (message) => Center(child: Text(message)),
          newWordAddedToRecentlySearchedWords: (_) => Container(),
          deleteSuccess: (_) => Container(),
          loadRecentlySearchedWordsResultsSuccess: (words) => ListView.builder(
            itemCount: words.size,
            itemBuilder: (context, index) => InkWell(
              onTap: () async {
                final DictionaryWord wordToGetHeadwordEntries = words[index];
                close(context, wordToGetHeadwordEntries);
              },
              child: ListTile(
                leading: const Icon(CustomIcons.time_icon, color: Colors.black),
                title: Text(words[index].label, style: const TextStyle(fontSize: 16)),
                trailing: InkWell(
                  onTap: () {
                    final bloc = getIt<DictionaryWordSearchBloc>();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocProvider.value(
                          value: bloc,
                          child: AlertDialog(
                            content: Text(words[index].label, style: const TextStyle(fontWeight: FontWeight.bold)),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () => ExtendedNavigator.root.pop(),
                                child: const Text('CANCEL'),
                              ),
                              FlatButton(
                                onPressed: () {
                                  bloc.add(
                                      DictionaryWordSearchEvent.deleteRecentlySearchedWord(wordToDelete: words[index]));
                                  ExtendedNavigator.root.pop();
                                },
                                child: const Text('DELETE'),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
