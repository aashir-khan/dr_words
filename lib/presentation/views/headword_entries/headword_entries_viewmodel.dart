import 'package:dr_words/domain/core/entities/dictionary_word.dart';
import 'package:dr_words/domain/dictionary_word_entries/dictionary_word_entries_failure.dart';
import 'package:dr_words/domain/dictionary_word_entries/entities/headword_entry.dart';
import 'package:dr_words/domain/dictionary_word_entries/entities/lexical_entry.dart';
import 'package:dr_words/domain/dictionary_word_entries/i_dictionary_word_entries_repository.dart';
import 'package:dr_words/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:kt_dart/kt.dart';
import 'package:stacked/stacked.dart';

class HeadwordEntriesViewModel extends BaseViewModel {
  final DictionaryWord word;

  HeadwordEntriesViewModel({@required this.word});

  final IDictionaryWordEntriesRepository _dictionaryWordEntriesRepository = getIt<IDictionaryWordEntriesRepository>();

  KtList<HeadwordEntry> _headwordEntries;
  KtList<HeadwordEntry> get headwordEntries => _headwordEntries;
  bool get hasEntries => headwordEntries != null && !headwordEntries.isEmpty();

  KtList<_LexicalEntryWithItsHeadwordNumber> get lexicalEntriesWithHeadwordEntryNumber {
    final List<_LexicalEntryWithItsHeadwordNumber> _lexicalEntriesWithHeadwordNumber = [];
    _headwordEntries.forEachIndexed((headwordEntryIndex, headwordEntry) {
      headwordEntry.lexicalEntries.forEach((lexicalEntry) {
        _lexicalEntriesWithHeadwordNumber.add(
          _LexicalEntryWithItsHeadwordNumber(
            dictionaryWordName: headwordEntry.wordLabel,
            lexicalEntry: lexicalEntry,
            headwordNumber: headwordEntryIndex + 1,
          ),
        );
      });
    });

    return _lexicalEntriesWithHeadwordNumber.toImmutableList();
  }

  Future initialize() async {
    await getWordEntries(word);
  }

  Future getWordEntries(DictionaryWord word) async {
    setBusy(true);
    final resultEither = await _dictionaryWordEntriesRepository.getWordEntries(word);

    resultEither.fold(
      (failure) => setError(_mapFailureToMessage(failure)),
      (results) {
        _headwordEntries = results;
        notifyListeners();
      },
    );

    setBusy(false);
  }
}

String _mapFailureToMessage(DictionaryWordEntriesFailure failure) {
  return failure.when(
    serverError: () => 'An error occurred trying to get dictionary word entries',
    networkError: () => 'Seems like you are not connected to the Internet',
    unexpected: () => 'Unexpected error occurred while trying to get dictionary word entries, please contact support',
  );
}

class _LexicalEntryWithItsHeadwordNumber {
  final String dictionaryWordName;
  final LexicalEntry lexicalEntry;
  final int headwordNumber;

  _LexicalEntryWithItsHeadwordNumber({
    @required this.dictionaryWordName,
    @required this.lexicalEntry,
    @required this.headwordNumber,
  });
}