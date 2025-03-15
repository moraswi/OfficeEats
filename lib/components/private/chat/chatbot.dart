import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatBot extends StatefulWidget {
  var routeName = '/chatbot';

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late IO.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    // _connectSocket();
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      String message = messageController.text.trim();
      setState(() {
        messages.add({"sender": "user", "message": message});
      });
      messageController.clear();
    }
  }

  Widget _buildMessageBubble(String message, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(color: isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('ChatBot', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/trackorder',
                  (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),

          Text('Hello! Our store manager will assist you shortly.', style: TextStyle(color: Colors.grey),),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(
                  messages[index]['message']!,
                  messages[index]['sender'] == 'user',
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey.shade200,
            child: Row(
              children: [

                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 100, // Set the max height you want for the TextField
                    ),
                    child: SingleChildScrollView(
                      child: TextField(
                        controller: messageController,
                        maxLines: null, // Allows the text to wrap into multiple lines
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.multiline, // Ensures the keyboard is suited for multiple lines
                      ),
                    ),
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.send, color: Colors.red),
                  onPressed: _sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
