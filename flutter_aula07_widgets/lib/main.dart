
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

import 'widgets/meu_info_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aula07 - Widgets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool widgetCriado = false;

  Future<void> atualizarWidgetExterno() async {
    try {
      // Salva as informações que serão exibidas no widget externo.
      await HomeWidget.saveWidgetData<String>(
        'chave_texto',
        'Minha Ideia',
      );

      await HomeWidget.saveWidgetData<String>(
        'chave_imagem',
        'https://github.com/wellifabio/senai2026/blob/main/ds/turmas/2DES_A/4%C2%BA%20Semestre/03-ppdm2/aula07/icone.png?raw=true',
      );

      // Atualiza o Home Screen Widget.
      await HomeWidget.updateWidget(
        name: 'MeuHomeWidget',
      );

      // Solicita a inclusão do widget na tela inicial.
      await HomeWidget.requestPinWidget(
        name: 'MeuHomeWidget',
        androidName: 'MeuHomeWidget',
        qualifiedAndroidName:
            'com.example.flutter_aula07_widgets.MeuHomeWidget',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Solicitação de criação do widget enviada!',
          ),
        ),
      );
    } on PlatformException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao criar widget: ${e.message ?? e.code}',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro inesperado: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aula07 - Widgets'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            Image.asset(
              'assets/icone.png',
              width: 130,
              height: 130,
            ),

            const SizedBox(height: 15),

            const Text(
              'Aprendendo Flutter!',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Conhecendo widgets personalizados '
                'e widgets para a tela inicial.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),

            const Divider(),

            const SizedBox(height: 10),

            const Text(
              'Widget Personalizado',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  widgetCriado = !widgetCriado;
                });
              },
              child: Text(
                widgetCriado
                    ? 'Ocultar widget'
                    : 'Criar widget personalizado',
              ),
            ),

            if (widgetCriado)
              const MeuInfoWidget(
                titulo: 'Minha informação',
                informacao:
                    'Este é um widget personalizado criado '
                    'utilizando StatelessWidget!',
              ),

            const SizedBox(height: 15),

            const Divider(),

            const SizedBox(height: 10),

            const Text(
              'Home Screen Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Adicione uma informação diretamente '
                'na tela inicial do seu celular.',
                textAlign: TextAlign.center,
              ),
            ),

            ElevatedButton.icon(
              onPressed: atualizarWidgetExterno,
              icon: const Icon(Icons.widgets),
              label: const Text('Criar Home Screen Widget'),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
