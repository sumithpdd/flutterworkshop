// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foocafe_flutter_firebase_chat/data/data.dart';
import 'package:foocafe_flutter_firebase_chat/helpers/app_constants.dart';
import 'package:foocafe_flutter_firebase_chat/helpers/constants.dart';
import 'package:foocafe_flutter_firebase_chat/models/message.dart';
import 'package:flutter/material.dart';
import 'package:foocafe_flutter_firebase_chat/services/database_service.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String? currentUserId;

  final String? toUserId;

  const ChatScreen({this.currentUserId, this.toUserId, Key? key})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textMessageController = TextEditingController();
  bool _isComposing = false;

  late DatabaseService _dataBaseService;
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _dataBaseService = Provider.of<DatabaseService>(context, listen: false);
    _setupMessages();
  }

  _setupMessages() async {
    List<Message> messages = await _dataBaseService.getChatMessages(
        widget.currentUserId!, widget.toUserId!);
    setState(() {
      _messages = messages;
    });
  }

  _buildMessage(Message message, bool isMe) {
    final Widget msg = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: isMe
            ? const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 80.0,
              )
            : const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: isMe
              ? AppConstants.hexToColor(AppConstants.APP_PRIMARY_TILE_COLOR)
              : AppConstants.hexToColor(
                  AppConstants.APP_BACKGROUND_COLOR_WHITE),
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.text!,
              style: TextStyle(
                color: isMe ? Colors.white60 : Colors.blueGrey,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  timeFormat.format(message.timestamp!.toDate()),
                  style: TextStyle(
                    color: isMe
                        ? AppConstants.hexToColor(
                            AppConstants.APP_PRIMARY_COLOR_GREEN)
                        : AppConstants.hexToColor(
                            AppConstants.APP_BACKGROUND_COLOR_GRAY),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Row(
      children: <Widget>[msg],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: AppConstants.hexToColor(AppConstants.APP_BACKGROUND_COLOR_WHITE),
      child: Row(
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            child: Icon(
              Icons.camera_alt,
              color: AppConstants.hexToColor(
                  AppConstants.APP_BACKGROUND_COLOR_GRAY),
              size: 25.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(15.0),
          ),
          Expanded(
            child: TextField(
              controller: _textMessageController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                hintText: 'Type your message...',
                filled: true,
                hintStyle: TextStyle(
                    color: AppConstants.hexToColor(
                        AppConstants.APP_PRIMARY_FONT_COLOR_LIGHT)),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            color:
                AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR_ACTION),
            onPressed: _isComposing
                ? () => _handleSubmitted(_textMessageController.text)
                : null,
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textMessageController.clear();

    setState(() {
      _isComposing = false;
    });

    Message message = Message(
      senderId: widget.currentUserId,
      toUserId: widget.toUserId,
      timestamp: Timestamp.fromDate(DateTime.now()),
      text: text,
      isLiked: true,
      unread: true,
    );

    setState(() {
      _messages.insert(0, message);
    });

    _dataBaseService.sendChatMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chats")),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.only(top: 15.0),
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final Message message = _messages[index];
                  final bool isMe = message.senderId == widget.currentUserId;
                  return _buildMessage(message, isMe);
                },
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
