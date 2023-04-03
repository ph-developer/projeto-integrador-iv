abstract class IMqttBroker {
  Future<void> connect(
    String connectionId,
    String host,
    int port,
    String username,
    String password,
  );
  Future<void> disconnect(String connectionId);
  Future<void> publish<T>(String connectionId, String topic, T value);
  Stream<T> subscribe<T>(String connectionId, String topic, T initial);
}
