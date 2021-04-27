import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:word_branches/presentation/routes/app_pages.dart';
import 'package:word_branches/presentation/views/lexical_entry/lexical_entry_view.dart';

import '../../../../../domain/word_search/entities/headword_entry.dart';
import '../../../../../domain/word_search/entities/lexical_entry.dart';

class LexicalEntryInformationPreviewCardViewModel extends BaseViewModel {
  late HeadwordEntry _headwordEntry;
  HeadwordEntry get headwordEntry => _headwordEntry;

  late LexicalEntry _lexicalEntry;
  LexicalEntry get lexicalEntry => _lexicalEntry;

  late int _headwordEntryNumber;
  int get headwordEntryNumber => _headwordEntryNumber;

  void initialise({
    required HeadwordEntry initialHeadwordEntry,
    required LexicalEntry initialLexicalEntry,
    required int initialHeadwordEntryNumber,
  }) {
    _headwordEntry = initialHeadwordEntry;
    _lexicalEntry = initialLexicalEntry;
    _headwordEntryNumber = initialHeadwordEntryNumber;
    notifyListeners();
  }

  Future navigateToLexicalEntryView() async {
    await Get.toNamed(
      Routes.lexicalEntryView,
      arguments: LexicalEntryViewRouteArgs(
        headwordEntry: _headwordEntry,
        lexicalEntry: _lexicalEntry,
        headwordEntryNumber: _headwordEntryNumber,
      ),
    );
  }
}