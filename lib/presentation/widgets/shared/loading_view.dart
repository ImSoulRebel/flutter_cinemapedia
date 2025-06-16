import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<String> getLoadingMessages() {
      List<String> messages = [
        'Cargando peliculas',
        'Ya casi lo tenemos',
        'Prepara las palomitas',
        'Esto está tardando más de lo esperado...',
      ];
      return Stream.periodic(
        Duration(milliseconds: 1600),
        (step) => messages[step],
      ).take(messages.length);
    }

    return StreamBuilder(
      stream: getLoadingMessages(),
      builder:
          (BuildContext context, AsyncSnapshot<dynamic> snapshot) => SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Text('Espere por favor'),
                CircularProgressIndicator(),
                Text(snapshot.hasData ? snapshot.data : 'Cargando...'),
              ],
            ),
          ),
    );
  }
}
