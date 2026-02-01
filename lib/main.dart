import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator - Your Name',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = "";
  String _result = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _expression = "";
        _result = "";
      } else if (value == "=") {
        _calculateResult();
      } else if (value == "x²") {
        _squareCurrentValue();
      } else {
        _expression += value;
      }
    });
  }

  void _calculateResult() {
    try {
      if (_expression.isEmpty) return;

      Expression exp = Expression.parse(_expression);
      const evaluator = ExpressionEvaluator();
      var evalResult = evaluator.eval(exp, {});

      setState(() {
        _result = evalResult.toString();
        _expression = "$_expression = $_result";
      });
    } catch (e) {
      setState(() {
        _result = "Error";
      });
    }
  }

  void _squareCurrentValue() {
    try {
      if (_expression.isEmpty) return;

      Expression exp = Expression.parse(_expression);
      const evaluator = ExpressionEvaluator();
      var value = evaluator.eval(exp, {});

      var squared = value * value;

      setState(() {
        _expression = "$_expression² = $squared";
        _result = squared.toString();
      });
    } catch (e) {
      setState(() {
        _result = "Error";
      });
    }
  }

  Widget _buildButton(String text, {Color color = Colors.black87}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 22),
            backgroundColor: Colors.grey[200],
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: color),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator - Saurab"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _expression,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _result,
                  style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton("x²", color: Colors.purple),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/", color: Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("*", color: Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-", color: Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("0"),
                    _buildButton("."),
                    _buildButton("C", color: Colors.red),
                    _buildButton("+", color: Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("=", color: Colors.green),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
