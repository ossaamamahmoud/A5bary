import 'package:a5bary/widgets/connectivity_aware_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.url});

  final String url;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                if (progress < 100) {
                  setState(() => isLoading = true);
                }
              },
              onPageStarted: (String url) {
                setState(() => isLoading = true);
              },
              onPageFinished: (String url) {
                setState(() => isLoading = false);
              },
              onWebResourceError: (WebResourceError error) {
                setState(() => isLoading = false);
                print("Web resource error: ${error.description}");
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityAwareWidget(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          forceMaterialTransparency: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: 23),
          ),
          title: const Text(
            "WebView Details",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: webViewController),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(color: Color(0xffF39E3B)),
              ),
          ],
        ),
      ),
    );
  }
}
