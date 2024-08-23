import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Combustível',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FuelCalculator(),
    );
  }
}

class FuelCalculator extends StatefulWidget {
  @override
  _FuelCalculatorState createState() => _FuelCalculatorState();
}

class _FuelCalculatorState extends State<FuelCalculator> {
  final _alcoholController = TextEditingController();
  final _gasolineController = TextEditingController();
  String _resultMessage = '';

  void _calculate() {
    final alcoholPrice = double.tryParse(_alcoholController.text);
    final gasolinePrice = double.tryParse(_gasolineController.text);

    if (alcoholPrice == null || gasolinePrice == null || gasolinePrice == 0) {
      setState(() {
        _resultMessage = 'Por favor, insira valores válidos para os combustíveis.';
      });
      return;
    }

    final ratio = alcoholPrice / gasolinePrice;

    setState(() {
      if (ratio < 0.7) {
        _resultMessage = 'Abasteça com Álcool';
      } else {
        _resultMessage = 'Gasolina é a melhor escolha';
      }
    });
  }

  void _clear() {
    setState(() {
      _alcoholController.clear();
      _gasolineController.clear();
      _resultMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_gas_station, color: Colors.white),
            SizedBox(width: 8.0),
            Text(
              "Calculadora de Combustível",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _alcoholController,
              decoration: InputDecoration(
                labelText: 'Preço do Álcool',
                prefixIcon: Icon(Icons.local_gas_station),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _gasolineController,
              decoration: InputDecoration(
                labelText: 'Preço da Gasolina',
                prefixIcon: Icon(Icons.local_gas_station),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  ),
                  child: Text('Calcular'),
                ),
                ElevatedButton(
                  onPressed: _clear,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  ),
                  child: Text('Limpar'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              _resultMessage,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: _resultMessage.contains('Álcool') ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
