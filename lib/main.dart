//packages
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:googlesignin/Screens/profilePage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:googlesignin/Services/auth.dart';
//main
void main() => runApp(MyApp());
//root
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
//HomePage Widget
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
//HomePage State
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  AuthService auth = new AuthService();
  AnimationController _controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200 ),lowerBound: 0,upperBound: 4,
      vsync: this,
    )..addListener(() {
      setState(() {

      });})..addStatusListener((status) {if(status == AnimationStatus.completed){
      _controller.reverse();
    }else if (status == AnimationStatus.dismissed){_controller.forward();}});
    animation = Tween(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));
    _controller.forward();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.deepOrangeAccent,
      body:

         Container(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[

                FlareActor("assets/confetti.flr",alignment: Alignment.topCenter,fit: BoxFit.contain,animation: "confetti shu 2",),



                              Positioned(top: 200,
                                child: AnimatedBuilder(

                                animation: _controller,
                                builder: (BuildContext context, Widget child){
                                  return Transform(
                                    transform: Matrix4.translationValues(0,_controller.value*2 ,0),
                                    child:Image.asset(
                                      'assets/agreement.png',
                                      height: 120.0,width: 70,
                                    ),

                                  );}),
                              ),






                Positioned( top: 290,  child: Container(child: Text("Welcome!", style: TextStyle(fontSize: 40,color: Colors.white,fontFamily: 'BalooBhaina',fontWeight: FontWeight.w400),))),

                Positioned(top: 380,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                    child: new RaisedButton(
                        padding: EdgeInsets.only(top: 3.0,bottom: 3.0,left: 3.0),
                        color: const Color(0xFF4285F4),
                        onPressed: () {
                          auth.signInWithGoogle().whenComplete(() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return UserProfile();
                                },
                              ),);},);


                        },//=> authService.googleSignIn(),
                        child: new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            new Container(
                                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    new Text("Sign in with ",style: TextStyle(color: Colors.white,fontFamily: 'BalooBhaina'),),
                                    Icon(
                                      MdiIcons.google,size: 20,color: Colors.white,
                                    )
                                  ],
                                )
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
        ),
         );
// This trailing comma makes auto-formatting nicer for build methods.

  }
}


