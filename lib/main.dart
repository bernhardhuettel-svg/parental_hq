import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

void main() => runApp(const ParentalOS());

class ParentalOS extends StatelessWidget {
  const ParentalOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF002B5B), // Industrial Navy
          brightness: Brightness.dark, // Dark Mode für echtes Cockpit-Feeling
        ),
      ),
      home: const MainCommandCenter(),
    );
  }
}

class MainCommandCenter extends StatefulWidget {
  const MainCommandCenter({super.key});

  @override
  State<MainCommandCenter> createState() => _MainCommandCenterState();
}

class _MainCommandCenterState extends State<MainCommandCenter> {
  int _activeModule = 0;

  final List<Widget> _modules = [
    const MasterDashboard(),
    const FinanceEngineeringHub(),
    const SafetyAndSpecsModule(),
    const LogisticsAndSupplyModule(),
    const LegalComplianceSystem(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation Rail für schnellen Zugriff (wie bei Profi-Software)
          NavigationRail(
            selectedIndex: _activeModule,
            onDestinationSelected: (i) => setState(() => _activeModule = i),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.analytics), label: 'Cockpit'),
              NavigationRailDestination(icon: Icon(Icons.account_tree), label: 'Wealth'),
              NavigationRailDestination(icon: Icon(Icons.engineering), label: 'Safety'),
              NavigationRailDestination(icon: Icon(Icons.inventory), label: 'Logistics'),
              NavigationRailDestination(icon: Icon(Icons.gavel), label: 'Legal'),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _modules[_activeModule]),
        ],
      ),
    );
  }
}

// --- MODULE 1: WEALTH & ROI ENGINEERING ---
class FinanceEngineeringHub extends StatelessWidget {
  const FinanceEngineeringHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capital & Tax Optimization')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildMetricCard("Net Worth Projection (18y)", "142.500 €", Icons.trending_up),
            const SizedBox(height: 20),
            _buildTaxOptimizationTile(),
            const SizedBox(height: 20),
            _buildSecondHandROICalc(),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String t, String v, IconData i) => Card(
    child: ListTile(
      leading: Icon(i, color: Colors.amber),
      title: Text(t),
      trailing: Text(v, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ),
  );

  Widget _buildTaxOptimizationTile() => const Card(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Steuer-Matrix (NV-Bescheinigung)", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Nutze den Grundfreibetrag des Kindes (ca. 11.604 €) + Sparerpauschbetrag."),
          LinearProgressIndicator(value: 0.7, color: Colors.green),
        ],
      ),
    ),
  );

  Widget _buildSecondHandROICalc() => ExpansionTile(
    title: const Text("Asset Value Recovery (Second Hand)"),
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: "Anschaffungspreis (Neu)")),
            const TextField(decoration: InputDecoration(labelText: "Erwarteter Resale nach 24 Mon.")),
            ElevatedButton(onPressed: () {}, child: const Text("Netto-Abnutzung berechnen")),
          ],
        ),
      )
    ],
  );
}

// --- MODULE 2: SAFETY ENGINEERING (Car Seats & Tech) ---
class SafetyAndSpecsModule extends StatelessWidget {
  const SafetyAndSpecsModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety & Technical Specs')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Emily's Safety Matrix", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildSafetyCheck("ISOFIX Station A", "Zugelassen für Honda Jazz & Kia Ceed"),
          _buildSafetyCheck("Reboarder Transition", "In 14 kg / 105 cm fällig"),
          const Card(
            color: Color(0xFF1B262C),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Zulassungs-Check: i-Size (R129)", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Prüfung der Rückbank-Geometrie für 3 Kindersitze parallel."),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyCheck(String t, String s) => ListTile(
    leading: const Icon(Icons.verified, color: Colors.blue),
    title: Text(t),
    subtitle: Text(s),
  );
}

// --- MODULE 3: THE "ULTIMATE" DASHBOARD ---
class MasterDashboard extends StatelessWidget {
  const MasterDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(title: Text('PARENTAL COMMAND')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildStatusRow("System-Ready", Colors.green),
                  const SizedBox(height: 16),
                  _buildGrid(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatusRow(String s, Color c) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: c.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
    child: Row(children: [Icon(Icons.check_circle, color: c), const SizedBox(width: 10), Text(s)]),
  );

  Widget _buildGrid(BuildContext context) => GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    children: [
      _quickTile("Energy Sync", Icons.bolt, "PV-Überschuss nutzen"),
      _quickTile("Document Safe", Icons.lock, "4 Scans gesichert"),
      _quickTile("DIY Blueprints", Icons.architecture, "Lernturm V2"),
      _quickTile("Legal Status", Icons.gavel, "Sorgerecht-OK"),
    ],
  );

  Widget _quickTile(String t, IconData i, String s) => Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(i, size: 30), Text(t), Text(s, style: const TextStyle(fontSize: 9))],
    ),
  );
}

// --- MODULE 4: LEGAL COMPLIANCE ---
class LegalComplianceSystem extends StatelessWidget {
  const LegalComplianceSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Family Legal Guard')),
      body: const Center(child: Text("Status: Sorgerechtsverfügung & Testament hinterlegt.")),
    );
  }
}

// --- MODULE 5: LOGISTICS & SUPPLY ---
class LogisticsAndSupplyModule extends StatelessWidget {
  const LogisticsAndSupplyModule({super.all});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resource Planning')),
      body: const Center(child: Text("Bestandsmanagement & automatisierte Einkaufslisten.")),
    );
  }
}
