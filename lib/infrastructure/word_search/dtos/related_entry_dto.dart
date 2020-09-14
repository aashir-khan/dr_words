import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/word_search/entities/related_entry.dart';

part 'related_entry_dto.freezed.dart';
part 'related_entry_dto.g.dart';

@freezed
abstract class RelatedEntryDto with _$RelatedEntryDto {
  const factory RelatedEntryDto({
    @required String id,
    @required String text,
  }) = _RelatedEntryDto;

  factory RelatedEntryDto.fromDomain(RelatedEntry relatedEntry) {
    return RelatedEntryDto(
      id: relatedEntry.id,
      text: relatedEntry.text,
    );
  }

  factory RelatedEntryDto.fromJson(Map<String, dynamic> json) => _$RelatedEntryDtoFromJson(json);

  factory RelatedEntryDto.fromFakeData({Map<String, dynamic> customFieldValues = const {}}) {
    final defaultText = faker.lorem.word();

    final _id = customFieldValues['id'] as String;
    final _text = customFieldValues['text'] as String;

    return RelatedEntryDto(
      id: _id ?? defaultText,
      text: _text ?? defaultText,
    );
  }
}

extension RelatedEntryDtoX on RelatedEntryDto {
  RelatedEntry toDomain() {
    return RelatedEntry(
      id: id,
      text: text,
    );
  }
}