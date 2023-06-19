// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:remote_config_gen_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  final _coreChecker = const TypeChecker.fromRuntime(remoteValueType);
  final fields = <String, FieldMeta>{};

  @override
  void visitFieldElement(FieldElement element) {
    final elementType = element.type.toString();

    final hasAnnotation = _coreChecker.hasAnnotationOf(element);

    final fieldMeta = <String, dynamic>{};

    if (hasAnnotation) {
      final paramterizedType =
          _coreChecker.firstAnnotationOf(element)?.type as ParameterizedType;
      fieldMeta['annotedType'] = paramterizedType.typeArguments.first;
    }

    fieldMeta['type'] = elementType.replaceFirst('*', '');
    fieldMeta['value'] = element.computeConstantValue()?.toStringValue();
    fieldMeta['variableName'] = element.name;

    fields[element.name] = FieldMeta.fromMap(fieldMeta);
  }
}

class FieldMeta {
  final DartType annotedType;
  final String type;
  final String value;
  final String variableName;
  FieldMeta({
    required this.annotedType,
    required this.type,
    required this.value,
    required this.variableName,
  });

  factory FieldMeta.fromMap(Map<String, dynamic> map) {
    return FieldMeta(
      annotedType: map['annotedType'],
      type: map['type'] as String,
      value: map['value'] as String,
      variableName: map['variableName'] as String
    );
  }
}
