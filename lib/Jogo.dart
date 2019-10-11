import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vibration/vibration.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  var _imageApp = AssetImage("imagens/padrao.png");
  var _message = "Choose an option bellow";
  var _fundo = Colors.grey;
  var _colorBar = Colors.green;
  var _imageOct = AssetImage("imagens/octogon.png");

  void _optionSelected(String userChoice){

    var options = ["papel", "pedra", "tesoura"];
    var number = Random().nextInt(3);
    var appChoice = options[number];

    switch( appChoice ){
      case "papel":
        setState(() {
          this._imageApp = AssetImage("imagens/papel.png");
        });
        break;
      case "pedra":
        setState(() {
          this._imageApp = AssetImage("imagens/pedra.png");
        });
        break;
      case "tesoura":
        setState(() {
          this._imageApp = AssetImage("imagens/tesoura.png");
        });
        break;
    }

    //user's validation
    //User winner
    if(
    (userChoice == "pedra" && appChoice == "tesoura") ||
        (userChoice == "tesoura" && appChoice == "papel") ||
        (userChoice == "papel" && appChoice == "pedra")
    ){
      setState(() {
        this._message = "Congrats! You Won!";
        Future.delayed(const Duration(milliseconds: 3000), (){
          setState(() {
            this._message = "Choose an option";
          });
        });
      });
      //App winner
    }else if(
    (appChoice == "pedra" && userChoice == "tesoura") ||
        (appChoice == "tesoura" && userChoice == "papel") ||
        (appChoice == "papel" && userChoice == "pedra")
    ){
      setState(() {
        this._message = "Sorry! You Loose!";
        this._fundo = Colors.red;
        this._colorBar = Colors.red;
        Vibration.vibrate(duration: 1000);
        Future.delayed(const Duration(milliseconds: 1000), (){
          setState(() {
            this._fundo = Colors.grey;
            this._colorBar = Colors.green;
            this._message = "Choose an option";
          });
        });

      });
      //draw
    }else{
      setState(() {
        this._message = "We Tied!";
        Future.delayed(const Duration(milliseconds: 3000), (){
          setState(() {
            this._message = "Choose an option";
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo"),
        backgroundColor: this._colorBar,
      ),
      backgroundColor: this._fundo,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //text
          //imagem
          //text resultado
          //linha 3 umagens
          Padding(
            padding: EdgeInsets.only(top: 10,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _optionSelected("papel"),
                  child: Image.asset("imagens/app_paper.png", height: 70,),
                ),
                GestureDetector(
                  onTap: () => _optionSelected("pedra"),
                  child: Image.asset("imagens/app_rock.png", height: 70,),
                ),
                GestureDetector(
                  onTap: () => _optionSelected("tesoura"),
                  child: Image.asset("imagens/app_scissor.png", height: 70,),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: this._imageOct, height: 300,),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => _optionSelected("papel"),
                child: Image.asset("imagens/user_paper.png", height: 70,),
              ),
              GestureDetector(
                onTap: () => _optionSelected("pedra"),
                child: Image.asset("imagens/user_rock.png", height: 70,),
              ),
              GestureDetector(
                onTap: () => _optionSelected("tesoura"),
                child: Image.asset("imagens/user_scissor.png", height: 70,),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  this._message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
}
