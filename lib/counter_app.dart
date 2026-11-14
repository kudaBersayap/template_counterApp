import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tampil_angka.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int nilai = 0;
  bool _isLoading = true;
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    _preferences = await SharedPreferences.getInstance();
    final savedValue = _preferences.getInt('counter_value') ?? 0;

    if (!mounted) return;

    setState(() {
      nilai = savedValue;
      _isLoading = false;
    });
  }

  Future<void> _changeCounter(int change) async {
    final updatedValue = nilai + change;
    if (updatedValue < 0) return;

    setState(() {
      nilai = updatedValue;
    });
    await _preferences.setInt('counter_value', nilai);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nilai.toString(),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : () => _changeCounter(-1),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _isLoading ? null : () => _changeCounter(1),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TampilAngka(nilai: nilai)),
          );
        },
        child: const Icon(Icons.chevron_right),
      ),
    );
  }
}
