library build_test;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/factory_generator.dart';

Builder factoryGeneratorBuilder([BuilderOptions options]) {
  return SharedPartBuilder(const [
    FactoryGenerator(),
  ], 'kiwi');
}
