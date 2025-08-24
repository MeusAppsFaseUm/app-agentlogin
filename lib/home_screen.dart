import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // IMPORT ADICIONADO
import 'login_screen.dart'; // Para navegar de volta ao sair

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Função _logout CORRIGIDA para limpar SharedPreferences
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Limpa o estado de login
    // Opcional: Limpar outros dados do usuário se você os salvou
    // await prefs.remove('userEmail');

    if (Navigator.of(context).mounted) { // Verificação de 'mounted' usando Navigator
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false, // Remove todas as rotas anteriores
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const Color onWoodColor = Color(0xFFE0E0E0);
    const Color diamondShadowColor = Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha Vitrine',
          style: TextStyle(fontWeight: FontWeight.w600, color: onWoodColor, letterSpacing: 0.5),
        ),
        backgroundColor: Colors.brown[700]?.withOpacity(0.85), // Um marrom escuro para o AppBar
        elevation: 6.0,
        shadowColor: Colors.black.withOpacity(0.5),
        actions: [
          Tooltip(
            message: 'Sair',
            child: IconButton(
              icon: const Icon(Icons.logout, color: onWoodColor, size: 26),
              onPressed: () {
                _logout(context);
              },
            ),
          ),
          const SizedBox(width: 8), // Pequeno espaçamento
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          // Usando um gradiente como textura de madeira clara
          gradient: LinearGradient(
            colors: [
              Colors.brown[200]!, // Madeira clara
              Colors.brown[300]!, // Madeira um pouco mais escura
              Colors.brown[400]!, // Tom médio
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0], // Controla a transição do gradiente
          ),
          // Se você tiver uma imagem de textura:
          // image: DecorationImage(
          //   image: AssetImage("assets/images/wood_texture.png"),
          //   fit: BoxFit.cover,
          //   colorFilter: ColorFilter.mode(
          //     Colors.black.withOpacity(0.15), // Sobrepõe um leve escurecimento
          //     BlendMode.darken,
          //   ),
          // ),
        ),
        child: Center(
          child: SingleChildScrollView( // Para evitar overflow se o conteúdo crescer
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.diamond_outlined,
                  size: 110, // Um pouco maior
                  color: onWoodColor.withOpacity(0.95),
                  shadows: [
                    Shadow(
                      blurRadius: 20.0, // Sombra mais suave e ampla
                      color: diamondShadowColor.withOpacity(0.6),
                      offset: const Offset(5.0, 5.0),
                    ),
                    Shadow(
                      blurRadius: 30.0,
                      color: Colors.white.withOpacity(0.25),
                      offset: const Offset(-3.0, -3.0),
                    ),
                  ],
                ),
                const SizedBox(height: 45.0),
                Text(
                  'Coloque aqui o seu negócio',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium?.copyWith( // Ajustado para headlineMedium
                    fontWeight: FontWeight.bold, // Mais destaque
                    color: onWoodColor,
                    letterSpacing: 0.8,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: diamondShadowColor.withOpacity(0.5),
                        offset: const Offset(2.5, 2.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Text(
                  'Este é o espaço onde sua incrível vitrine digital será exibida, atraindo todos os olhares!',
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith( // Ajustado para titleMedium
                    color: onWoodColor.withOpacity(0.9),
                    height: 1.4, // Melhor legibilidade para múltiplas linhas
                  ),
                ),
                const SizedBox(height: 50.0), // Mais espaço antes de potencial conteúdo futuro
                // Você pode adicionar mais elementos aqui conforme necessário
                // Exemplo:
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.brown[700]?.withOpacity(0.85),
                //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                //     textStyle: textTheme.labelLarge?.copyWith(color: onWoodColor, letterSpacing: 1),
                //   ),
                //   onPressed: () {
                //     // Ação do botão
                //   },
                //   child: const Text('Ver Produtos'),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

