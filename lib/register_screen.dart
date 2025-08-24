// register_screen.dart

import 'package:flutter/material.dart';
// import 'home_screen.dart'; // Se tiver

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // SEÇÃO DE VARIÁVEIS DE ESTADO (CORRETA)
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  bool _isLoading = false;
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  // MÉTODO dispose() (CORRETO)
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // MÉTODO _register() (CORRIGIDO)
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulação de uma chamada de API/registro
      await Future.delayed(const Duration(seconds: 2));

      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      print(
          'Tentando registrar com Nome: $name, Email: $email, Senha: $password');

      // TODO: Lógica de registro real

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Registro de $name bem-sucedido! Faça login para continuar.')),
      );

      if (mounted) {
        Navigator.pop(
            context); // Volta para a tela anterior (login)
      }

      // NENHUMA DUPLICAÇÃO AQUI

      // O setState para _isLoading = false deve estar AQUI, após a lógica assíncrona
      // e antes do final da validação do form.
    }
    // E se a validação do form falhar, ou após a lógica de registro bem sucedida,
    // o _isLoading precisa voltar para false.
    // É importante que este setState seja chamado INDEPENDENTEMENTE se a validação
    // passou ou não, mas somente após a lógica assíncrona ter terminado SE A VALIDAÇÃO PASSOU.
    // A melhor prática é colocar dentro do if APÓS o await.
    if (mounted) { // Garante que o widget ainda existe
      setState(() {
        _isLoading = false;
      });
    }
  }

  // MÉTODOS _togglePasswordVisibility() e _toggleConfirmPasswordVisibility() (CORRETOS)
  void _togglePasswordVisibility() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  // MÉTODO build() (SEU CÓDIGO DO BUILD ESTÁ CORRETO E DEVE VIR AQUI)
  @override
  Widget build(BuildContext context) {
    // ... seu código do método build() que você colou está correto ...
    // ... e deve continuar a partir daqui até o final da classe.
    final textTheme = Theme.of(context).textTheme;
    final Color onGradientColor = Colors.white;
    final Color hintTextColor = Colors.white70;

    return Scaffold(
      body: Container(
        // ... continua como no seu código ...
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF005C78), // Azul esverdeado escuro
              Color(0xFF00A7C5), // Azul esverdeado médio
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
                    Icons.person_add_alt_1_outlined, // Ícone para registro
                    size: 70, // Um pouco menor que o da tela de login
                    color: onGradientColor,
                    shadows: [
                      Shadow(
                        blurRadius: 15.0,
                        color: Colors.black.withOpacity(0.35),
                        offset: const Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Crie Sua Conta',
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
                  Text(
                    'É rápido e fácil!',
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall
                        ?.copyWith(color: hintTextColor, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 28.0),

                  // Campo de Nome Completo
                  TextFormField(
                    controller: _nameController,
                    style: TextStyle(color: onGradientColor, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Nome Completo',
                      hintStyle: TextStyle(color: hintTextColor),
                      prefixIcon: Icon(Icons.person_outline,
                          color: onGradientColor, size: 20),
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
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome';
                      }
                      if (value.length < 3) {
                        return 'O nome deve ter pelo menos 3 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Campo de Email
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: onGradientColor, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Seu melhor email',
                      hintStyle: TextStyle(color: hintTextColor),
                      prefixIcon: Icon(Icons.email_outlined,
                          color: onGradientColor, size: 20),
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
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu email';
                      }
                      if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Campo de Senha
                  TextFormField(
                    controller: _passwordController,
                    style: TextStyle(color: onGradientColor, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Crie uma senha forte',
                      hintStyle: TextStyle(color: hintTextColor),
                      prefixIcon: Icon(Icons.lock_outline,
                          color: onGradientColor, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextPassword
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
                    obscureText: _obscureTextPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, crie uma senha';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Campo de Confirmar Senha
                  TextFormField(
                    controller: _confirmPasswordController,
                    style: TextStyle(color: onGradientColor, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Confirme sua senha',
                      hintStyle: TextStyle(color: hintTextColor),
                      prefixIcon: Icon(Icons.lock_outline,
                          color: onGradientColor, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureTextConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: onGradientColor.withOpacity(0.7),
                          size: 20,
                        ),
                        onPressed: _toggleConfirmPasswordVisibility,
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
                    obscureText: _obscureTextConfirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, confirme sua senha';
                      }
                      if (value != _passwordController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30.0),

                  // Botão de Registrar
                  _isLoading
                      ? Center(
                      child: CircularProgressIndicator(color: onGradientColor))
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: onGradientColor.withOpacity(0.95),
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
                    onPressed: _register,
                    child: const Text('CRIAR MINHA CONTA'),
                  ),
                  const SizedBox(height: 25.0),

                  // Link para Login (se já tiver conta)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Já possui uma conta? ',
                        style: TextStyle(color: hintTextColor, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Faça Login',
                          style: TextStyle(
                            color: onGradientColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: onGradientColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
