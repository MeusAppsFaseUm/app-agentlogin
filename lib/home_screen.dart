import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'widgets/luxury_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Limpa o estado de login

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  void _showFeatureUnavailable(String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$featureName indisponível no modo demonstração.',
          style: GoogleFonts.outfit(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF22252D),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LuxuryBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Deixa o fundo animado visível
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.2),
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            'AGENT PORTAL',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          actions: [
            // Ícone de Notificação com Badge Dourado
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
                  onPressed: () => _showFeatureUnavailable('Notificações'),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5C158),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            // Ícone Sair
            IconButton(
              icon: const Icon(Icons.logout, color: Color(0xFFE5C158), size: 24),
              onPressed: () => _logout(context),
            ),
            const SizedBox(width: 8),
          ],
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 16.0, bottom: 90.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Cabeçalho do Perfil VIP (Glassmorphism)
              _buildHeaderVIP(),
              const SizedBox(height: 24.0),

              // 2. Seção de Métricas Rápidas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Painel de Performance',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Atualizado agora',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              _buildMetricsRow(),
              const SizedBox(height: 24.0),

              // 3. Gráfico de Desempenho VIP
              _buildChartSection(),
              const SizedBox(height: 24.0),

              // 4. Ações Rápidas (VIP Actions)
              Text(
                'Ações Rápidas VIP',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12.0),
              _buildActionsGrid(),
            ],
          ),
        ),
        // 5. Barra de Navegação Inferior Flutuante Translúcida
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildHeaderVIP() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              // Avatar com borda dourada
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE5C158).withValues(alpha: 0.1),
                  border: Border.all(
                    color: const Color(0xFFE5C158),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE5C158).withValues(alpha: 0.15),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Color(0xFFE5C158),
                  size: 32,
                ),
              ),
              const SizedBox(width: 16.0),
              // Nome e Nível de Acesso
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Olá, Membro VIP',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          'Acesso Prime Ativo',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.6),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Badge de Elite
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFE5C158).withValues(alpha: 0.15),
                  border: Border.all(
                    color: const Color(0xFFE5C158).withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  'EXCLUSIVO',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFE5C158),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildMetricCard('Cliques na Vitrine', '4,829', '+12.4%', Icons.remove_red_eye_outlined),
          const SizedBox(width: 12),
          _buildMetricCard('Novas Leads', '84', '+8.2%', Icons.group_outlined),
          const SizedBox(width: 12),
          _buildMetricCard('Taxa Conversão', '4.7%', '+1.1%', Icons.insights_outlined),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, String rate, IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          width: 150,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: const Color(0xFFE5C158), size: 22),
                  Text(
                    rate,
                    style: GoogleFonts.outfit(
                      color: Colors.greenAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                value,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                label,
                style: GoogleFonts.outfit(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Visualizações',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Crescimento Mensal',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withValues(alpha: 0.04),
                    ),
                    child: Text(
                      'Este Mês',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: const Color(0xFFE5C158),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              // Gráfico Custom Painter
              SizedBox(
                height: 120,
                child: CustomPaint(
                  painter: _LuxuryChartPainter(),
                  size: Size.infinite,
                ),
              ),
              const SizedBox(height: 12.0),
              // Dias da semana
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'].map((day) {
                  return Text(
                    day,
                    style: GoogleFonts.outfit(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _buildActionCard('Gerenciar Vitrine', Icons.storefront_outlined, 'Vitrine Ativa'),
        _buildActionCard('Solicitações VIP', Icons.chat_bubble_outline, '3 Mensagens'),
        _buildActionCard('Relatórios VIP', Icons.pie_chart_outline, 'Insights'),
        _buildActionCard('Painel de Configs', Icons.tune, 'Ajustes VIP'),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, String subtitle) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: InkWell(
          onTap: () => _showFeatureUnavailable(title),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.05),
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: const Color(0xFFE5C158), size: 24),
                const SizedBox(height: 10.0),
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Positioned(
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
      child: Container(
        height: 66,
        decoration: BoxDecoration(
          color: const Color(0xFF0F131C).withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(33.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(33.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavBarItem(0, Icons.dashboard_outlined, 'Painel'),
                _buildNavBarItem(1, Icons.bar_chart_outlined, 'Métricas'),
                _buildNavBarItem(2, Icons.message_outlined, 'Chat'),
                _buildNavBarItem(3, Icons.person_outline, 'Perfil'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem(int index, IconData icon, String label) {
    final bool isSelected = _currentNavIndex == index;
    final Color color = isSelected ? const Color(0xFFE5C158) : Colors.white.withValues(alpha: 0.4);

    return InkWell(
      onTap: () {
        setState(() {
          _currentNavIndex = index;
        });
        if (index > 0) {
          _showFeatureUnavailable(label);
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: isSelected ? 24 : 22),
          const SizedBox(height: 3.0),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: color,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _LuxuryChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = const Color(0xFFE5C158)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final paintFill = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        colors: [
          const Color(0xFFE5C158).withValues(alpha: 0.25),
          const Color(0xFFE5C158).withValues(alpha: 0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.cubicTo(
      size.width * 0.2, size.height * 0.8,
      size.width * 0.4, size.height * 0.2,
      size.width * 0.6, size.height * 0.45,
    );
    path.cubicTo(
      size.width * 0.8, size.height * 0.6,
      size.width * 0.9, size.height * 0.15,
      size.width, size.height * 0.2,
    );

    // Linha
    canvas.drawPath(path, paintLine);

    // Preenchimento gradiente abaixo da linha
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, paintFill);

    // Pontos de destaque (círculos dourados)
    final paintDot = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final paintDotOuter = Paint()
      ..color = const Color(0xFFE5C158)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width, size.height * 0.2), 6, paintDotOuter);
    canvas.drawCircle(Offset(size.width, size.height * 0.2), 3, paintDot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
