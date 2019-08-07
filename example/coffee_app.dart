import 'package:kiwi/kiwi.dart';

import 'src/coffee_maker.dart';
import 'src/electric_heater.dart';
import 'src/heater.dart';
import 'src/pump.dart';
import 'src/thermosiphon.dart';

const brandName = 'brand';
const modelName = 'model';

main() {
  final container = Container();
  container.registerInstance('Coffee by Dart Inc.', name: brandName);
  container.registerInstance('DripCoffeeStandard', name: modelName);
  container.registerSingleton<Heater>(ElectricHeater.factory);
  container.registerSingleton<Pump>(Thermosiphon.factory);
  container.registerSingleton(CoffeeMaker.factory);

  container.resolve<CoffeeMaker>().brew();
}
