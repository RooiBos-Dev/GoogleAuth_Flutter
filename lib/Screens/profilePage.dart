//Packages
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googlesignin/main.dart';
import 'package:googlesignin/Services/auth.dart';
import 'package:googlesignin/Models/userModel.dart';
import 'package:provider/provider.dart';
import 'package:googlesignin/Services/services.dart';
//Root
class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final Firestore _firestore = Firestore.instance;
  StreamSubscription sub;
  DateTime _dateTime;
  Map data;

  @override
  void initState() {
    sub = _firestore.collection('user').document('id').snapshots().listen((
        event) {
      setState(() {
        data = event.data;
      });
    });super.initState();}

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
      ],
      child: MaterialApp(theme: ThemeData(

        primaryColor: Colors.deepOrangeAccent,
        accentColor: Colors.deepOrange),
        home:
        Scaffold(
          body: ProfileCard(),
          appBar: AppBar(title:Text(""),
            backgroundColor: Colors.deepOrangeAccent,

        actions: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  tooltip: 'logout of google acount',
                  onPressed: () async{
                    Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {return MyHomePage();}), ModalRoute.withName('/'));
                          },
                ),
                Text("Logout", style: TextStyle(fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'BalooBhaina',
                    fontWeight: FontWeight.w400),),

              ],
            ),
          ),],),drawer:
      Drawer(
// Add a ListView to the drawer. This ensures the user can scroll
// through the options in the drawer if there isn't enough vertical
// space to fit everything.
        child: ListView(
// Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: drawerHeader(),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
              ),
            ),
            ListTile(
              title: Text("ITEM1",style: TextStyle(color: Colors.black45,fontSize: 18.0,
                  fontFamily: 'BalooBhaina',
                  fontWeight: FontWeight.w400), ),
              onTap: () {
// Update the state of the app.
// ...
              },
            ),
            ListTile(
              title: Text("ITEM 2",style: TextStyle(color: Colors.black45,fontSize: 18.0,
                  fontFamily: 'BalooBhaina',
                  fontWeight: FontWeight.w400), ),
              onTap: () {
// Update the state of the app.
// ...
              },
            ),
          ],
        ),
      ),

       floatingActionButton: new Theme(
          data: Theme.of(context).copyWith(
          primaryColor: Colors.deepOrangeAccent,),

           child: Builder(
            builder: (context) => new FloatingActionButton(backgroundColor: Colors.deepOrangeAccent,
    child: new Icon(Icons.date_range),
    onPressed: () => showDatePicker(
    context: context,
    initialDate: new DateTime.now(),
    firstDate:
    new DateTime.now().subtract(new Duration(days: 30)),
    lastDate: new DateTime.now().add(new Duration(days: 30)),
    ),
    )

          //     Icon(Icons.calendar_today,color: Colors.white,),
            //   SizedBox(width: 10,),
        //       Text("SCHEDULE",style: TextStyle(color: Colors.white,fontSize: 18.0,
              //     fontFamily: 'BalooBhaina',
      //             fontWeight: FontWeight.w400), ),

    //         ],
    ),
       ),)));


  }
  Widget drawerHeader() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.deepOrange,
              backgroundImage: NetworkImage(photo),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(name,style: TextStyle(color: Colors.white,fontSize: 18.0,
                          fontFamily: 'BalooBhaina',
                          fontWeight: FontWeight.w400), ),
                      SizedBox(height: 8,),

                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(email,style: TextStyle(color: Colors.white,fontSize: 16.0,
                          fontFamily: 'BalooBhaina',
                          fontWeight: FontWeight.w400), ),
                    ],)
                ],
              ),
            ),

          ],
        ),

      ],
    );

  }
}


