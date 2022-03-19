import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receipe/providers/allreceipe_providers.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String link;
  WebViewWidget(this.link);

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  double progress = 0.0;
  // late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info),
            SizedBox(width: 10),
            Text('Web View'),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          LinearProgressIndicator(
            color: Colors.red,
            value: progress,
          ),
          Expanded(
            child: WebView(
              // onWebViewCreated: (controller) {
              //   this.controller = controller;
              // },
              initialUrl: widget.link,
              javascriptMode: JavascriptMode.unrestricted,
              onProgress: (val) {
                setState(() {
                  print(val);
                  progress = val / 10;
                });
              },
            ),
          ),
          // FloatingActionButton(
          //   onPressed: () async {
          //     controller.evaluateJavascript(
          //         "document.getElementsTagName('header')[0].style.display='none'");
          //     controller.evaluateJavascript(
          //         "document.getElementsTagName('footer')[0].style.display='none'");
          //   },
          //   child: Icon(
          //     Icons.remove,
          //     size: 35,
          //   ),
          // ),
        ],
      )),
    );
  }
}
