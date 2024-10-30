import 'package:flutter/material.dart';
import 'package:untitled4/update_bank.dart';

import 'Navigationbar.dart';
import 'Reports_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedCategory = '';
  bool _passwordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;
  TextEditingController _reportController = TextEditingController();
  bool writingReport = false;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  List<String> reports = [];
  List<String> selectedReports = []; // Added selectedReports list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  _buildSettingsItem('Account Settings'),
                  _buildSettingsItem('Bank-Account'),
                  _buildSettingsItem('Language and Localization and Date'),
                  _buildSettingsItem('About Us'),
                  _buildSettingsItem('Send Reports'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey.shade200,
              child: _buildSettingsContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  Widget _buildSettingsContent() {
    if (selectedCategory == 'Account Settings') {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormField('Name', 'Enter your name'),
            SizedBox(height: 16.0),
            _buildFormField('New Phone Number', 'Enter your new phone number'),
            SizedBox(height: 16.0),
            _buildFormField('Email', 'user@example.com', enabled: false),
            SizedBox(height: 16.0),
            _buildPasswordField('Password', 'Enter your password'),
            SizedBox(height: 16.0),
            _buildPasswordField('New Password', 'Enter your new password'),
            SizedBox(height: 16.0),
            _buildPasswordField(
              'Confirm Password',
              'Confirm your new password',
            ),
            SizedBox(height: 16.0),
            _buildFormField('Bio', 'Enter your bio'),
            SizedBox(height: 16.0),
            _buildFormField('Expectations', 'Enter your expectations'),
            SizedBox(height: 16.0),
            _buildFormField('Goals', 'Enter your goals'),
            SizedBox(height: 16.0),
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            _buildNotificationCheckbox('Weekly Reports'),
            _buildNotificationCheckbox('Top Up Success'),
            _buildNotificationCheckbox('Password Change'),
            _buildNotificationCheckbox('Payment Success'),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _saveChanges();
                  },
                  child: Text('Save Changes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _cancelChanges();
                  },
                  child: Text('Cancel Changes'),
                ),
              ],
            ),
          ],
        ),
      );

    } else if (selectedCategory == 'Bank-Account') {
      return BankAccountForme();
    } else if (selectedCategory == 'Language and Localization and Date') {
      return _buildLocalizationContent();
    } else if (selectedCategory == 'About Us') {
      return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/rm222-mind-16.jpg"),
          fit: BoxFit.cover,
        ),
      ),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Who are we'),
                subtitle: Text("Welcome to our DZAccounting web app, our exciting project that emerged from a simple yet powerful idea. Originally, we wanted to create an app to help people better manage their financial resources. However, our vision quickly grew and evolved into a dedicated website for small businesses looking to improve their accounting, purchase and sales tracking, and expense management also to digitize and make it easier to operate. of their activity."),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              child: ListTile(
                title: Text('our objectif'),
                subtitle: Text("The fundamental objective of DZAccounting is to provide small businesses with a complete and intuitive tool to help them take control of their financial management. By transforming our project into a website, we can offer a platform accessible from any browser, allowing entrepreneurs to easily access their financial information, wherever they are."),
              ),
            ),

          ],
        ),
      );
    } else if (selectedCategory == 'Send Reports') {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Reports',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            CheckboxListTile(
              title: Text('Write Report'),
              value: writingReport,
              onChanged: (value) {
                setState(() {
                  writingReport = value ?? false;
                });
              },
            ),
            if (writingReport)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _reportController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter your report',
                  ),
                ),
              )
            else
              Column(
                children: [
                  _buildReportCheckbox('Bug Report'),
                  _buildReportCheckbox('Feature Request'),
                  _buildReportCheckbox('Performance Issue'),
                ],
              ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (writingReport) {
                      String report = _reportController.text;
                      _saveReport(report);
                    } else {
                      List<String> selectedReports = _getSelectedReports();
                      _saveReports(selectedReports);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportsPage(
                          reports: writingReport ? [_reportController.text] : selectedReports,
                        ),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationBAR(),
                        ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildFormField(String label, String hintText, {bool enabled = true}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            enabled: enabled,
            readOnly: !enabled,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPasswordField(String label, String hintText) {
    TextEditingController? controller;
    bool isPasswordVisible = false;
    Widget suffixIcon = const SizedBox(); // Empty placeholder widget

    if (label == 'Password') {
      controller = _passwordController;
      isPasswordVisible = _passwordVisible;
    } else if (label == 'New Password') {
      controller = _newPasswordController;
      isPasswordVisible = _newPasswordVisible;
    } else if (label == 'Confirm Password') {
      controller = _confirmPasswordController;
      isPasswordVisible = _confirmPasswordVisible;
    }

    suffixIcon = IconButton(
      icon: Icon(
        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: () {
        setState(() {
          if (label == 'Password') {
            _passwordVisible = !_passwordVisible;
          } else if (label == 'New Password') {
            _newPasswordVisible = !_newPasswordVisible;
          } else if (label == 'Confirm Password') {
            _confirmPasswordVisible = !_confirmPasswordVisible;
          }
        });
      },
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: controller,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildLocalizationContent() {
    List<String> languages = [
      'English',
      'Spanish',
      'French',
      'German',
      'Italian',
      'Chinese',
      'Japanese',
      'Korean',
      'Arabic',
      'Russian',
    ];

    List<String> localizations = [
      'United States',
      'United Kingdom',
      'Canada',
      'Australia',
      'Germany',
      'France',
      'Italy',
      'Spain',
      'Japan',
      'China',
      'Mexico',
      'Brazil',
      'India',
      'South Korea',
      'Russia',
      'Saudi Arabia',
      'United Arab Emirates',
      'Egypt',
      'South Africa',
      'Nigeria',
      'Kenya',
      'Argentina',
      'Chile',
      'Colombia',
      'Peru',
      'Sweden',
      'Norway',
      'Finland',
      'Denmark',
      'Netherlands',
    ];

    List<String> dateFormats = [
      'MM/dd/yyyy',
      'dd/MM/yyyy',
      'yyyy/MM/dd',
      'MM-dd-yyyy',
      'dd-MM-yyyy',
      'yyyy-MM-dd',
      'MMMM dd, yyyy',
      'dd MMMM, yyyy',
      'yyyy MMMM dd',
    ];
    String selectedLanguage = languages[0];
    String selectedLocalization = localizations[0];
    String selectedDateFormat = dateFormats[0];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Localization',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          // Language selection dropdown
          DropdownButtonFormField<String>(
            value: selectedLanguage,
            hint: Text('Select Language'),
            items: languages.map((String language) {
              return DropdownMenuItem<String>(
                value: language,
                child: Text(language),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedLanguage = value ?? '';
              });
            },
          ),
          SizedBox(height: 16.0),
          // Localization selection dropdown
          DropdownButtonFormField<String>(
            value: selectedLocalization,
            hint: Text('Select Localization'),
            items: localizations.map((String localization) {
              return DropdownMenuItem<String>(
                value: localization,
                child: Text(localization),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedLocalization = value ?? '';
              });
            },
          ),
          SizedBox(height: 16.0),
          // Date format selection dropdown
          DropdownButtonFormField<String>(
            value: selectedDateFormat,
            hint: Text('Select Date Format'),
            items: dateFormats.map((String dateFormat) {
              return DropdownMenuItem<String>(
                value: dateFormat,
                child: Text(dateFormat),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedDateFormat = value ?? '';
              });
            },
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Changes saved successfully!'),
                    ),
                  );
                },
                child: Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Reset form data
                  setState(() {
                    selectedLanguage = '';
                    selectedLocalization = '';
                    selectedDateFormat = '';
                  });

                  // Show a message or perform any other required actions
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Changes canceled!'),
                    ),
                  );
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCheckbox(String title) {
    bool isSelected = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ListTile(
          title: Text(title),
          trailing: Icon(
            isSelected ? Icons.check_box : Icons.check_box_outline_blank,
            color: isSelected ? Colors.blue : null,
          ),
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
        );
      },
    );
  }

  void _saveChanges() {
    // Save changes logic here

    // Show a success message or perform any other required actions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Changes saved successfully!'),
      ),
    );
  }

  void _cancelChanges() {
    // Reset form data
    setState(() {
      selectedCategory = '';
    });

    // Clear text fields and other form fields
    // Add your code here to clear the form fields
  }

  Widget _buildReportCheckbox(String title) {
    return CheckboxListTile(
      title: Text(title),
      value: selectedReports.contains(title),
      onChanged: (value) {
        setState(() {
          if (value != null && value) {
            selectedReports.add(title);
          } else {
            selectedReports.remove(title);
          }
        });
      },
    );
  }

  List<String> _getSelectedReports() {
    return selectedReports;
  }

  void _saveReports(List<String> reports) {
    // TODO: Implement logic to save the selected reports
    // Here, you can add the `reports` to your reports table or perform any desired saving operation.
    print('Saving reports: $reports');
  }

  void _saveReport(String report) {
    // TODO: Implement logic to save the user-written report
    // Here, you can save the `report` to your reports table or perform any desired saving operation.
    print('Saving report: $report');
  }
}