class ProfileCard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return ListView(children: <Widget>[
      Container(

        margin: EdgeInsets.only(top: 10, right: 20, left: 20),
        height: 600,
        width: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  blurRadius: 20,
                  spreadRadius: 10),
            ]),
        child: new Profile(),
      ),
    ],

    );

  }
}
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final Firestore _firestore = Firestore.instance;

  DatabaseServices db = new DatabaseServices();
  StreamSubscription sub;
  Map data;

  @override
  void initState() {
    sub = _firestore.collection('user').document('id').snapshots().listen((
        event) {
      setState(() {
        data = event.data;
      });
    });}

  @override
  Widget build(BuildContext context){
    var user = Provider.of<FirebaseUser>(context);
         return Container(
           child: Stack(

            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[

              Positioned(top: 30,
                child: Container(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.deepOrange,
                    backgroundImage: NetworkImage(photo),
                  ),
                ),
              ),


              Positioned(top: 150,
                child: Container(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(name, style: TextStyle(fontSize: 30,
                          color: Colors.black,
                          fontFamily: 'BalooBhaina',
                          fontWeight: FontWeight.w400),),
                      Icon(Icons.check_circle, color: Colors.blue,),
                    ],
                  ),
                ),
              ),

              Positioned(top: 190,
                child: Container(
                  child: Text("New User", style: TextStyle(fontSize: 15,
                      color: Colors.black45,
                      fontFamily: 'BalooBhaina',
                      fontWeight: FontWeight.w400),),
                ),
              ),

              Positioned(top: 210,
                child: Row(

                  children: List.generate(5, (index ) {
                    return Icon(
                      Icons.star,
                      color: Colors.deepOrange,
                    );
                  }),
                ),
              ),
              Positioned(top: 230,
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                  width: 320,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 30,
                            spreadRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Email",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
                      SizedBox(height: 5,),
                      Text(email,
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),),
                      SizedBox(height: 5,),
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Bio",
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
                          Spacer(),
                          FlatButton(child: Icon(Icons.edit, color: Colors.black,),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (_) => LogoutOverlay(),
                              )) ,
                        ],
                      ),
                      StreamBuilder<User>(
                        stream: db.DataStream(user.uid),
                        builder: (context, snapshot){
                          if(snapshot.data == null) return CircularProgressIndicator();
                          var bio = snapshot.data;
                          return Text(bio.bio);
                        },

                      ),
                    ],
                  ),
                ),
              ),
             ]),
         );

  }
}

class LogoutOverlay extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay>
    with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> scaleAnimation;
  final myController = TextEditingController();


  @override
  void initState() {

    controller =
        AnimationController(
            vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
    super.initState();
  }
  @override
  void dispose() {

    myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    DatabaseServices db = new DatabaseServices();

       return Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(15.0),
                height: 180.0,

                decoration: ShapeDecoration(
                    color: Color.fromRGBO(255, 99, 71, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20.0, right: 20.0),
                          child: Text(
                            "Something about you!",
                            style: TextStyle(color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'BalooBhaina',
                                fontWeight: FontWeight.w400),
                          ),
                        )),

                    TextFormField(
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: 'Bio',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.grey[100],
                        filled: true,
                        suffixIcon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                    ),


                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ButtonTheme(
                                  height: 35.0,
                                  minWidth: 110.0,
                                  child: RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0)),
                                    splashColor: Colors.white.withAlpha(40),
                                    child: Text(
                                      'Done',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0),
                                    ),
                                    onPressed :(){
                                      //updateBio Service
                                      db.updateUserBio(myController.text).whenComplete(() =>  Navigator.pop(context));
                                    },
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 10.0,
                                    top: 10.0,
                                    bottom: 10.0),
                                child: ButtonTheme(
                                    height: 35.0,
                                    minWidth: 110.0,
                                    child: RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5.0)),
                                      splashColor: Colors.white.withAlpha(40),
                                      child: Text(
                                        'Cancel',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Route route = MaterialPageRoute(
                                              builder: (context) =>
                                                  UserProfile());
                                          Navigator.pop(context, route);
                                        });
                                      },
                                    ))
                            ),
                          ],
                        ))
                  ],
                )),
          ),
        ),
    );
  }


}





