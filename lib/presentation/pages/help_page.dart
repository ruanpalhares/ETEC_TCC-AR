import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Página de Ajuda'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Titulo',
                style: theme.textTheme.titleMedium,
              ),
            ),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer elementum'
              'nibh ut ligula iaculis laoreet. Nulla facilisi. Curabitur euismod eget mi ac mollis.'
              'Mauris ligula turpis, viverra vitae ultrices ut, tempus ac lacus. \nMauris lectus enim,'
              'imperdiet ut finibus et, commodo id enim. Sed vitae urna urna. Ut ac ultricies est.'
              'Phasellus tellus magna, finibus at odio sed, fermentum facilisis odio.',
              textAlign: TextAlign.justify,
            )
          ],
        ),
      )),
    );
  }
}
