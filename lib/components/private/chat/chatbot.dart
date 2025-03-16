import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../http/storeApiService.dart';

class ChatBot extends StatefulWidget {
  var routeName = '/chatbot';

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final StoreApiService storeService = StoreApiService();

  TextEditingController messageController = TextEditingController();
  // List<Map<String, String>> messages = [];
  List<Map<String, dynamic>> messages = [];

  int getStoreId = 0;
  int getOrderId = 0;
  int getUserId = 0;
  String getMessage = "";

  @override
  void initState() {
    super.initState();
    getSharedPreferenceData();
  }

  // getSharedPreferenceData
  Future<void> getSharedPreferenceData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      getStoreId = prefs.getInt('storeId') ?? 0;
      getOrderId = prefs.getInt('orderId') ?? 0;
      getUserId = prefs.getInt('userId') ?? 0;
    });

    // getChatBotMessage
    getChatBotMessage();
  }

  // sendMessage
  Future<void> sendMessage() async {
    try {
      if (messageController.text.isNotEmpty) {
        getMessage = messageController.text.trim();

        // Check if the message contains contact details
        if (containsContactInfo(getMessage)) {
          print("Message contains restricted information.");
          _showWarning("You cannot share personal contact details.");

          return;
        }

        await storeService.addChatbotMessageReq(
            getUserId, getMessage, getOrderId, getStoreId);

        setState(() {
          messages.add({"sender": "user", "message": getMessage});
        });
        messageController.clear();

        getChatBotMessage();
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to check for contact details
  bool containsContactInfo(String message) {
    final phoneRegex = RegExp(r'\b(\+?\d{1,3}[-.\s]?)?(\d{2,4}[-.\s]?){2,4}\d\b');
    final emailRegex = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b');

    return phoneRegex.hasMatch(message) || emailRegex.hasMatch(message);
  }
// Function to show warning message
  void _showWarning(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
  // getChatBotMessage
  Future<void> getChatBotMessage() async {
    try {
      var results = await storeService.getChatbotMessagesReq(getOrderId);

      print("Order ID: $getOrderId");
      print("Results: $results");

      if (results != null) {
        List<dynamic> jsonData = jsonDecode(results.body); // Parse JSON
        setState(() {
          messages = jsonData.map((msg) => {
            'message': msg['message'],
            'userId': msg['userId'],
          }).toList();
        });}
    } catch (e) {
      print("Error fetching chatbot messages: $e");
    }
  }

  // Widget _buildMessageBubble(String message, bool isUser) {
  //   return Align(
  //     alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  //       padding: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: isUser ? Colors.blue : Colors.grey.shade300,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Text(
  //         message,
  //         style: TextStyle(color: isUser ? Colors.white : Colors.black),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'ChatBot',
          style: TextStyle(color: Colors.white),
        ),
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
          const Text(
            'Hello! Our store manager will assist you shortly.',
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            "Please don't share personal details.",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isCurrentUser = messages[index]['userId'] == getUserId;

                return Align(
                  alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isCurrentUser ? Colors.blue : Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      messages[index]['message'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
                      maxHeight:
                          100, // Set the max height you want for the TextField
                    ),
                    child: SingleChildScrollView(
                      child: TextField(
                        controller: messageController,
                        maxLines: null,
                        // Allows the text to wrap into multiple lines
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType
                            .multiline, // Ensures the keyboard is suited for multiple lines
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.red),
                  onPressed: sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
