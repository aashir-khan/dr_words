// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'lexical_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LexicalEntryTearOff {
  const _$LexicalEntryTearOff();

  _LexicalEntry call(
      {required KtList<Entry> entries,
      required IdText lexicalCategory,
      KtList<Pronunciation>? pronunciations,
      KtList<RelatedEntry>? derivativeOf}) {
    return _LexicalEntry(
      entries: entries,
      lexicalCategory: lexicalCategory,
      pronunciations: pronunciations,
      derivativeOf: derivativeOf,
    );
  }
}

/// @nodoc
const $LexicalEntry = _$LexicalEntryTearOff();

/// @nodoc
mixin _$LexicalEntry {
  KtList<Entry> get entries => throw _privateConstructorUsedError;
  IdText get lexicalCategory => throw _privateConstructorUsedError;
  KtList<Pronunciation>? get pronunciations =>
      throw _privateConstructorUsedError;
  KtList<RelatedEntry>? get derivativeOf => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LexicalEntryCopyWith<LexicalEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LexicalEntryCopyWith<$Res> {
  factory $LexicalEntryCopyWith(
          LexicalEntry value, $Res Function(LexicalEntry) then) =
      _$LexicalEntryCopyWithImpl<$Res>;
  $Res call(
      {KtList<Entry> entries,
      IdText lexicalCategory,
      KtList<Pronunciation>? pronunciations,
      KtList<RelatedEntry>? derivativeOf});

  $IdTextCopyWith<$Res> get lexicalCategory;
}

/// @nodoc
class _$LexicalEntryCopyWithImpl<$Res> implements $LexicalEntryCopyWith<$Res> {
  _$LexicalEntryCopyWithImpl(this._value, this._then);

  final LexicalEntry _value;
  // ignore: unused_field
  final $Res Function(LexicalEntry) _then;

  @override
  $Res call({
    Object? entries = freezed,
    Object? lexicalCategory = freezed,
    Object? pronunciations = freezed,
    Object? derivativeOf = freezed,
  }) {
    return _then(_value.copyWith(
      entries: entries == freezed
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as KtList<Entry>,
      lexicalCategory: lexicalCategory == freezed
          ? _value.lexicalCategory
          : lexicalCategory // ignore: cast_nullable_to_non_nullable
              as IdText,
      pronunciations: pronunciations == freezed
          ? _value.pronunciations
          : pronunciations // ignore: cast_nullable_to_non_nullable
              as KtList<Pronunciation>?,
      derivativeOf: derivativeOf == freezed
          ? _value.derivativeOf
          : derivativeOf // ignore: cast_nullable_to_non_nullable
              as KtList<RelatedEntry>?,
    ));
  }

  @override
  $IdTextCopyWith<$Res> get lexicalCategory {
    return $IdTextCopyWith<$Res>(_value.lexicalCategory, (value) {
      return _then(_value.copyWith(lexicalCategory: value));
    });
  }
}

/// @nodoc
abstract class _$LexicalEntryCopyWith<$Res>
    implements $LexicalEntryCopyWith<$Res> {
  factory _$LexicalEntryCopyWith(
          _LexicalEntry value, $Res Function(_LexicalEntry) then) =
      __$LexicalEntryCopyWithImpl<$Res>;
  @override
  $Res call(
      {KtList<Entry> entries,
      IdText lexicalCategory,
      KtList<Pronunciation>? pronunciations,
      KtList<RelatedEntry>? derivativeOf});

  @override
  $IdTextCopyWith<$Res> get lexicalCategory;
}

/// @nodoc
class __$LexicalEntryCopyWithImpl<$Res> extends _$LexicalEntryCopyWithImpl<$Res>
    implements _$LexicalEntryCopyWith<$Res> {
  __$LexicalEntryCopyWithImpl(
      _LexicalEntry _value, $Res Function(_LexicalEntry) _then)
      : super(_value, (v) => _then(v as _LexicalEntry));

  @override
  _LexicalEntry get _value => super._value as _LexicalEntry;

  @override
  $Res call({
    Object? entries = freezed,
    Object? lexicalCategory = freezed,
    Object? pronunciations = freezed,
    Object? derivativeOf = freezed,
  }) {
    return _then(_LexicalEntry(
      entries: entries == freezed
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as KtList<Entry>,
      lexicalCategory: lexicalCategory == freezed
          ? _value.lexicalCategory
          : lexicalCategory // ignore: cast_nullable_to_non_nullable
              as IdText,
      pronunciations: pronunciations == freezed
          ? _value.pronunciations
          : pronunciations // ignore: cast_nullable_to_non_nullable
              as KtList<Pronunciation>?,
      derivativeOf: derivativeOf == freezed
          ? _value.derivativeOf
          : derivativeOf // ignore: cast_nullable_to_non_nullable
              as KtList<RelatedEntry>?,
    ));
  }
}

/// @nodoc

class _$_LexicalEntry implements _LexicalEntry {
  const _$_LexicalEntry(
      {required this.entries,
      required this.lexicalCategory,
      this.pronunciations,
      this.derivativeOf});

  @override
  final KtList<Entry> entries;
  @override
  final IdText lexicalCategory;
  @override
  final KtList<Pronunciation>? pronunciations;
  @override
  final KtList<RelatedEntry>? derivativeOf;

  @override
  String toString() {
    return 'LexicalEntry(entries: $entries, lexicalCategory: $lexicalCategory, pronunciations: $pronunciations, derivativeOf: $derivativeOf)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LexicalEntry &&
            (identical(other.entries, entries) ||
                const DeepCollectionEquality()
                    .equals(other.entries, entries)) &&
            (identical(other.lexicalCategory, lexicalCategory) ||
                const DeepCollectionEquality()
                    .equals(other.lexicalCategory, lexicalCategory)) &&
            (identical(other.pronunciations, pronunciations) ||
                const DeepCollectionEquality()
                    .equals(other.pronunciations, pronunciations)) &&
            (identical(other.derivativeOf, derivativeOf) ||
                const DeepCollectionEquality()
                    .equals(other.derivativeOf, derivativeOf)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(entries) ^
      const DeepCollectionEquality().hash(lexicalCategory) ^
      const DeepCollectionEquality().hash(pronunciations) ^
      const DeepCollectionEquality().hash(derivativeOf);

  @JsonKey(ignore: true)
  @override
  _$LexicalEntryCopyWith<_LexicalEntry> get copyWith =>
      __$LexicalEntryCopyWithImpl<_LexicalEntry>(this, _$identity);
}

abstract class _LexicalEntry implements LexicalEntry {
  const factory _LexicalEntry(
      {required KtList<Entry> entries,
      required IdText lexicalCategory,
      KtList<Pronunciation>? pronunciations,
      KtList<RelatedEntry>? derivativeOf}) = _$_LexicalEntry;

  @override
  KtList<Entry> get entries => throw _privateConstructorUsedError;
  @override
  IdText get lexicalCategory => throw _privateConstructorUsedError;
  @override
  KtList<Pronunciation>? get pronunciations =>
      throw _privateConstructorUsedError;
  @override
  KtList<RelatedEntry>? get derivativeOf => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LexicalEntryCopyWith<_LexicalEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
