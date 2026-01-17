import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../utils/constants.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final StreamController<Map<String, dynamic>> _controller = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get stream => _controller.stream;

  void connect() {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(AppConstants.wsUrl));

      _channel!.stream.listen(
            (message) {
          final data = json.decode(message);
          _controller.add(data);
        },
        onError: (error) {
          print('WebSocket Error: $error');
          _reconnect();
        },
        onDone: () {
          print('WebSocket Connection Closed');
          _reconnect();
        },
      );
    } catch (e) {
      print('WebSocket Connection Exception: $e');
    }
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 5), () {
      connect();
    });
  }

  void disconnect() {
    _channel?.sink.close();
    // Don't close _controller if you want to reuse the service
  }
}