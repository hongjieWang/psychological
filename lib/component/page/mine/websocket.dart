import 'dart:ffi';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:standard_app/model/proto/reply_body.pb.dart';
import 'package:standard_app/util/protobuf_util.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MyHomePage extends StatefulWidget {
  final WebSocketChannel channel =
      new IOWebSocketChannel.connect('ws://192.168.2.167:34567');

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("websoket"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Form(
              child: new TextFormField(
                controller: _controller,
                decoration: new InputDecoration(labelText: 'Send a message'),
              ),
            ),
            new StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                print(ProtobufUtil.decode(snapshot.data).tojson());
                return new Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: new Text(snapshot.hasData
                      ? '${ProtobufUtil.decode(snapshot.data).tojson()}'
                      : ''),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: new Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    SentBodyProto send = SentBodyProto();
    send.key = "client_bind";
    send.timestamp = Int64(DateTime.now().microsecond);
    send.data.addAll({
      "account": "account",
      "channel": "1qa2wsx",
      "appVersion": "1.0.2",
      "osVersion": "1.0",
      "packageName": "",
      "deviceId": "wedfrfvft"
    });
    widget.channel.sink.add(ProtobufUtil.encode(send));
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
