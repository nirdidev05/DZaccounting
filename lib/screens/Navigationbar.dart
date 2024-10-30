import 'package:flutter/material.dart';

import '../Classes/cons.dart';
import 'BankAccount.dart';
import 'Dashboard.dart';
import 'Items_page.dart';
import 'Purachase_Page.dart';
import '../Reports.dart';
import 'Sales_page.dart';
import 'Settings_Page.dart';

class NavigationBAR extends StatefulWidget {
  @override
  _NavigationBARState createState() => _NavigationBARState();
}

class _NavigationBARState extends State<NavigationBAR> {
  int _selectedIndex = 0;
  bool _isExtended = false;
  final List<Map<String, dynamic>> _screens = [
    {'screen': Dashboard(), 'title': 'Dashboard', 'icon': Icons.home_filled},
    {'screen': Items(), 'title': 'Items', 'icon': Icons.point_of_sale},
    {'screen': Sales(), 'title': 'Invoices', 'icon': Icons.attach_money},
    {'screen': VendorPage(), 'title': 'Purchases', 'icon': Icons.shopping_cart},
    {
      'screen': BankAccountForm(),
      'title': 'Bank Account',
      'icon': Icons.account_balance
    },
    {'screen': Reports(), 'title': 'Reports', 'icon': Icons.insert_chart},
    {'screen': SettingsPage(), 'title': 'Settings', 'icon': Icons.settings},

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 85) {
            // Use side-by-side layout for larger screens
            return Row(
              children: [
                Container(
                  width: 85,
                  child: NavigationRail(
                    selectedIconTheme: IconThemeData(color: Color(0xFF1565C0)),
                    backgroundColor: Colors.white,
                    labelType: NavigationRailLabelType.selected,
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    extended: _isExtended,
                    destinations: _screens
                        .map(
                          (screen) => NavigationRailDestination(
                        icon: Icon(
                          screen['icon'],
                          color: Color(0xFF1565C0),
                        ),
                        label: Text(screen['title'], style: TextStyle(color:Color(0xFF1565C0))),
                      ),
                    )
                        .toList(),
                  ),
                ),
                VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _screens[_selectedIndex]['screen']),
              ],
            );
          } else {
            // Use bottom navigation bar for smaller screens
            return Column(
              children: [
                Expanded(child: _screens[_selectedIndex]['screen']),
                BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  selectedItemColor: Color(0xFF1565C0),
                  items: _screens
                      .map(
                        (screen) => BottomNavigationBarItem(
                      icon: Icon(screen['icon']),
                      label: screen['title'],
                    ),
                  )
                      .toList(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
