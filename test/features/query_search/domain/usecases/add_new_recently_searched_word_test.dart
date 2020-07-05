import 'package:dartz/dartz.dart';
import 'package:dr_words/core/domain/entities/dictionary_word.dart';
import 'package:dr_words/features/query_search/domain/repositories/query_search_repository.dart';
import 'package:dr_words/features/query_search/domain/usecases/add_new_recently_searched_word/add_new_recently_searched_word.dart';
import 'package:dr_words/features/query_search/domain/usecases/add_new_recently_searched_word/add_new_recently_searched_word_impl.dart';
import 'package:dr_words/injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AddNewRecentlySearchedWord usecase;
  DictionaryWordSearchRepository mockDictionaryWordSearchRepository;

  setUpAll(() async {
    await configureInjection(Env.test);
  });

  setUp(() {
    mockDictionaryWordSearchRepository = getIt<DictionaryWordSearchRepository>();
    usecase = getIt<AddNewRecentlySearchedWordImpl>();
  });

  final tNewWordToAdd = DictionaryWord.fromFakeData();

  test('should return Right(true) when new recently searched word is successfully added to the repository', () async {
    // arrange
    when(mockDictionaryWordSearchRepository.addNewRecentlySearchedWord(tNewWordToAdd))
        .thenAnswer((_) async => const Right(true));

    // act
    final result = await usecase(Params(newWordToAdd: tNewWordToAdd));

    // assert
    expect(result, const Right(true));
    verify(mockDictionaryWordSearchRepository.addNewRecentlySearchedWord(tNewWordToAdd));
    verifyNoMoreInteractions(mockDictionaryWordSearchRepository);
  });
}
