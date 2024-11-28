import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CornerRadiusProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CornerRadiusScreen(),
    );
  }
}

class CornerRadiusProvider extends ChangeNotifier {
  double _topLeft = 10.0;
  double _topRight = 10.0;
  double _bottomLeft = 10.0;
  double _bottomRight = 10.0;

  double get topLeft => _topLeft;
  double get topRight => _topRight;
  double get bottomLeft => _bottomLeft;
  double get bottomRight => _bottomRight;

  void updateTopLeft(double value) {
    _topLeft = value;
    notifyListeners();
  }

  void updateTopRight(double value) {
    _topRight = value;
    notifyListeners();
  }

  void updateBottomLeft(double value) {
    _bottomLeft = value;
    notifyListeners();
  }

  void updateBottomRight(double value) {
    _bottomRight = value;
    notifyListeners();
  }
}

class CornerRadiusScreen extends StatelessWidget {
  const CornerRadiusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corner Radius Configurator'),
      ),
      body: Column(
        children: const [
          Expanded(
            flex: 2,
            child: SlidersSection(),
          ),
          Expanded(
            flex: 3,
            child: BlueContainer(),
          ),
        ],
      ),
    );
  }
}

class SlidersSection extends StatelessWidget {
  const SlidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CornerRadiusProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SliderRow(
            label: 'Top Left',
            value: provider.topLeft,
            onChanged: provider.updateTopLeft,
          ),
          SliderRow(
            label: 'Top Right',
            value: provider.topRight,
            onChanged: provider.updateTopRight,
          ),
          SliderRow(
            label: 'Bottom Left',
            value: provider.bottomLeft,
            onChanged: provider.updateBottomLeft,
          ),
          SliderRow(
            label: 'Bottom Right',
            value: provider.bottomRight,
            onChanged: provider.updateBottomRight,
          ),
        ],
      ),
    );
  }
}

class SliderRow extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const SliderRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 75,
            onChanged: onChanged,
          ),
        ),
        Text(value.toStringAsFixed(0)),
      ],
    );
  }
}

class BlueContainer extends StatelessWidget {
  const BlueContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CornerRadiusProvider>(context);

    return Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(provider.topLeft),
            topRight: Radius.circular(provider.topRight),
            bottomLeft: Radius.circular(provider.bottomLeft),
            bottomRight: Radius.circular(provider.bottomRight),
          ),
        ),
      ),
    );
  }
}