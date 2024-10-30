import 'package:flutter/material.dart';
import '../Classes/cons.dart';
import 'Navigationbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Screen',
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _PasswordVisible = false;
  bool _acceptedConditions=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: 70,
          width: double.infinity,
          padding: const EdgeInsets.all(defaultSpace / 2),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.black12, width: .7)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultSpace),
                child: Row(
                  children: const [
                    Text(
                      "DZ",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "ACCOUNTING",
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/laptop-tablet-phone-along-with-graphics.jpg'),
                    fit: BoxFit.cover,

                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                              text: 'Use software solutions to help your business ',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF56A2E8),
                              ),
                            ),
                            TextSpan(
                              text: 'succeed',
                              style: TextStyle(
                                fontSize: 35.1,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEEBA2B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Image.network(
                        'https://img.freepik.com/vecteurs-libre/gestionnaires-demarrage-presentant-analysant-graphique-croissance-ventes-groupe-travailleurs-tas-argent-fusee-diagrammes-barres-fleche-tas-argent_74855-14166.jpg?size=626&ext=jpg&ga=GA1.2.685828303.1681213685&semt=sph',
                        width: 1000,
                        height: 200,
                      ),


                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your fullname',
                          labelText: 'Username',
                          labelStyle: TextStyle(

                          ),
                          hintStyle:TextStyle(
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '   @gmail.com',
                          labelText: 'Email',
                          labelStyle: TextStyle(

                          ),
                          hintStyle:TextStyle(
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                          ),
                        ),
                      ),

                      SizedBox(height: 10,width:50),

                      TextField(
                        obscureText: ! _PasswordVisible,                        decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _PasswordVisible ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _PasswordVisible = ! _PasswordVisible;
                            });
                          },
                        ),


                        labelStyle: TextStyle(

                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCB6CE6),
                          ),
                        ),
                      ),
                      ),
                      SizedBox(height: 20),
                      CheckboxListTile(
                        title: Text('I accept the application conditions'),
                        value: _acceptedConditions,
                        onChanged: (value) {
                          setState(() {
                            _acceptedConditions = value!;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _acceptedConditions ? _handleSignUp : null;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationBAR()),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 19, // Set the font size
                            fontWeight: FontWeight.bold, // Set the font weight
                            color: Colors.white, // Set the text color
                          ),
                        ),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(200, 50)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                            },
                            icon: Image.network('https://img.freepik.com/icones-gratuites/rechercher_318-265146.jpg?size=626&ext=jpg&ga=GA1.2.685828303.1681213685&semt=ais', height: 30),
                            label: Text(
                                'Google',
                                style: TextStyle(
                                  color: Colors.blue,

                                )
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white24,

                            ),


                          ),
                          SizedBox(width: 30),
                          ElevatedButton.icon(
                            onPressed: () {
                            },
                            icon: Image.network('https://img.freepik.com/icones-gratuites/twitter_318-566762.jpg?size=626&ext=jpg&ga=GA1.1.685828303.1681213685&semt=ais', height: 30),
                            label: Text(
                                'Twitter',
                                style: TextStyle(
                                  color: Colors.blue,

                                )
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white24,

                            ),


                          ),            ],
                      ),
                    ],

                  ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _handleSignUp() {
    // Perform the sign-up action here
  }
}
