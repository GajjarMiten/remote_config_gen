class _RemoteValue<T> {
  const _RemoteValue();
}

const remoteValueType = _RemoteValue;

const remoteBool = _RemoteValue<bool>();

const remoteString = _RemoteValue<String>();
const remoteNum = _RemoteValue<num>();
const remoteInt = _RemoteValue<int>();
const remoteDouble = _RemoteValue<double>();
const remoteJson = _RemoteValue<Map>();
