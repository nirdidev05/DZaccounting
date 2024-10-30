import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'screens/Navigationbar.dart';
import 'screens/Settings_Page.dart';

class BankAccountForme extends StatefulWidget {
  @override
  _BankAccountFormState createState() => _BankAccountFormState();
}

class _BankAccountFormState extends State<BankAccountForme> {
  TextEditingController _numberOfAccountsController = TextEditingController();
  int _numberOfAccounts = 0;
  bool _isTextFieldFocused = false;
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _numberOfAccountsController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _navigateToAccountForms() {
    if (_numberOfAccounts <= 0) {
      _showValidationMessage('Please enter a number greater than 0.');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountCreationPag(
          numberOfAccounts: _numberOfAccounts,
        ),
      ),
    );
  }

  void _showValidationMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/grey.jpg"),
              fit: BoxFit.cover,
            ),
          ),

        child: Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(5, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter the number of bank accounts:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _numberOfAccountsController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _numberOfAccounts = int.tryParse(value) ?? 0;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Number of Accounts',
                    labelStyle: TextStyle(
                      color: _isTextFieldFocused ? Colors.black87 : Colors.grey,
                    ),
                    hintText: 'Enter number',
                    hintStyle: TextStyle(
                      color: _isTextFieldFocused ? Colors.black87 : Colors.grey,
                    ),
                    focusedBorder: customBorder(),
                    enabledBorder: customBorder(),
                  ),
                  focusNode: _focusNode,
                  onTap: () {
                    setState(() {
                      _isTextFieldFocused = true;
                      _focusNode.requestFocus();
                    });
                  },
                  onSubmitted: (_) {
                    setState(() {
                      _isTextFieldFocused = false;
                      _focusNode.unfocus();
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _navigateToAccountForms,
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    Colors.purple, // Set the button color to purple
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder customBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: _isTextFieldFocused ? Colors.black : Colors.grey,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );
  }
}

class AccountCreationPag extends StatefulWidget {
  final int numberOfAccounts;

  const AccountCreationPag({Key? key, required this.numberOfAccounts})
      : super(key: key);

  @override
  _AccountCreationPageState createState() => _AccountCreationPageState();
}

class _AccountCreationPageState extends State<AccountCreationPag> {
  List<AccountFormModel> _accountForms = [];
  void _navigateToPreviewPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NavigationBAR(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _createAccountForms();
  }

  void _createAccountForms() {
    for (int i = 0; i < widget.numberOfAccounts; i++) {
      _accountForms.add(AccountFormModel());
    }
  }

  void _handleAccountFormUpdate(int index, AccountFormModel updatedForm) {
    setState(() {
      _accountForms[index] = updatedForm;
    });
  }

  bool _validateAccountForm() {
    for (AccountFormModel form in _accountForms) {
      if (form.accountNumber.isEmpty ||
          form.initialBalance <= 0 ||
          form.bankAccount.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void _showValidationMessage(List<String> errorMessages) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessages.join('\n'))),
    );
  }

  List<String> _getAccountFormErrors() {
    List<String> errorMessages = [];

    for (int i = 0; i < _accountForms.length; i++) {
      AccountFormModel form = _accountForms[i];

      if (form.accountNumber.isEmpty) {
        errorMessages.add('Account ${i + 1}: Account number is required.');
      }

      if (form.initialBalance <= 0) {
        errorMessages
            .add('Account ${i + 1}: Initial balance must be greater than 0.');
      }

      if (form.bankAccount.isEmpty) {
        errorMessages.add('Account ${i + 1}: Bank account is required.');
      }
    }

    return errorMessages;
  }

  void _validateAndNavigate() {
    List<String> errorMessages = _validateAccountForm() as List<String>;

    if (errorMessages.isEmpty) {
      _navigateToPreviewPage();
    } else {
      _showValidationMessage(errorMessages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/grey.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: _accountForms.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: AccountForm(
                formIndex: index,
                accountFormModel: _accountForms[index],
                onUpdate: _handleAccountFormUpdate,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<String> errorMessages = _getAccountFormErrors();

          if (errorMessages.isEmpty) {
            _navigateToPreviewPage();
          } else {
            _showValidationMessage(errorMessages);
          }
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.check, color: Colors.purpleAccent),
      ),
    );
  }
}

class AccountForm extends StatefulWidget {
  final int formIndex;
  final AccountFormModel accountFormModel;
  final Function(int, AccountFormModel) onUpdate;

