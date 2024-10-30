import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BankAccountForm extends StatefulWidget {
  @override
  _BankAccountFormState createState() => _BankAccountFormState();
}

class _BankAccountFormState extends State<BankAccountForm> {
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
        builder: (context) => AccountCreationPage(
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
                  color: Colors.blue.withOpacity(0.3),
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
                        Color(0xFF0845ff), // Set the button color to purple
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

class AccountCreationPage extends StatefulWidget {
  final int numberOfAccounts;

  const AccountCreationPage({Key? key, required this.numberOfAccounts})
      : super(key: key);

  @override
  _AccountCreationPageState createState() => _AccountCreationPageState();
}

class _AccountCreationPageState extends State<AccountCreationPage> {
  List<AccountFormModel> _accountForms = [];
  void _navigateToPreviewPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewPage(accountForms: _accountForms),
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
          form.bankAccount.isEmpty ||
          form.accountName.isEmpty) {
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
      if (form.accountName.isEmpty) {
        errorMessages.add('Account ${i + 1}: Bank account name is required.');
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
        child: Icon(Icons.check, color: Color(0xFF0845ff)),
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
  TextEditingController _bankAccountNameController = TextEditingController();

  bool _isAccountNumberValid = true;
  bool _isInitialBalanceValid = true;
  bool _isBankAccountValid = true;
  bool _isAccountNameValid = true;

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
              content:
                  Text('The provided URL does not point to a valid photo.'),
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
    updatedForm.accountName = _bankAccountNameController.text;
    updatedForm.bankLogoUrl = widget.accountFormModel.bankLogoUrl;
    updatedForm.bankLogoFile = widget.accountFormModel.bankLogoFile;

    bool isAccountNumberValid = updatedForm.accountNumber.isNotEmpty;
    bool isInitialBalanceValid = updatedForm.initialBalance > 0;
    bool isBankAccountValid = updatedForm.bankAccount.isNotEmpty;
    bool isBankAccountNameValid = updatedForm.accountName.isNotEmpty;
    setState(() {
      _isAccountNumberValid = isAccountNumberValid;
      _isInitialBalanceValid = isInitialBalanceValid;
      _isBankAccountValid = isBankAccountValid;

      if (isAccountNumberValid && isInitialBalanceValid && isBankAccountValid) {
        widget.onUpdate(widget.formIndex, updatedForm);
      }
    });

    if (!isAccountNumberValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Invalid account number in Account ${widget.formIndex + 1}'),
        ),
      );
    } else if (!isInitialBalanceValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Invalid initial balance in Account ${widget.formIndex + 1}'),
        ),
      );
    } else if (!isBankAccountValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Invalid bank account in Account ${widget.formIndex + 1}'),
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
    _bankAccountNameController.text = widget.accountFormModel.accountName;
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
            icon: Icon(Icons.arrow_back, color: Colors.blue),
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
                  color: Colors.blue.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(5, 3),
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
                      errorText: _isAccountNumberValid
                          ? null
                          : 'Invalid account number',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _initialBalanceController,
                    onChanged: (_) => _updateFormModel(),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Initial Balance',
                      border: OutlineInputBorder(),
                      errorText: _isInitialBalanceValid
                          ? null
                          : 'Invalid initial balance',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _bankAccountController,
                    onChanged: (_) => _updateFormModel(),
                    decoration: InputDecoration(
                      labelText: 'Bank Name',
                      border: OutlineInputBorder(),
                      errorText:
                          _isBankAccountValid ? null : 'Invalid bank name',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _bankAccountNameController,
                    onChanged: (_) => _updateFormModel(),
                    decoration: InputDecoration(
                      labelText: 'Bank Account Name',
                      border: OutlineInputBorder(),
                      errorText: _isAccountNameValid
                          ? null
                          : 'Invalid bank account name',
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
  String accountName = '';
  String bankAccount = '';
  String cureency = '';
  double initialBalance = 0.0;
  String bankLogoUrl = '';
  File? bankLogoFile;
}

class TransactionModel {
  late final String date;
  late final String bankName;
  late final String type;
  late final String category;
  late final String credit;
  late final String accountNumber;
  late final String nameOfOther;
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

class PreviewPage extends StatefulWidget {
  final List<AccountFormModel> accountForms;

  const PreviewPage({Key? key, required this.accountForms}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  List<String> customBankAccounts = [];
  List<TransactionModel> transactions = [];
  int transactionCount = 0;
  String? selectedSortOption = 'date';
  String? selectedTypeOption;
  String? selectedCategoryOption;
  String? selectedFilterOption;

  @override
  void initState() {
    super.initState();
    customBankAccounts = List.generate(widget.accountForms.length, (_) => '');
  }

  List<TransactionModel> getFilteredTransactions() {
    return transactions.where((transaction) {
      // Apply the selected type and category filters
      bool isTypeMatched =
          selectedTypeOption == null || transaction.type == selectedTypeOption;
      bool isCategoryMatched = selectedCategoryOption == null ||
          transaction.category == selectedCategoryOption;

      return isTypeMatched && isCategoryMatched;
    }).toList();
  }

  List<TransactionModel> getFilteredTransactionsWithFilter() {
    return transactions.where((transaction) {
      // Apply the selected filter
      if (selectedFilterOption == 'pay') {
        return transaction.type == 'Pay';
      } else if (selectedFilterOption == 'receive') {
        return transaction.type == 'Receive';
      } else if (selectedFilterOption == 'cash') {
        return transaction.category == 'Cash';
      } else if (selectedFilterOption == 'cheque') {
        return transaction.category == 'Cheque';
      } else {
        return true; // Return all transactions for other filters
      }
    }).toList();
  }

  void sortTransactions(String sortOption) {
    setState(() {
      selectedSortOption = sortOption;
      transactions.sort((a, b) {
        switch (selectedSortOption) {
          case 'date':
            return a.date.compareTo(b.date);
          case 'credit':
            return a.credit.compareTo(b.credit);
          default:
            return 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalNetWorth = widget.accountForms
        .fold(0, (sum, account) => sum + account.initialBalance);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/grey.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Total Net Worth: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\$${totalNetWorth.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      for (int index = 0;
                          index < widget.accountForms.length;
                          index++)
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Colors.blue.shade400,

                              child: SizedBox(
                                height: 200,
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            title: Text(
                                              '${widget.accountForms[index].bankAccount} Account',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Account Number: ${widget.accountForms[index].accountNumber}',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    Text(
                                                      '${widget.accountForms[index].accountName}',
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      'Balance: \$${widget.accountForms[index].initialBalance.toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              _showCustomBankAccountDialog(
                                                  index);
                                            },
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 40,
                                              backgroundImage: widget
                                                      .accountForms[index]
                                                      .bankLogoUrl
                                                      .isNotEmpty
                                                  ? NetworkImage(widget
                                                      .accountForms[index]
                                                      .bankLogoUrl)
                                                  : null,
                                              child: widget.accountForms[index]
                                                      .bankLogoUrl.isEmpty
                                                  ? Icon(Icons
                                                      .image) // Placeholder icon if no logo is available
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 8.0,
                                      bottom: 8.0,
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          _showCustomBankAccountDialog(index);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                    ],
                  ),
SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "TRANSICTIONS TABLE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF0845ff),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Sorted by : ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 16.0),
                      DropdownButton<String>(
                        value: selectedSortOption,
                        onChanged: (String? newValue) {
                          sortTransactions(newValue!);
                        },
                        items: <String>[
                          'date',
                          'credit',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(width: 980,),
                      Text(
                        'Filter:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 16.0),
                      DropdownButton<String>(
                        value: selectedCategoryOption,
                        onChanged: (value) {
                          setState(() {
                            selectedCategoryOption = value!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'All',
                            child: Text('All'),
                          ),
                          DropdownMenuItem(
                            value: 'Cheque',
                            child: Text('Cheque'),
                          ),
                          DropdownMenuItem(
                            value: 'Cash',
                            child: Text('Cash'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(height: 20.0),
                  Text(
                    'Transactions (${getFilteredTransactions().length})',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => Color(0xFF0845ff),
                      ),
                      columns: [
                        DataColumn(
                          label: Text(
                            'Date',
                            style: TextStyle(color: Colors.white60),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Bank Name',
                            style: TextStyle(color: Colors.white60),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Type',
                            style: TextStyle(color: Colors.white60),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Category',
                            style: TextStyle(color: Colors.white60),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Credit',
                            style: TextStyle(color: Colors.white60),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Account Number',
                            style: TextStyle(color: Colors.white60),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name of the Other',
                            style: TextStyle(color: Colors.white60),
                          ),
                        ),
                      ],
                      rows: getFilteredTransactions().map((transaction) {
                        return DataRow(cells: [
                          DataCell(Text(transaction.date)),
                          DataCell(Text(transaction.bankName)),
                          DataCell(Text(transaction.type)),
                          DataCell(Text(transaction.category)),
                          DataCell(Text(transaction.credit)),
                          DataCell(Text(transaction.accountNumber)),
                          DataCell(Text(transaction.nameOfOther)),
                        ], onSelectChanged: (selected) {
                          if (selected == true) {
                            showTransactionDetails(transaction);
                          }
                        });
                      }).toList(),

                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _showTransactionDialog();
                    },
                    child: Text('Add Transaction'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0845ff),
                        fixedSize:
                            Size(150, 30) // Replace with your desired color
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomBankAccountDialog(int index) async {
    TextEditingController accountNameController = TextEditingController();
    TextEditingController bankNameAccountController = TextEditingController();
    TextEditingController accountNumberController = TextEditingController();
    TextEditingController initialBalanceController = TextEditingController();
    TextEditingController bankLogoController = TextEditingController();

    // Set initial values in the text fields
    accountNameController.text = widget.accountForms[index].bankAccount;
    accountNameController.text = widget.accountForms[index].accountName;
    accountNumberController.text = widget.accountForms[index].accountNumber;
    initialBalanceController.text =
        widget.accountForms[index].initialBalance.toString();
    bankLogoController.text = widget.accountForms[index].bankLogoUrl;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Bank Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: accountNameController,
                decoration: InputDecoration(labelText: 'Bank Name'),
              ),
              TextField(
                controller: bankNameAccountController,
                decoration: InputDecoration(labelText: 'Account Name'),
              ),
              TextField(
                controller: accountNumberController,
                decoration: InputDecoration(labelText: 'Account Number'),
              ),
              TextField(
                controller: initialBalanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Initial Balance'),
              ),
              TextField(
                controller: bankLogoController,
                decoration: InputDecoration(labelText: 'Bank Logo URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF0845ff)),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Validate bank logo URL existence
                bool isLogoUrlValid =
                    await _checkImageUrlExists(bankLogoController.text);

                if (isLogoUrlValid) {
                  setState(() {
                    widget.accountForms[index].bankAccount =
                        accountNameController.text;
                    widget.accountForms[index].accountName =
                        bankNameAccountController.text;
                    widget.accountForms[index].accountNumber =
                        accountNumberController.text;
                    widget.accountForms[index].initialBalance =
                        double.parse(initialBalanceController.text);
                    widget.accountForms[index].bankLogoUrl =
                        bankLogoController.text;
                  });

                  Navigator.of(context).pop();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Bank Logo URL'),
                        content: Text(
                            'The provided bank logo URL is invalid or does not exist.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(color: Color(0xFF0845ff)),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Color(0xFF0845ff)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _checkImageUrlExists(String imageUrl) async {
    if (imageUrl.isEmpty) return false;

    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void _showTransactionDialog() {
    TextEditingController bankNameController = TextEditingController();
    TextEditingController creditController = TextEditingController();
    TextEditingController accountNumberController = TextEditingController();
    TextEditingController nameOfOtherController = TextEditingController();

    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    String? selectedTransactionType = 'pay'; // Assign a default value
    String? selectedTransactioncategory = 'cheque';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Transaction'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Date: $formattedDate'),
                TextField(
                  controller: bankNameController,
                  decoration: InputDecoration(labelText: 'Bank Name'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedTransactionType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedTransactionType = newValue ?? '';
                    });
                  },
                  items: ['pay', 'receive'].map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Type'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedTransactioncategory,
                  onChanged: (newValue) {
                    setState(() {
                      selectedTransactioncategory = newValue ?? '';
                    });
                  },
                  items: ['cheque', 'cash'].map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: creditController,
                  decoration: InputDecoration(labelText: 'Credit'),
                ),
                TextField(
                  controller: accountNumberController,
                  decoration: InputDecoration(labelText: 'Account Number'),
                ),
                TextField(
                  controller: nameOfOtherController,
                  decoration: InputDecoration(labelText: 'Name of the Other'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF0845ff)),
              ),
            ),
            TextButton(
              onPressed: () {
                String bankName = bankNameController.text.trim();
                String credit = creditController.text.trim();

                // Validate bank name
                List<String> existingBankNames = widget.accountForms
                    .map((form) => form.bankAccount)
                    .toList();

                if (bankName.isEmpty || !existingBankNames.contains(bankName)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Bank Name'),
                        content: Text(
                          'Please enter a valid bank name from the existing bank accounts.',
                          style: TextStyle(color: Color(0xFF0845ff)),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(color: Color(0xFF0845ff)),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  return; // Exit the method if the bank name is invalid
                }

                // Validate credit
                if (credit.isEmpty || !isNumeric(credit)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Credit'),
                        content: Text(
                          'Please enter a single numeric character for the credit.',
                          style: TextStyle(color: Color(0xFF0845ff)),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(color: Color(0xFF0845ff)),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  return; // Exit the method if the credit is invalid
                }

                String transactionType = selectedTransactionType ??
                    '';
                String transactioncategory = selectedTransactioncategory ?? '';
                AccountFormModel bankAccount = widget.accountForms.firstWhere(
                  (account) => account.bankAccount == bankName,
                  orElse: () =>
                      AccountFormModel(),
                );

                if (bankAccount != null) {
                  if (transactionType == 'pay') {
                    double newBalance =
                        bankAccount.initialBalance - double.parse(credit);
                    bankAccount.initialBalance = newBalance;
                  } else if (transactionType == 'receive') {
                    double newBalance =
                        bankAccount.initialBalance + double.parse(credit);
                    bankAccount.initialBalance = newBalance;
                  }
                }

                setState(() {
                  transactionCount++;
                  transactions.add(
                    TransactionModel(
                      date: formattedDate,
                      bankName: bankName,
                      type: transactionType,
                      category: transactioncategory,
                      credit: credit,
                      accountNumber: accountNumberController.text,
                      nameOfOther: nameOfOtherController.text,
                      transactionNumber: transactionCount,
                    ),
                  );
                });

                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: TextStyle(color: Color(0xFF0845ff)),
              ),
            ),
          ],
        );
      },
    );
  }
  void addTransaction(TransactionModel transaction) {
    setState(() {
      transactions.add(transaction);
    });
  }
  void showTransactionDetails(TransactionModel transaction) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Transaction Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Transaction Number: ${transaction.transactionNumber}'),
              Text('Bank Name: ${transaction.bankName}'),
              Text('Date: ${transaction.date}'),
              Text('Type: ${transaction.type}'),
              Text('Category: ${transaction.category}'),
              Text('Amount: ${transaction.credit}'),
              Text('Account Number: ${transaction.accountNumber}'),
              Text('Name Of Others Bank : ${transaction.nameOfOther}'),


            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                showEditDialog(transaction);
              },
              child: Text('Edit'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteTransaction(transaction);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
  void showEditDialog(TransactionModel transaction) {
    TextEditingController bankNameController =
    TextEditingController(text: transaction.bankName);
    TextEditingController otherController =
    TextEditingController(text: transaction.nameOfOther);
    TextEditingController numberController =
    TextEditingController(text: transaction.accountNumber);
    TextEditingController dateController =
    TextEditingController(text: transaction.date);
    TextEditingController typeController =
    TextEditingController(text: transaction.type);
    TextEditingController amountController =
    TextEditingController(text: transaction.credit.toString());
    TextEditingController categoryController =
    TextEditingController(text: transaction.category);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: bankNameController,
                decoration: InputDecoration(labelText: 'Bank Name'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
              TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'Type'),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Account number'),
              ),
              TextField(
                controller: otherController,
                decoration: InputDecoration(labelText: 'Other bank name'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Delete the existing transaction
                deleteTransaction(transaction);

                // Create a new transaction with updated values
                TransactionModel updatedTransaction = TransactionModel(
                  date: dateController.text,
                  bankName: bankNameController.text,
                  type: typeController.text,
                  category: categoryController.text,
                  credit: amountController.text,
                  accountNumber: numberController.text,
                  nameOfOther: otherController.text,
                  transactionNumber: transaction.transactionNumber,
                );

                // Add the updated transaction to the list
                addTransaction(updatedTransaction);

                Navigator.pop(context); // Close the edit dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void deleteTransaction(TransactionModel transaction) {
    setState(() {
      transactions.remove(transaction);
    });
    Navigator.pop(context); // Close the transaction details dialog
  }

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return int.tryParse(value) != null;
  }
}
