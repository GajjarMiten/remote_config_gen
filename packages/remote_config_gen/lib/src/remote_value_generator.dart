import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:remote_config_gen/src/core/helpers.dart';
import 'package:remote_config_gen/src/model_visitor.dart';
import 'package:remote_config_gen_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class RemoteValueGenerator extends GeneratorForAnnotation<RemoteValueClass> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();

    element.visitChildren(visitor);

    final className = getClassName(annotation);

    final classBuffer = StringBuffer();

    classBuffer.writeln('class $className  {');
    classBuffer.writeln('$className._();');
    classBuffer
        .writeln('static final _remoteConfig = FirebaseRemoteConfig.instance;');

    for (final field in visitor.fields.keys) {
      final fieldMeta = visitor.fields[field];
      if (fieldMeta == null) continue;

      classBuffer.writeln(getVariableTamplate(fieldMeta));
    }
    classBuffer.writeln('}');

    return classBuffer.toString();
  }
}