  const AccountForm({
    Key? key,
    required this.formIndex,
    required this.accountFormModel,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _AccountFormState createState() => _AccountFormState();
}
class _AccountFormState extends State<AccountForm> {
  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _initialBalanceController = TextEditingController();
  TextEditingController _bankAccountController = TextEditingController();

  bool _isAccountNumberValid = true;
  bool _isInitialBalanceValid = true;
  bool _isBankAccountValid = true;

  List<String> _currencyList = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'AUD',
    'CAD',
    'CHF',
    'CNY',
    'SEK',
    'NZD',
  ];
  String _selectedCurrency = 'USD';

  @override
  void dispose() {
    _accountNumberController.dispose();
    _initialBalanceController.dispose();
    _bankAccountController.dispose();
    super.dispose();
  }

  void _handleLogoSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Bank Logo URL'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                widget.accountFormModel.bankLogoUrl = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Bank Logo URL',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                bool isValid =
                await _validateLogoUrl(widget.accountFormModel.bankLogoUrl);
                if (isValid) {
                  setState(() {
                    widget.accountFormModel.bankLogoFile = null;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _validateLogoUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        return true;
      } else {
        // Photo does not exist or URL is invalid
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid URL'),
              content: Text('The provided URL does not point to a valid photo.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return false;
      }
    } catch (e) {
      // Error occurred while validating the URL
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while validating the URL.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
  }

  void _updateFormModel() {
    AccountFormModel updatedForm = AccountFormModel();
    updatedForm.accountNumber = _accountNumberController.text;
    updatedForm.initialBalance =
        double.tryParse(_initialBalanceController.text) ?? 0.0;
    updatedForm.bankAccount = _bankAccountController.text;
    updatedForm.bankLogoUrl = widget.accountFormModel.bankLogoUrl;
    updatedForm.bankLogoFile = widget.accountFormModel.bankLogoFile;

    bool isAccountNumberValid = updatedForm.accountNumber.isNotEmpty;
    bool isInitialBalanceValid = updatedForm.initialBalance > 0;
    bool isBankAccountValid = updatedForm.bankAccount.isNotEmpty;

    setState(() {
      _isAccountNumberValid = isAccountNumberValid;
      _isInitialBalanceValid = isInitialBalanceValid;
      _isBankAccountValid = isBankAccountValid;

      if (isAccountNumberValid &&
          isInitialBalanceValid &&
          isBankAccountValid) {
        widget.onUpdate(widget.formIndex, updatedForm);
      }
    });

    if (!isAccountNumberValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid account number in Account ${widget.formIndex + 1}'),
        ),
      );
    } else if (!isInitialBalanceValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid initial balance in Account ${widget.formIndex + 1}'),
        ),
      );
    } else if (!isBankAccountValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid bank account in Account ${widget.formIndex + 1}'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _accountNumberController.text = widget.accountFormModel.accountNumber;
    _initialBalanceController.text =
        widget.accountFormModel.initialBalance.toString();
    _bankAccountController.text = widget.accountFormModel.bankAccount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(10, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account ${widget.formIndex + 1}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _accountNumberController,
                    onChanged: (_) => _updateFormModel(),
                    decoration: InputDecoration(
                      labelText: 'Account Number',
                      border: OutlineInputBorder(),
                      errorText: _isAccountNumberValid ? null : 'Invalid account number',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _initialBalanceController,
                    onChanged: (_) => _updateFormModel(),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Initial Balance',
                      border: OutlineInputBorder(),
                      errorText: _isInitialBalanceValid ? null : 'Invalid initial balance',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _bankAccountController,
                    onChanged: (_) => _updateFormModel(),
                    decoration: InputDecoration(
                      labelText: 'Bank Account Name',
                      border: OutlineInputBorder(),
                      errorText: _isBankAccountValid ? null : 'Invalid bank account name',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _handleLogoSelection,
                        child: Text('Select Logo'),
                      ),
                      SizedBox(width: 16.0),
                      DropdownButton<String>(
                        value: _selectedCurrency,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCurrency = newValue!;
                          });
                        },
                        items: _currencyList.map((currency) {
                          return DropdownMenuItem<String>(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AccountFormModel {
  String accountNumber = '';
  double initialBalance = 0.0;
  String bankAccount = '';
  String bankLogoUrl = ''; // New property for bank logo URL
  File? bankLogoFile;
}

class TransactionModel {
  final String date;
  final String bankName;
  final String type;
  final String category;
  final String credit;
  final String accountNumber;
  final String nameOfOther;
  final int transactionNumber;

  TransactionModel({
    required this.date,
    required this.bankName,
    required this.type,
    required this.category,
    required this.credit,
    required this.accountNumber,
    required this.nameOfOther,
    required this.transactionNumber,
  });
}

