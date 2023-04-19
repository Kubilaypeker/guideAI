import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/chatMessages.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:async/async.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessages> _chatMessages = [];
  final openAI = OpenAI.instance.build(token: "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", isLog: true);



  Future<void> sendMessage() async {
    ChatMessages newMessage = ChatMessages(message: _messageController.text, sender: "Kullanıcı");

    final request = CompleteText(prompt:_messageController.text,
      model: Model.textDavinci3,);

    final response = await openAI.onCompletion(request:request);

    setState(() {
      _chatMessages.insert(0, newMessage);
      _chatMessages.insert(0, ChatMessages(message: response!.choices[0].text, sender: "OpenAI"));
      _messageController.clear();
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff383737),
      appBar: AppBar(
        backgroundColor: const Color(0xff383737),
        title: Text("Guide AI", style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _chatMessages.length,
                    itemBuilder: (context, index) {
                      return _chatMessages[index];
                    }
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: _messageController,
                        onFieldSubmitted: (value) {
                          sendMessage();
                          },
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ask me anything..",
                          hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500)
                        ),
                      ),
                    ),
                    ),
                    IconButton(onPressed: () {
                      if(_messageController != null) {
                        sendMessage();
                      }
                    },
                        icon: const Icon(Icons.send_sharp,)
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
