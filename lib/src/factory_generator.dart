import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:code_builder/code_builder.dart' as code;
import 'package:dart_style/dart_style.dart';
import 'package:kiwi/kiwi.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _injectTypeChecker = TypeChecker.fromRuntime(Inject);
const TypeChecker _namedTypeChecker = TypeChecker.fromRuntime(Named);

class FactoryGenerator extends Generator {
  const FactoryGenerator();

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final classes = library.classes.where((cls) =>
        (cls.unnamedConstructor != null) &&
        _injectTypeChecker.hasAnnotationOfExact(cls.unnamedConstructor));
    if (classes.isNotEmpty) {
      final file = code.Library(
        (lb) => lb..body.addAll(classes.map((cls) => _generateFactory(cls))),
      );

      final code.DartEmitter emitter = code.DartEmitter(code.Allocator());
      return DartFormatter().format('${file.accept(emitter)}');
    }
    return null;
  }

  code.Spec _generateFactory(ClassElement cls) {
    final className = cls.name;
    final factoryName = '\$${ReCase(className).camelCase}Factory';

    final constructorArgs = cls.unnamedConstructor.parameters.map((p) {
      final namedAnnotation = _namedTypeChecker.firstAnnotationOfExact(p);
      if (namedAnnotation != null) {
        var name = namedAnnotation.getField('name').toStringValue();
        return "c.resolve('$name')";
      }
      return 'c.resolve()';
    });

    final params = StringBuffer()
      ..writeAll(constructorArgs, ',')
      ..toString();

    return code.Code(
      'final $factoryName = (Container c) => $className($params);',
    );
  }
}
