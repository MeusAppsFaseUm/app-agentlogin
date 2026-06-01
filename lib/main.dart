// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    debugPrint('[main.dart] Status de login lido na inicialização: $loggedInStatus');

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
          backgroundColor: Color(0xFF070A0F),
          body: Center(
            child: CircularProgressIndicator(
              // Você pode estilizar isso para combinar com seu app
              color: Color(0xFFE5C158), // Dourado Champagne
            ),
          ),
        ),
      );
    }

    // Após verificar, decida qual tela mostrar
    return MaterialApp(
      title: 'Acesso Exclusivo Agent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE5C158),
          brightness: Brightness.dark,
          primary: const Color(0xFFE5C158),
          surface: const Color(0xFF12161F),
        ),
        scaffoldBackgroundColor: const Color(0xFF070A0F),
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: _isLoggedIn ? const HomeScreen() : const LoginScreen(), // DECISÃO CRÍTICA AQUI
    );
  }
}
