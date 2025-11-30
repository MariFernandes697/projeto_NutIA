// area_detail_screen.dart

import 'package:flutter/material.dart';
import 'camera_diagnosis_screen.dart'; // Importe a tela de câmera
import 'irrigation_settings_screen.dart'; // NOVO: Importe a tela de configuração de irrigação

// Cores de design (Mantidas)
const Color primaryColor = Color(0xFF1B5E20);
const Color alertColor = Color(0xFFE53935);
const Color safeColor = Color(0xFF43A047);
const Color textColor = Color(0xFF424242);
const Color fabColor = Color(0xFF4CAF50);

// Modelo de dados mockado para o sensor (Ajustado)
class SensorData {
  final IconData icon;
  final String title;
  final String value;
  final bool isAlert;
  final Color statusColor;
  final bool isClickable; // NOVO: Flag para itens clicáveis

  const SensorData({
    required this.icon,
    required this.title,
    required this.value,
    this.isAlert = false,
    this.statusColor = primaryColor,
    this.isClickable = false, // Padrão é falso
  });
}

class AreaDetailScreen extends StatelessWidget {
  final String areaName;

  const AreaDetailScreen({super.key, required this.areaName});

  // Dados mockados dos sensores (AJUSTADO: Removido Umidade, mantido Luz e Pragas)
  final List<SensorData> sensors = const [
    SensorData(
      icon: Icons.wb_sunny_outlined,
      title: 'Intensidade de luz',
      value: '80%',
      statusColor: primaryColor,
    ),
    SensorData(
      icon: Icons.bug_report_outlined,
      title: 'Possíveis pragas',
      value: 'Verifique sua horta!',
      isAlert: true,
      statusColor: alertColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // ... (Scaffold, AppBar, FAB permanecem os mesmos)
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
          areaName,
          style: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: _buildBody(context),

      // NOVO: Floating Action Button para iniciar a análise
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Lógica de navegação para a tela da câmera
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CameraDiagnosisScreen(),
            ),
          );
        },
        label: const Text(
          'Realizar Análise',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        icon: const Icon(Icons.camera_alt, color: Colors.white),
        backgroundColor: fabColor,
        elevation: 8,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryColor, // O corpo principal é o verde escuro
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 25.0, bottom: 100.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAreaImage(),
            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Sensores',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // NOVO: Card clicável para Umidade e Irrigação
            _buildIrrigationControlCard(context),

            // Lista de Cartões de Sensores (Intensidade de Luz e Pragas)
            ...sensors
                .map((sensor) => _buildSensorCard(sensor, context))
                .toList(),
          ],
        ),
      ),
    );
  }

  // Imagem da Área (Mantida)
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
            'assets/img/icons.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.park, size: 60, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  // NOVO WIDGET: Card de Umidade/Irrigação (Clicável)
  Widget _buildIrrigationControlCard(BuildContext context) {
    // Usamos InkWell para o clique em toda a área do cartão
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => IrrigationSettingsScreen(areaName: areaName),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
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
            Row(
              children: [
                const Icon(
                  Icons.water_drop_outlined,
                  color: primaryColor,
                  size: 28,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Umidade do solo / Irrigação',
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
                Icon(
                  Icons.chevron_right,
                  color: primaryColor.withOpacity(0.7),
                  size: 30,
                ), // Indicador de que é clicável
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Card de Status do Sensor (Mantido para Luz e Pragas)
  Widget _buildSensorCard(SensorData data, BuildContext context) {
    // ... (restante do código do Card de Status do Sensor)
    final Widget chartPlaceholder = Icon(
      Icons.show_chart,
      color: data.statusColor.withOpacity(0.7),
      size: 40,
    );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
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
          Row(
            children: [
              Icon(data.icon, color: primaryColor, size: 28),
              const SizedBox(width: 10),
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.value,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: data.statusColor,
                ),
              ),
              chartPlaceholder,
            ],
          ),
        ],
      ),
    );
  }
}
