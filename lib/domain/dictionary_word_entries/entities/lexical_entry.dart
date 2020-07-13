import 'package:dr_words/domain/dictionary_word_entries/entities/entry.dart';
import 'package:dr_words/domain/dictionary_word_entries/entities/pronunciation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

part 'lexical_entry.freezed.dart';

@freezed
abstract class LexicalEntry with _$LexicalEntry {
  const factory LexicalEntry({
    @required KtList<Entry> entries,
    @required String lexicalCategory,
  }) = _LexicalEntry;
}
