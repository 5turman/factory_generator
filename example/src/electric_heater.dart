import 'package:kiwi/kiwi.dart';

import 'heater.dart';

part 'electric_heater.g.dart';

class ElectricHeater implements Heater {
  @inject
  ElectricHeater();

  bool _heating = false;

  @override
  void on() {
    print('~ ~ ~ heating ~ ~ ~');
    _heating = true;
  }

  @override
  void off() {
    _heating = false;
  }

  @override
  bool get isHot => _heating;

  static final factory = $electricHeaterFactory;
}
