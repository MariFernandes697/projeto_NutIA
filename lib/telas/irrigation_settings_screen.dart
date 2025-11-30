import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF1B5E20);
const Color safeColor = Color(0xFF43A047);
const Color textColor = Color(0xFF424242);

class IrrigationSettingsScreen extends StatelessWidget {
  final String areaName;

  const IrrigationSettingsScreen({super.key, required this.areaName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          areaName, // Ex: Horta Tomates
          style: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryColor, // Fundo verde escuro
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem da Área (Mantida do design original)
            _buildAreaImage(),
            const SizedBox(height: 30),

            // Título Sensores
            const Text(
              'Sensores',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            // Card principal de Umidade e Irrigação
            _buildIrrigationCard(),
            const SizedBox(height: 30),

            // Aqui você pode adicionar outros cartões de sensores remanescentes, se houver
          ],
        ),
      ),
    );
  }

  // Imagem da Área (Widget reutilizado)
  Widget _buildAreaImage() {
    return Center(
      child: Container(
        height: 200,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            'assets/img/icons.png', // Placeholder para folha
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.park, size: 60, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  // Card de Umidade e Configuração de Irrigação
  Widget _buildIrrigationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Umidade do Solo
          Row(
            children: [
              const Icon(
                Icons.water_drop_outlined,
                color: primaryColor,
                size: 28,
              ),
              const SizedBox(width: 10),
              const Text(
                'Umidade do solo',
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '45%',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              // Simulação do gráfico de onda
              Icon(
                Icons.show_chart,
                color: primaryColor.withOpacity(0.7),
                size: 40,
              ),
            ],
          ),
          const Divider(height: 30, thickness: 1, color: Color(0xFFF0F0F0)),

          // 2. Tempo de Irrigação
          const Row(
            children: [
              Icon(Icons.timer_outlined, color: primaryColor, size: 28),
              SizedBox(width: 10),
              Text(
                'Tempo de irrigação',
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Opções de Tempo
          _buildTimeOption(time: '10 minutos', isRecommended: true),
          _buildTimeOption(time: '15 minutos'),
          _buildTimeOption(time: 'Adicionar tempo', isAddOption: true),
        ],
      ),
    );
  }

  // Widget para os botões de opção de tempo
  Widget _buildTimeOption({
    required String time,
    bool isRecommended = false,
    bool isAddOption = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF0F0F0), // Fundo cinza claro
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  isAddOption ? Icons.add_circle_outline : Icons.timer_outlined,
                  color: primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 18,
                    color: isAddOption ? primaryColor : textColor,
                    fontWeight: isAddOption
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
            if (isRecommended)
              Icon(
                Icons.eco,
                color: safeColor,
              ), // Ícone de folha para recomendação
          ],
        ),
      ),
    );
  }
}
