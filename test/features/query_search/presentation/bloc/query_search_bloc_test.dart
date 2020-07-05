import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dr_words/core/domain/entities/dictionary_word.dart';
import 'package:dr_words/core/domain/usecases/usecase.dart';
import 'package:dr_words/core/error/failures.dart';
import 'package:dr_words/features/query_search/data/models/query_search_results_model.dart';
import 'package:dr_words/features/query_search/domain/usecases/add_new_recently_searched_word/add_new_recently_searched_word.dart'
    as add_new_word_use_case;
import 'package:dr_words/features/query_search/domain/usecases/get_query_search_results/get_query_search_results.dart'
    as get_query_use_case;
import 'package:dr_words/features/query_search/domain/usecases/get_recently_searched_words/get_recently_searched_words.dart'
    as get_recently_searched_use_case;
import 'package:dr_words/features/query_search/presentation/bloc/bloc.dart';
import 'package:dr_words/features/query_search/presentation/bloc/query_search_bloc.dart';
import 'package:dr_words/injection.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/setup_all_for_test.dart';

Future<void> main() async {
  await setupInjectionForTest();

  DictionaryWordSearchBloc bloc;
  get_recently_searched_use_case.GetRecentlySearchedWords mockGetRecentlySearchedWords;
  get_query_use_case.GetDictionaryWordSearchResults mockGetDictionaryWordSearchResults;
  add_new_word_use_case.AddNewRecentlySearchedWord mockAddNewRecentlySearchedWord;

  setUp(() {
    mockGetRecentlySearchedWords = getIt<get_recently_searched_use_case.GetRecentlySearchedWords>();
    mockGetDictionaryWordSearchResults = getIt<get_query_use_case.GetDictionaryWordSearchResults>();
    mockAddNewRecentlySearchedWord = getIt<add_new_word_use_case.AddNewRecentlySearchedWord>();

    bloc = DictionaryWordSearchBloc(
      getRecentlySearchedWords: mockGetRecentlySearchedWords,
      addNewRecentlySearchedWord: mockAddNewRecentlySearchedWord,
      getDictionaryWordSearchResults: mockGetDictionaryWordSearchResults,
    );
  });

  test('initialState should be Empty', () async {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group(
    'GetRecentlySearchedWordsEvent',
    () {
      final tListOfDictionaryWord = [DictionaryWord.fromFakeData()];

      test('should get data using the GetRecentlySearchedWords use case', () async {
        // act
        bloc.add(GetRecentlySearchedWordsEvent());
        await untilCalled(mockGetRecentlySearchedWords.call(any));

        // assert
        verify(mockGetRecentlySearchedWords.call(NoParams()));
      });

      blocTest(
        'should emit [Loading, DictionaryWordSearchErrorState] when there is an issue adding the recently searched word to the usecase - local database processing failure',
        build: () async {
          when(mockGetRecentlySearchedWords.call(any)).thenAnswer((_) async => Left(LocalDatabaseProcessingFailure()));
          return bloc;
        },
        act: (bloc) async => bloc.add(GetRecentlySearchedWordsEvent()),
        expect: [Empty(), Loading(), DictionaryWordSearchErrorState(message: localDatabaseProcessingFailureMessage)],
      );

      blocTest(
        'should emit [Loading, DictionaryWordSearchNewWordAddedState] when new word is successfully added',
        build: () async {
          when(mockGetRecentlySearchedWords.call(any)).thenAnswer((_) async => Right(tListOfDictionaryWord));
          return bloc;
        },
        act: (bloc) async => bloc.add(GetRecentlySearchedWordsEvent()),
        expect: [
          Empty(),
          Loading(),
          DictionaryWordSearchRecentlySearchedWordsLoadedState(recentlySearchedWords: tListOfDictionaryWord)
        ],
      );
    },
  );

  group('ModifyQueryEvent', () {
    final tQuery = faker.lorem.word();
    const tEmptyQuery = '';

    final tDictionaryWordSearchResults = DictionaryWordSearchResultsModel.fromFakeData();

    test('should get data from the GetDictionaryWordSearchResults use case', () async {
      // act
      bloc.add(ModifyQueryEvent(query: tQuery));
      await untilCalled(mockGetDictionaryWordSearchResults.call(any));

      // assert
      verify(mockGetDictionaryWordSearchResults.call(get_query_use_case.Params(query: tQuery)));
    });

    blocTest(
      'should emit [Empty] when query is empty',
      build: () async => bloc,
      act: (bloc) async => bloc.add(const ModifyQueryEvent(query: tEmptyQuery)),
      expect: [Empty()],
    );

    blocTest(
      'should emit [Loading, DictionaryWordSearchErrorState] when there is an issue getting the query results from the usecase - server failure',
      build: () async {
        when(mockGetDictionaryWordSearchResults.call(any)).thenAnswer((_) async => Left(ServerFailure()));

        return bloc;
      },
      act: (bloc) async => bloc.add(ModifyQueryEvent(query: tQuery)),
      expect: [Empty(), Loading(), DictionaryWordSearchErrorState(message: serverFailureMessage)],
    );

    blocTest(
      'should emit [Loading, DictionaryWordSearchErrorState] when there is an issue getting the query results from the usecase - server failure',
      build: () async {
        when(mockGetDictionaryWordSearchResults.call(any)).thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) async => bloc.add(ModifyQueryEvent(query: tQuery)),
      expect: [Empty(), Loading(), DictionaryWordSearchErrorState(message: serverFailureMessage)],
    );

    blocTest(
      'should emit [Loading, DictionaryWordSearchErrorState] when there is an issue getting the query results from the usecase - network failure',
      build: () async {
        when(mockGetDictionaryWordSearchResults.call(any)).thenAnswer((_) async => Left(NetworkFailure()));

        return bloc;
      },
      act: (bloc) async => bloc.add(ModifyQueryEvent(query: tQuery)),
      expect: [Empty(), Loading(), DictionaryWordSearchErrorState(message: networkFailureMessage)],
    );

    blocTest(
      'should emit [Loading, DictionaryWordSearchLoadedState] when data is gotten successfully',
      build: () async {
        when(mockGetDictionaryWordSearchResults.call(any)).thenAnswer((_) async => Right(tDictionaryWordSearchResults));

        return bloc;
      },
      act: (bloc) async => bloc.add(ModifyQueryEvent(query: tQuery)),
      expect: [
        Empty(),
        Loading(),
        DictionaryWordSearchLoadedState(DictionaryWordSearchResults: tDictionaryWordSearchResults)
      ],
    );
  });

  group('AddNewRecentlySearchedWordEvent', () {
    final tNewWordToAdd = DictionaryWord.fromFakeData();

    test('should add new data using the AddNewRecentlySearchedWord use case', () async {
      // act
      bloc.add(AddNewRecentlySearchedWordEvent(newRecentlySearchedWord: tNewWordToAdd));
      await untilCalled(mockAddNewRecentlySearchedWord.call(any));

      // assert
      verify(mockAddNewRecentlySearchedWord.call(add_new_word_use_case.Params(newWordToAdd: tNewWordToAdd)));
    });

    blocTest(
      'should emit [Loading, DictionaryWordSearchErrorState] when there is an issue adding the recently searched word to the usecase - local database processing failure',
      build: () async {
        when(mockAddNewRecentlySearchedWord.call(any)).thenAnswer((_) async => Left(LocalDatabaseProcessingFailure()));

        return bloc;
      },
      act: (bloc) async => bloc.add(AddNewRecentlySearchedWordEvent(newRecentlySearchedWord: tNewWordToAdd)),
      expect: [Empty(), Loading(), DictionaryWordSearchErrorState(message: localDatabaseProcessingFailureMessage)],
    );

    blocTest(
      'should emit [Loading, DictionaryWordSearchNewWordAddedState] when new word is successfully added',
      build: () async {
        when(mockAddNewRecentlySearchedWord.call(any)).thenAnswer((_) async => const Right(true));

        return bloc;
      },
      act: (bloc) async => bloc.add(AddNewRecentlySearchedWordEvent(newRecentlySearchedWord: tNewWordToAdd)),
      expect: [Empty(), Loading(), DictionaryWordSearchNewWordAddedState()],
    );
  });
}
