import 'package:build/build.dart';
import 'package:remote_config_gen/src/remote_value_generator.dart';

import 'package:source_gen/source_gen.dart';

Builder generateRemoteConfigValue(BuilderOptions options) =>
    SharedPartBuilder([RemoteValueGenerator()], 'remote_value_gen');
