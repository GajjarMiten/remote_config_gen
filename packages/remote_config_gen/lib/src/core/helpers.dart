import 'package:remote_config_gen/src/core/constants.dart';
import 'package:remote_config_gen/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';


String getClassName(ConstantReader annotation) {
  return annotation.objectValue.getField('className')?.toStringValue() ??
      defaultClassName;
}

String getVariableTamplate(FieldMeta meta) {
  final annotedType = meta.annotedType.toString();
  final remoteType =
      annotedType.substring(0, 1).toUpperCase() + annotedType.substring(1);

  return 'static  ${meta.annotedType.toString()} get ${meta.variableName} =>  _remoteConfig.get$remoteType("${meta.value}");';
}
