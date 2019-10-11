import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vibration/vibration.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  var _imageAppRock = AssetImage("imagens/app_rock.png");
  var _imageAppPaper = AssetImage("imagens/app_paper.png");
  var _imageAppScissor = AssetImage("imagens/app_scissor.png");

  var _imageUserRock = AssetImage("imagens/user_rock.png");
  var _imageUserPaper = AssetImage("imagens/user_paper.png");
  var _imageUserScissor = AssetImage("imagens/user_scissor.png");

  var _message = "Choose an option bellow";
  var _fundo = Colors.grey;
  var _colorBar = Colors.green;
  var _imageOct = AssetImage("imagens/octogon.png");
  var _resultado = "Choose an option";


  void _optionSelected(String userChoice){

    var options = ["papel", "pedra", "tesoura"];
    var number = Random().nextInt(3);
    var appChoice = options[number];

    switch( appChoice ){
      case "papel":
        setState(() {
          this._imageAppPaper = AssetImage("imagens/app_paper_red.png");
        });
        break;
      case "pedra":
        setState(() {
          this._imageAppRock = AssetImage("imagens/app_rock_red.png");
        });
        break;
      case "tesoura":
        setState(() {
          this._imageAppScissor = AssetImage("imagens/app_scissor_red.png");
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
        this._resultado = "Congrats! You Won!";
        this._message = "";
        this._fundo = Colors.green;

        Future.delayed(const Duration(milliseconds: 3000), (){
          setState(() {
            this._fundo = Colors.grey;
            this._message = "Choose an option";
            this._resultado = "Choose an option";
            this._imageAppRock = AssetImage("imagens/app_rock.png");
            this._imageAppPaper = AssetImage("imagens/app_paper.png");
            this._imageAppScissor = AssetImage("imagens/app_scissor.png");

            this._imageUserRock = AssetImage("imagens/user_rock.png");
            this._imageUserPaper = AssetImage("imagens/user_paper.png");
            this._imageUserScissor = AssetImage("imagens/user_scissor.png");
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
        this._resultado = "Sorry! You Loose!";
        this._message = "";
        this._fundo = Colors.red;
        this._colorBar = Colors.red;

        Vibration.vibrate(duration: 1000);
        Future.delayed(const Duration(milliseconds: 3000), (){
          setState(() {
            this._fundo = Colors.grey;
            this._colorBar = Colors.green;
            this._message = "Choose an option";
            this._resultado = "Choose an option";
            this._imageAppRock = AssetImage("imagens/app_rock.png");
            this._imageAppPaper = AssetImage("imagens/app_paper.png");
            this._imageAppScissor = AssetImage("imagens/app_scissor.png");

            this._imageUserRock = AssetImage("imagens/user_rock.png");
            this._imageUserPaper = AssetImage("imagens/user_paper.png");
            this._imageUserScissor = AssetImage("imagens/user_scissor.png");
          });
        });

      });
      //draw
    }else{
      setState(() {
        this._resultado = "We Tied!";
        this._message = "";
        Future.delayed(const Duration(milliseconds: 3000), (){
          setState(() {
            this._message = "Choose an option";
            this._resultado = "Choose an option";
            this._imageAppRock = AssetImage("imagens/app_rock.png");
            this._imageAppPaper = AssetImage("imagens/app_paper.png");
            this._imageAppScissor = AssetImage("imagens/app_scissor.png");

            this._imageUserRock = AssetImage("imagens/user_rock.png");
            this._imageUserPaper = AssetImage("imagens/user_paper.png");
            this._imageUserScissor = AssetImage("imagens/user_scissor.png");
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
                Image(image: this._imageAppPaper, height: 70,),
                Image(image: this._imageAppRock, height: 70,),
                Image(image: this._imageAppScissor, height: 70,),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: const Alignment(0, 0),
                  children: <Widget>[
                    Image(image: this._imageOct, height: 300,),
                    Center(
                      child: Text(
                        _resultado,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 1.0,
                              color: Colors.white,
                              offset: Offset(0.5,0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  _optionSelected("papel");
                  setState(() {
                    this._imageUserPaper = AssetImage("imagens/user_paper_red.png");
                  });
                },
                child: Image(image: this._imageUserPaper, height: 70,),
              ),
              GestureDetector(
                onTap: () {
                  _optionSelected("pedra");
                  setState(() {
                    this._imageUserRock = AssetImage("imagens/user_rock_red.png");
                  });
                },
                child: Image(image: this._imageUserRock, height: 70,),
              ),
              GestureDetector(
                onTap: () {
                  _optionSelected("tesoura");
                  setState(() {
                    this._imageUserScissor = AssetImage("imagens/user_scissor_red.png");
                  });
                },
                child: Image(image: this._imageUserScissor, height: 70,),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "",
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
