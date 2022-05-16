import 'package:finance_portfolio/components/bottom_navbar.dart';
import 'package:finance_portfolio/components/header/header.dart';
import 'package:finance_portfolio/components/portfolio/portfolio.dart';
import 'package:finance_portfolio/components/trending/trending.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 7540.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff24242a),
      bottomNavigationBar: const BottomNavigation(),
      body: _content(),
    );
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(balance: balance.toString()),
          const Trending(),
          const SizedBox(
            height: 30,
          ),
          const Portfolio(),
        ],
      ),
    );
  }
}
