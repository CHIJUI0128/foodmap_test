import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<File?> _loadSharedImage() async {
    final container = await getApplicationSupportDirectory();
    final appGroupPath = "/private/var/mobile/Containers/Shared/AppGroup/YOUR.APP.GROUP/SharedImage.jpg";
    final file = File(appGroupPath);
    return file.existsSync() ? file : null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('接收分享圖片')),
        body: FutureBuilder<File?>(
          future: _loadSharedImage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return Center(child: CircularProgressIndicator());
            if (snapshot.hasData && snapshot.data != null) {
              return Image.file(snapshot.data!);
            }
            return Center(child: Text('尚未收到圖片'));
          },
        ),
      ),
    );
  }
}