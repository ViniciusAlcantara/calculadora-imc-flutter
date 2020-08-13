import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // This widget is the root of your application.
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String infoText = 'Informe seus dados!';

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _resetFields() {
    setState(() {
      infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
    weightController.text = '';
    heightController.text = '';
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if (imc < 18.6) {
        infoText = 'Abaixo do peso (${imc.toStringAsFixed(4)})';
      } else if (imc > 18.6 && imc < 24.9) {
        infoText = 'Parabéns você está dentro do peso (${imc.toStringAsFixed(4)})';
      } else {
        infoText = 'Você está acima do peso (${imc.toStringAsFixed(4)})';
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => {
                this._resetFields()
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 128.0, color: Colors.green,),
                TextFormField(keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(color: Colors.green)
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Digite o peso';
                    }
                    return null;
                  },
                ),
                TextFormField(keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(color: Colors.green)
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Digite a altura';
                    }
                    return null;
                  },
                ),
                Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () => {
                      if (_formkey.currentState.validate()) {
                        this.calculate()
                      }
                    },
                    child: Text('Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25.0)
                    ),
                    color: Colors.green,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(infoText, textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25.0)
                  ),
                )
              ],
            ),
          )
        )
      ),
    );
  }
}