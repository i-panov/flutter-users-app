import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkProxyImage extends StatelessWidget {
  final String src;

  NetworkProxyImage({required this.src});

  Future<http.Response> _fetch() async {
    return await http.get(Uri(
        scheme: 'https',
        host: 'api.allorigins.win',
        path: '/raw',
        queryParameters: {
          'url': src,
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _fetch(), builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
      if (!snapshot.hasData) {
        return Container();
      }

      return Image.memory(snapshot.data!.bodyBytes);
    });
  }
}
