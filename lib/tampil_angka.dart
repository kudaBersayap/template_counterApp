import 'package:flutter/material.dart';

class TampilAngka extends StatefulWidget {
  final int nilai;

  const TampilAngka({super.key, required this.nilai});

  @override
  State<TampilAngka> createState() => _TampilAngkaState();
}

class _TampilAngkaState extends State<TampilAngka> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNilai();
  }

  Future<void> _loadNilai() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tampil Angka'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nilai terakhir adalah',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (_isLoading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Menunggu...'),
            ] else
              Text(
                widget.nilai.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
