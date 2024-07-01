// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AccountScreen(),
    );
  }
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isSignUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/rwanda_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Discover Rwanda',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isSignUp = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isSignUp ? Colors.black : Colors.grey,
                          ),
                          child: const Text('Sign up'),
                        ),
                        const SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isSignUp = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                !isSignUp ? Color.fromARGB(255, 27, 29, 82) : Colors.grey,
                          ),
                          child: const Text('Log in'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      isSignUp ? 'Create an account' : 'Welcome back!',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 20),
                    if (isSignUp)
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Full name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    if (isSignUp) const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.visibility),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (isSignUp) const SizedBox(height: 20),
                    if (isSignUp)
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Re-enter Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.visibility),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    if (!isSignUp) const SizedBox(height: 10),
                    if (!isSignUp)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: true, onChanged: (bool? value) {}),
                              const Text('Remember Password'),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Forget Password?'),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                      ),
                      child: Text(isSignUp ? 'Sign up' : 'Log in'),
                    ),
                    const SizedBox(height: 20),
                    Text('Or ${isSignUp ? 'sign up' : 'log in'} with'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.google),
                          onPressed: () {},
                          iconSize: 30,
                        ),
                        const SizedBox(width: 40),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.facebook),
                          onPressed: () {},
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
