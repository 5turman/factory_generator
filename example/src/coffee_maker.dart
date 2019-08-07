import 'package:kiwi/kiwi.dart';

import '../coffee_app.dart';
import 'heater.dart';
import 'pump.dart';

part 'coffee_maker.g.dart';

class CoffeeMaker {
  static final factory = $coffeeMakerFactory;

  final Heater _heater;
  final Pump _pump;
  final String _model;
  final String _brand;

  @inject
  CoffeeMaker(
    this._heater,
    this._pump,
    @Named(brandName) this._brand,
    @Named(modelName) this._model,
  );

  void brew() {
    _heater.on();
    _pump.pump();
    print('Your coffee is ready!');
    print('Thanks for using $_model by $_brand');
    _heater.off();
  }
}
