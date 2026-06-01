import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/luxury_background.dart';
import 'widgets/luxury_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      // Armazenando instâncias antes de qualquer chamada assíncrona
      final navigator = Navigator.of(context);
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      setState(() {
        _isLoading = true;
      });

      // Simulação de chamada assíncrona
      await Future.delayed(const Duration(seconds: 2));

      final String name = _nameController.text;
      final String email = _emailController.text;

      debugPrint('Registrando usuário: $name ($email)');

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            'Registro de $name bem-sucedido! Faça login para continuar.',
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF1E3A2F),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      );

      navigator.pop(); // Retorna para tela de login
    }
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final Color onBackground = Colors.white;
    final Color hintTextColor = Colors.white.withValues(alpha: 0.5);

    return LuxuryBackground(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Botão voltar personalizado
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 12.0),

              // Ícone com Moldura de Vidro Dourada (Menor que da LoginScreen)
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.all(
                      color: const Color(0xFFE5C158).withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE5C158).withValues(alpha: 0.08),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.person_add_alt_1_outlined,
                    size: 38,
                    color: const Color(0xFFE5C158),
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: const Color(0xFFE5C158).withValues(alpha: 0.3),
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              Text(
                'Criar Conta VIP',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: onBackground,
                  letterSpacing: 0.8,
                  shadows: [
                    Shadow(
                      blurRadius: 12.0,
                      color: Colors.black.withValues(alpha: 0.5),
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'Faça parte do clube exclusivo de negócios',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: hintTextColor,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 28.0),

              // Formulário de Cadastro com Efeito de Vidro Fosco
              ClipRRect(
                borderRadius: BorderRadius.circular(28.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(28.0),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                        width: 1.0,
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Campo Nome Completo
                          TextFormField(
                            controller: _nameController,
                            style: GoogleFonts.outfit(color: onBackground, fontSize: 15),
                            decoration: _buildInputDecoration('Nome Completo', Icons.person_outline, hintTextColor),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira seu nome completo';
                              }
                              if (value.length < 3) {
                                return 'Mínimo de 3 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          // Campo E-mail
                          TextFormField(
                            controller: _emailController,
                            style: GoogleFonts.outfit(color: onBackground, fontSize: 15),
                            decoration: _buildInputDecoration('Seu melhor e-mail', Icons.email_outlined, hintTextColor),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira seu e-mail';
                              }
                              if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                return 'E-mail inválido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          // Campo Senha
                          TextFormField(
                            controller: _passwordController,
                            style: GoogleFonts.outfit(color: onBackground, fontSize: 15),
                            decoration: _buildInputDecoration(
                              'Crie uma senha forte',
                              Icons.lock_outline,
                              hintTextColor,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureTextPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: Colors.white.withValues(alpha: 0.6),
                                  size: 18,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                            obscureText: _obscureTextPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Crie uma senha';
                              }
                              if (value.length < 6) {
                                return 'Mínimo de 6 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          // Campo Confirmar Senha
                          TextFormField(
                            controller: _confirmPasswordController,
                            style: GoogleFonts.outfit(color: onBackground, fontSize: 15),
                            decoration: _buildInputDecoration(
                              'Confirme sua senha',
                              Icons.lock_outline,
                              hintTextColor,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureTextConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: Colors.white.withValues(alpha: 0.6),
                                  size: 18,
                                ),
                                onPressed: _toggleConfirmPasswordVisibility,
                              ),
                            ),
                            obscureText: _obscureTextConfirmPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirme sua senha';
                              }
                              if (value != _passwordController.text) {
                                return 'As senhas não coincidem';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 28.0),

                          // Botão Criar Conta
                          LuxuryButton(
                            text: 'CRIAR MINHA CONTA',
                            onPressed: _register,
                            isLoading: _isLoading,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28.0),

              // Link para voltar ao Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Já possui uma conta? ',
                    style: GoogleFonts.outfit(color: Colors.white.withValues(alpha: 0.6), fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Faça Login',
                      style: GoogleFonts.outfit(
                        color: const Color(0xFFE5C158),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFFE5C158),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText, IconData prefixIcon, Color hintColor, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.outfit(color: hintColor),
      prefixIcon: Icon(
        prefixIcon,
        color: const Color(0xFFE5C158).withValues(alpha: 0.8),
        size: 20,
      ),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(
          color: Color(0xFFE5C158),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: Colors.redAccent.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.02),
    );
  }
}
