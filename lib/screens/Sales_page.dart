import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'dart:collection';
import '../Classes/Cale.dart';
import 'SaleDetailsPage.dart';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  List<Cale> sales = [];
  List<Customer> customurs = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _PhoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  bool _isEditing = false; // Flag to indicate whether the dialog is in edit mode or not
  Customer? _editingCustomer;
  int get index => 0;

  Widget _buildCard({
    required String title,
    required Color color,
    required IconData icon,
    required double number,
  }) {
    return MouseRegion(
      child: Card(
        elevation: 4.0,
        color: color,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 30.0,
                  color: Colors.white,
                ),
                SizedBox(width: 16.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 250),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    int salesListLength = e(sales).length;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/grey.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: LayoutBuilder(builder: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildCard(
                          title: 'All Sales',
                          color: Colors.blueAccent,
                          icon: Icons.shopping_cart,
                          number: sales.length.toDouble(),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: _buildCard(
                          title: 'Total Incomes from Sales',
                          color: Colors.blueAccent,
                          icon: Icons.attach_money,
                          number: calculateTotal(sales).toDouble(),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  _showAddCustomerDialog(); // Show add vendor dialog
                },
                child: Text('Add Customer'),
              ),
              SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: customurs.length,
                itemBuilder: (context, index) {
                  Customer customuer = customurs[index];
                  return ListTile(
                    title: Text(customuer.name),
                    subtitle: Text('Phone : ${customuer.Phone}'),
                    onTap: () {
                      _showCustomuerDetailsDialog(customuer); // Show vendor details dialog
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Sales Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 16.0),

                  SizedBox(width: 16.0),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.resolveWith(
                            (states) => Color(0xFF0845ff),
                      ),
                      columns: [
                        DataColumn(
                          label: Text('Sale Number', style: TextStyle(color: Colors.white60)),
                        ),
                        DataColumn(
                          label: Text('Date', style: TextStyle(color: Colors.white60)),
                        ),
                        DataColumn(
                          label: Text('Product Name', style: TextStyle(color: Colors.white60)),
                        ),
                        DataColumn(
                          label: Text('Quantity', style: TextStyle(color: Colors.white60)),
                        ),
                        DataColumn(
                          label: Text('Unity Price', style: TextStyle(color: Colors.white60)),
                        ),
                        DataColumn(
                          label: Text('Client Name', style: TextStyle(color: Colors.white60)),
                        ),
                        DataColumn(
                          label: Text('Case', style: TextStyle(color: Colors.white60)),
                        ),
                        DataColumn(
                          label: Text('Total Price', style: TextStyle(color: Colors.white60)),
                        ),
                        DataColumn(
                          label: Text('Reduction Amount', style: TextStyle(color: Colors.white60)),
                        ),
                      ],
                      rows: sales.asMap().entries.map((entry) {
                        final index = entry.key;
                        final sale = entry.value;
                        return DataRow(
                          onSelectChanged: (isSelected) {
                            if (isSelected!) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Sale Details'),
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Product Name: ${sale.product_name}'),
                                        Text('Case: ${sale.cas}'),
                                        Text('Client Name: ${sale.client_name}'),
                                        Text('Date: ${DateFormat('dd/MM/yyyy').format(sale.creationDate)}'),
                                        Text('Quantity: ${sale.quantity}'),
                                        Text('Unity Price: ${sale.unityprice}'),
                                        Text('Total Price: ${sale.price}'),
                                        Text('Reduction Amount: ${sale.reductionAmount}'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('Print'),
                                        onPressed: () {
                                          _navigateToSaleDetails(sale);
                                          },
                                      ),
                                      TextButton(
                                        child: Text('Delete'),
                                        onPressed: () {
                                          deleteSale(sale);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          cells: [
                            DataCell(Text(index.toString())),
                            DataCell(Text(DateFormat('dd/MM/yy').format(sale.creationDate))),
                            DataCell(Text(sale.product_name)),
                            DataCell(Text(sale.quantity.toString())),
                            DataCell(Text(sale.unityprice.toString())),
                            DataCell(Text(sale.client_name)),
                            DataCell(Text(sale.cas)),
                            DataCell(Text(sale.price.toString())),
                            DataCell(Text(sale.reductionAmount.toString())),
                          ],
                        );
                      }).toList(),

                  ),
                ),

              ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showAddItemDialog(); // Call the method to show the add sale dialog
                },
                child: Text('Add Sale'),
              ),
        ],
          ),
        ),
      ),
    );
  }
  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Customer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name', hintText: 'Enter Customuer name'),
              ),
              TextField(
                controller: _EmailController,
                decoration: InputDecoration(labelText: 'Email', hintText: ' @gmail.com'),
              ),
              TextField(
                controller: _PhoneController,
                decoration: InputDecoration(labelText: 'Contact Details', hintText: 'Enter Phone number'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address', hintText: 'Enter address'),
              ),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add the vendor to the list
                Customer newVendor = Customer(
                  name: _nameController.text,
                  Phone: _PhoneController.text,
                  Email: _EmailController.text,
                  address: _addressController.text,
                );
                setState(() {
                  customurs.add(newVendor);
                });
                _clearTextFields();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                _clearTextFields();
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
  void _clearTextFields() {
    _nameController.clear();
    _PhoneController.clear();
    _EmailController.clear();
    _addressController.clear();
  }
  Widget _buildClientWidget({
    required IconData icon,
    required Color color,
    required String label,
    required List<Cale> sale,
    required int i,
  }) {
    List<Pair> liste = [];
    liste = e(sale);

    String clientName;
    if (liste.length >= 3) {
      clientName = liste[i].client;
    } else {
      clientName = '';
    }
    return Column(
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          clientName,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }



  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String unitPrice = '';
        String quantity = '';
        String reduction = '';
        String product_name = '';
        String client = '';
        String? cas = 'Pending'; // Default value

        return AlertDialog(
          title: Text('Add Sale'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Product Name'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  product_name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  unitPrice = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  quantity = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Client Name'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  client = value;
                },
              ),
              DropdownButton<String>(
                value: cas,
                items: [
                  DropdownMenuItem(
                    value: 'Pending',
                    child: Text(
                      'Pending',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Delivered',
                    child: Text(
                      'Delivered',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    cas = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Reduction'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  reduction = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String date = DateTime.now().toString();
                String saleNumber = _generateSaleNumber();
                double unitPriceValue = double.tryParse(unitPrice) ?? 0.0;
                int quantityValue = int.tryParse(quantity) ?? 0;
                double reductionValue = double.tryParse(reduction) ?? 0.0;
                double totalPrice = (unitPriceValue * quantityValue) -
                    (unitPriceValue * quantityValue * reductionValue);

                addSales(
                    product_name,
                    client,
                    date,
                    saleNumber,
                    unitPriceValue,
                    quantityValue,
                    reductionValue,
                    totalPrice,
                    cas!);

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void addSales(String product,
      String client,
      String date,
      String saleNumber,
      double unitPrice,
      int quantity,
      double reduction,
      double totalPrice,
      String cas) {
    setState(() {
      if (product.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid product name.'),
          ),
        );
        return;
      }
      if(!doesCustomerExist(client)){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Customer does not exist.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showAddCustomerDialog();
                  },
                  child: Text('Create Customer'),
                ),
              ],
            );
          },
        );
      }
      if (client.isEmpty) {
        // Check if client name is empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid client name.'),
          ),
        );
        return;
      }
      if (quantity <= 0 || quantity != quantity.toInt()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid integer quantity.'),
          ),
        );
        return;
      }
      if (unitPrice <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid price.'),
          ),
        );
        return;
      }
      if (totalPrice <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid unity price.'),
          ),
        );
        return;
      }
      if (containsNumbers(product)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The product name should only contain characters.'),
          ),
        );
        return;
      }
      if (containsNumbers(client)) {
        // Check if client name contains numbers
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The client name should only contain characters.'),
          ),
        );
        return;
      }

      Cale sale = Cale(
        product_name: product,
        cas: cas,
        creationDate: DateTime.now(),
        quantity: quantity.toInt(),
        price: totalPrice,
        unityprice: unitPrice,
        client_name: client,
      );
      sales.add(sale);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sale added successfully.'),
        ),
      );
    });
  }

  bool containsNumbers(String text) {
    RegExp numericRegex = RegExp(r'[0-9]');
    return numericRegex.hasMatch(text);
  }

  String _generateSaleNumber() {
    int saleNumber = sales.length + 1;
    return saleNumber.toString();
  }



  void _showEditSaleDialog(BuildContext context, Cale sale) {
    String unitPrice = sale.unityprice.toString();
    String quantity = sale.quantity.toString();
    String reduction = sale.reductionAmount.toString();
    String product_name = sale.product_name;
    String client = sale.client_name;
    String? cas = sale.cas;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Sale'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Product Name'),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        product_name = value;
                      });
                    },
                    controller: TextEditingController(text: product_name),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Unit Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        unitPrice = value;
                      });
                    },
                    controller: TextEditingController(text: unitPrice),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        quantity = value;
                      });
                    },
                    controller: TextEditingController(text: quantity),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Client Name'),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        client = value;
                      });
                    },
                    controller: TextEditingController(text: client),
                  ),
                  DropdownButton<String>(
                    value: cas,
                    items: [
                      DropdownMenuItem(
                        value: 'Pending',
                        child: Text(
                          'Pending',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Delivered',
                        child: Text(
                          'Delivered',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        cas = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Reduction'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        reduction = value;
                      });
                    },
                    controller: TextEditingController(text: reduction),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    double unitPriceValue = double.tryParse(unitPrice) ?? 0.0;
                    int quantityValue = int.tryParse(quantity) ?? 0;
                    double reductionValue = double.tryParse(reduction) ?? 0.0;
                    double totalPrice = (unitPriceValue * quantityValue) -
                        (unitPriceValue * quantityValue * reductionValue);

                    editSale(
                      sale,
                      product_name,
                      client,
                      unitPriceValue,
                      quantityValue,
                      reductionValue,
                      totalPrice,
                      cas!,
                    );

                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Sale'),
                          content: Text(
                              'Are you sure you want to delete this sale?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                deleteSale(sale);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Delete'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void deleteSale(Cale sale) {
    setState(() {
      sales.remove(sale);
    });
  }

  void editSale(Cale sale,
      String product,
      String client,
      double unitPrice,
      int quantity,
      double reduction,
      double totalPrice,
      String cas,) {
    setState(() {
      if (product.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a product name')),
        );
      } else if (unitPrice <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid unit price')),
        );
      } else if (quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid quantity')),
        );
      } else if (client.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a client name')),
        );
      } else {
        // Remove the old sale item
        sales.remove(sale);

        // Create a new sale item with updated information
        Cale updatedSale = Cale(
          product_name: product,
          client_name: client,
          unityprice: unitPrice,
          quantity: quantity,
          reductionAmount: reduction,
          price: totalPrice,
          cas: cas,
          creationDate: DateTime.now(),
        );

        // Add the updated sale item to the data table
        sales.add(updatedSale);
      }
    });
  }

  List<Pair> e(List<Cale> mape) {
    Pair pair = new Pair();
    List<Pair> liste = [];
    Map<String, double> mape1 = calculateClientPercentages(mape);
    int k = 0;

    for (var entry in mape1.entries) {
      pair.client = entry.key;
      pair.pourcentage = entry.value;
      liste.add(pair);
      k = k + 1;

      if (k == 2) {
        break;
      }
    }
    return liste;
  }

  Map<String, double> calculateClientPercentages(List<Cale> sales) {
    Map<String, double> percentages = {};
    Map<String, num> clientSalesCount = {};
    double totalSales = 0;
    sales.forEach((sale) {
      totalSales += sale.price;
      if (clientSalesCount.containsKey(sale.client_name)) {
        clientSalesCount[sale.client_name] =
            (clientSalesCount[sale.client_name] ?? 0) + 1;
      } else {
        clientSalesCount[sale.client_name] = 1;
      }
    });
    clientSalesCount.forEach((clientName, salesCount) {
      double clientPercentage = (salesCount / sales.length) * 100;
      percentages[clientName] = clientPercentage;
    });
    var sortedEntries = percentages.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    var sortedPercentages =
    LinkedHashMap<String, double>.fromEntries(sortedEntries);

    return sortedPercentages;
  }

  int calculateTotal(List<Cale> list) {
    int sum = 0;
    list.forEach((element) {
      sum = sum + element.price.toInt();
    });
    return sum;
  }

  int calculateTotalQuantity(String clientName, List<Cale> sales) {
    int totalQuantity = 0;
    for (var sale in sales) {
      if (sale.client_name == clientName) {
        totalQuantity += sale.quantity;
      }
    }
    return totalQuantity;
  }

  double calculateTotalPrice(String clientName, List<Cale> sales) {
    double totalPrice = 0;
    for (var sale in sales) {
      if (sale.client_name == clientName) {
        totalPrice += sale.price;
      }
    }
    return totalPrice;
  }

  void _navigateToSaleDetails(Cale sale) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaleDetailsPage(sale: sale),
      ),
    );
  }

  Map<String, List<Cale>> generateSalesMap(List<Cale> sales) {
    Map<String, List<Cale>> salesMap = {};

    for (var sale in sales) {
      var client = sale.client_name;
      if (!salesMap.containsKey(client)) {
        salesMap[client] = [];
      }
      salesMap[client]!.add(sale);
    }

    return salesMap;
  }
  bool doesCustomerExist(String name) {
    return customurs.any((customuer) => customuer.name == name);
  }
  void _showCustomuerDetailsDialog(Customer customuer) {
      showDialog(
        context: context,
        builder: (context) {
          if (_isEditing && _editingCustomer == customuer) {
            // In edit mode
            return AlertDialog(
              title: Text('Edit Vendor'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: 'Name', hintText: 'Enter vendor name'),
                  ),
                  TextField(
                    controller: _EmailController,
                    decoration: InputDecoration(labelText: 'Email',
                        hintText: 'Enter the Email'),
                  ),
                  TextField(
                    controller: _PhoneController,
                    decoration: InputDecoration(labelText: 'Phone number',
                        hintText: 'Enter Phone number'),
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                        labelText: 'Address', hintText: 'Enter address'),
                  ),

                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Save the edited vendor information
                    setState(() {
                      customuer.name = _nameController.text;
                      customuer.Email = _EmailController.text;
                      customuer.Phone = _PhoneController.text;
                      customuer.address = _addressController.text;

                    });
                    _clearTextFields();
                    _isEditing = false;
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    _clearTextFields();
                    _isEditing = false;
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          } else {
            // View mode
            _nameController.text = customuer.name;
            _EmailController.text = customuer.Email;
            _PhoneController.text = customuer.Phone;
            _addressController.text = customuer.address;

            return AlertDialog(
              title: Text('Vendor Details'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${customuer.name}'),
                  Text('Contact Phone : ${customuer.Phone}'),
                  Text('Email: ${customuer.Email}'),
                  Text('Address: ${customuer.address}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Switch to edit mode
                    _isEditing = true;
                    _editingCustomer = customuer;
                    Navigator.pop(context);
                    _showAddCustomerDialog();
                  },
                  child: Text('Edit'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      customurs.remove(customuer);
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Delete'),
                ),
              ],
            );
          }
        },
      );
    }
  }

class Customer {
  String name;
  String Email;
  String Phone;
  String address;

  Customer({
    required this.name,
    required this.Email,
    required this.Phone,
    required this.address,
  });
}



class Pair {
  late String client;
  late double pourcentage;
}
