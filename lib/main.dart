// main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart'; // Importa a sua tela de login
import 'home_screen.dart'; // Importa a sua tela inicial após o login

void main() {
  // Opcional, mas pode ser útil se houver problemas com plugins antes de runApp
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget { // DEVE SER StatefulWidget
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  bool _isLoading = true; // Para mostrar um indicador enquanto verifica o login

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // Lê o estado de login. Se não houver nada, assume false.
    bool loggedInStatus = prefs.getBool('isLoggedIn') ?? false;

    // ADICIONE ESTE PRINT PARA DEPURAR
    print('[main.dart] Status de login lido na inicialização: $loggedInStatus');

    if (mounted) { // Verifica se o widget ainda está na árvore antes de chamar setState
      setState(() {
        _isLoggedIn = loggedInStatus;
        _isLoading = false; // Terminou de verificar, pode construir a UI principal
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Enquanto estiver verificando o estado de login, mostre um indicador de carregamento
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              // Você pode estilizar isso para combinar com seu app
              color: Color(0xFF005C78), // Usando sua cor semente
            ),
          ),
        ),
      );
    }

    // Após verificar, decida qual tela mostrar
    return MaterialApp(
      title: 'App de Luxo Login', // Ou o título que preferir
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF005C78),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: _isLoggedIn ? const HomeScreen() : const LoginScreen(), // DECISÃO CRÍTICA AQUI
    );
  }
}
