import 'package:get/get.dart';
import 'package:social_wizard_app/lang/pt.dart';
import 'package:social_wizard_app/lang/sv.dart';
import 'de.dart';
import 'en_us.dart';
import 'es.dart';
import 'fr.dart';
import 'it.dart';



class TranslationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,  //English
    'fr_FR' : frFR, //French
    'es_ES' : esES, //Spanish
    'de_DE': deDE, //German
    'it_IT': itIT, //Italian
    'sv_SE': svSE, //Swedish
    'pt_BR': ptBR, //Portuguese
  };
}
