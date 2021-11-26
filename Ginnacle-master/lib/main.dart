import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'menu.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/menu': (context) => HomeScreen()
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }
}


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { 
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: letras,//,Color.fromRGBO(243, 246, 251, 1.0),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child:  Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 5.0, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          offset: new Offset(0,0),
                          blurRadius: 2.0,
                        )
                      ]),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * .5,
                  child: Column(
                    // horizontal).
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                              color: eerieBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Form(
                        child: Column(
                          children: [
                            Container(
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: TextFormField(
                                      controller: _emailInputController,
                                      keyboardType: TextInputType.emailAddress,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: rosaPastel)),
                                        labelText: "e-mail",
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                      ),
                                    ))),
                            SizedBox(height: 15.0),
                            Container(
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: TextFormField(
                                      controller: _passwordInputController,
                                      autofocus: false,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                        labelText: "Password",
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                      ),
                                    ))),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: SizedBox(
                                  width: 200,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/menu');
                                      setState(() {
                                      });
                                    },
                                    color: Color(0xFFA480F2),
                                    child: Text('Ingresar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: SizedBox(
                                width: 200,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                    });
                                  },
                                  color: Color(0xFFA480F2),//Color(0xFFA480F2),
                                  child: Text('Registrarse',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            
        //  decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/bojack-2.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
      ),
    );
  }
}