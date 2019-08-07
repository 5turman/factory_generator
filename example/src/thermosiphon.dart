import 'package:kiwi/kiwi.dart';

import 'heater.dart';
import 'pump.dart';

part 'thermosiphon.g.dart';

class Thermosiphon implements Pump {
  static final factory = $thermosiphonFactory;

  final Heater _heater;

  @inject
  Thermosiphon(this._heater);

  @override
  void pump() {
    if (_heater.isHot) {
      print('=> => pumping => =>');
    }
  }
}
