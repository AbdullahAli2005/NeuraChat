class Message {
  String message;
  final MessageType messageType;

  Message({required this.message, required this.messageType});
}

enum MessageType { user, bot }
