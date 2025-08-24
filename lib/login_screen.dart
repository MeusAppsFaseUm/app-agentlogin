import 'package:flutter/material.dart';
// Importar para ImageFilter (efeito de vidro/blur)
import 'register_screen.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Dentro da classe _LoginScreenState em login_screen.dart
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));
      String email = _emailController.text;
      print('Tentando login com Email: $email');

      // SALVAR ESTADO DE LOGIN
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      print('Estado de login salvo: ${prefs.getBool('isLoggedIn')}');

      ScaffoldMessenger.of(context).showSnackBar( /* ... */
        SnackBar(
          content: Text('Login bem-sucedido! Bem-vindo(a), $email.'),
          backgroundColor: Colors.green[700], // Ou qualquer outra cor/estilo
        ),
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    }
    if (mounted && _isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
  }


// ... resto da classe _LoginScreenState ...


  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Color onGradientColor = Colors.white;
    final Color hintTextColor = Colors.white70;
    // final Color fieldBorderColor = Colors.white54; // Não estamos usando mais com BorderSide.none

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF005C78), // Um azul esverdeado um pouco mais escuro e profundo
              Color(0xFF00A7C5), // Um tom médio vibrante
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding:
            const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.diamond_outlined, // Ícone elegante
                    size: 80,
                    color: onGradientColor,
                    shadows: [
                      Shadow(
                        blurRadius: 15.0,
                        color: Colors.black.withOpacity(0.35),
                        offset: const Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    'Acesso Exclusivo',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: onGradientColor,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0), // Aumentei um pouco o espaço aqui

                  // Campo de Email
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: onGradientColor, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Seu email de acesso',
                      hintStyle: TextStyle(color: hintTextColor),
                      prefixIcon:
                      Icon(Icons.email_outlined, color: onGradientColor, size: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none, // Visual clean sem borda visível
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: onGradientColor, width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu email';
                      }
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),

                  // Campo de Senha
                  TextFormField(
                    controller: _passwordController,
                    style: TextStyle(color: onGradientColor, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Sua senha exclusiva',
                      hintStyle: TextStyle(color: hintTextColor),
                      prefixIcon:
                      Icon(Icons.lock_outline, color: onGradientColor, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: onGradientColor.withOpacity(0.7),
                          size: 20,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: onGradientColor, width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                    ),
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),

                  // Link "Esqueci minha senha"
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Recuperação de Senha (TODO)')),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Esqueceu a senha?',
                        style: TextStyle(
                          color: hintTextColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),

                  // Botão de Login
                  _isLoading
                      ? Center(
                      child: CircularProgressIndicator(color: onGradientColor))
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: onGradientColor.withOpacity(0.95), // Mais opaco para legibilidade
                      foregroundColor: const Color(0xFF005C78),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 8.0,
                      shadowColor: Colors.black.withOpacity(0.4),
                    ),
                    onPressed: _login,
                    child: const Text('ACESSAR CONTA'),
                  ),
                  const SizedBox(height: 25.0),

                  // Link para Registrar
                  // ... Dentro do método build() do login_screen.dart
                  // Link para Registrar - Discreto
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Novo por aqui? ',
                        style: TextStyle(color: hintTextColor, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: Text(
                          'Crie sua conta',
                          style: TextStyle(
                            color: onGradientColor, // Branco para destaque
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: onGradientColor,
                          ),
                        ),
                      ),
                    ],
                  ),
// ...
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
