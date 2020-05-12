import 'package:dr_words/features/word_details/data/models/id_text_model.dart';
import 'package:dr_words/features/word_details/data/models/id_text_type_model.dart';
import 'package:dr_words/features/word_details/domain/entities/id_text.dart';
import 'package:dr_words/features/word_details/domain/entities/id_text_type.dart';
import 'package:dr_words/features/word_details/domain/entities/sense.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';

class SenseModel extends Sense {
  const SenseModel({
    List<IdText> domains,
    List<String> examples,
    List<IdTextType> notes,
    List<IdText> regions,
    List<IdText> registers,
    @required String text,
  }) : super(
          domains: domains,
          examples: examples,
          notes: notes,
          regions: regions,
          registers: registers,
          text: text,
        );

  factory SenseModel.fromFakeData({Map<String, dynamic> customFieldValues = const {}}) {
    final Map<String, dynamic> defaultFieldValues = {
      'domains': List<IdText>.generate(faker.randomGenerator.integer(10), (index) => IdTextModel.fromFakeData()),
      'examples': faker.lorem.words(faker.randomGenerator.integer(10)),
      'notes': List<IdTextType>.generate(faker.randomGenerator.integer(10), (index) => IdTextTypeModel.fromFakeData()),
      'regions': List<IdText>.generate(faker.randomGenerator.integer(10), (index) => IdTextModel.fromFakeData()),
      'registers': List<IdText>.generate(faker.randomGenerator.integer(10), (index) => IdTextModel.fromFakeData()),
      'text': faker.lorem.word(),
    };

    final domains = (customFieldValues['domains'] ?? defaultFieldValues['domains']) as List<IdText>;
    final examples = (customFieldValues['examples'] ?? defaultFieldValues['examples']) as List<String>;
    final notes = (customFieldValues['notes'] ?? defaultFieldValues['notes']) as List<IdTextType>;
    final regions = (customFieldValues['regions'] ?? defaultFieldValues['regions']) as List<IdText>;
    final registers = (customFieldValues['registers'] ?? defaultFieldValues['registers']) as List<IdText>;
    final text = (customFieldValues['text'] ?? defaultFieldValues['text']) as String;

    return SenseModel(
      domains: domains,
      examples: examples,
      notes: notes,
      regions: regions,
      registers: registers,
      text: text,
    );
  }
}
