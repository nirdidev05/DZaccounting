import 'package:flutter/material.dart';

import 'facrure_page.dart';

class VendorPage extends StatefulWidget {
  @override
  _VendorPageState createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  List<Vendor> vendors = [];
  List<Purchase> purchases = [];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactPersonController = TextEditingController();
  TextEditingController _contactDetailsController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _productsServicesController = TextEditingController();

  bool _isEditing = false; // Flag to indicate whether the dialog is in edit mode or not
  Vendor? _editingVendor; // Currently editing vendor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/grey.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 250.0,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          searchVendor(value);
                        },
                      ),
                    ),

                    SizedBox(width: 660.0),
                    Card(
                      elevation: 4.0,
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'The number of vendors you work with: ${vendors.length}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _showAddVendorDialog(); // Show add vendor dialog
                },
                child: Text('Add Vendor'),
              ),
              SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: vendors.length,
                itemBuilder: (context, index) {
                  Vendor vendor = vendors[index];
                  return ListTile(
                    title: Text(vendor.name),
                    subtitle: Text('Contact Person: ${vendor.contactPerson}'),
                    onTap: () {
                      _showVendorDetailsDialog(vendor); // Show vendor details dialog
                    },
                  );
                },
              ),
              SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () {
                  _addPurchase(); // Show add purchase dialog
                },
                child: Text('Add Purchase'),
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
              child : DataTable(
                headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Color(0xFF0840af),),
                columns: [
                  DataColumn(label: Text('Vendor',style: TextStyle(color: Colors
                  .white60),),),
                  DataColumn(label: Text('Product Name',style: TextStyle(color: Colors
                      .white60))),
                  DataColumn(label: Text('Quantity', style: TextStyle(color: Colors
                      .white60))),
                  DataColumn(label: Text('Unit Price', style: TextStyle(color: Colors
                      .white60))),
                  DataColumn(label: Text('Total Price', style: TextStyle(color: Colors
                      .white60))),
                ],
                rows: purchases.map((purchase) {
                  return DataRow(
                    cells: [
                      DataCell(Text(purchase.vendor)),
                      DataCell(Text(purchase.productName)),
                      DataCell(Text(purchase.quantity.toString())),
                      DataCell(Text(purchase.unitPrice.toString())),
                      DataCell(Text(purchase.totalPrice.toString())),
                    ],
                    onSelectChanged: (isSelected) {
                      if (isSelected != null && isSelected) {
                        _showPurchaseDetailsDialog(purchase);
                      }
                    },
                  );
                }).toList(),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  void _showAddVendorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Vendor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name', hintText: 'Enter vendor name'),
              ),
              TextField(
                controller: _contactPersonController,
                decoration: InputDecoration(labelText: 'Contact Person', hintText: 'Enter contact person'),
              ),
              TextField(
                controller: _contactDetailsController,
                decoration: InputDecoration(labelText: 'Contact Details', hintText: 'Enter contact details'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address', hintText: 'Enter address'),
              ),
              TextField(
                controller: _productsServicesController,
                decoration: InputDecoration(labelText: 'Products/Services', hintText: 'Enter products/services'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add the vendor to the list
                Vendor newVendor = Vendor(
                  name: _nameController.text,
                  contactPerson: _contactPersonController.text,
                  contactDetails: _contactDetailsController.text,
                  address: _addressController.text,
                  productsServices: _productsServicesController.text,
                );
                setState(() {
                  vendors.add(newVendor);
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

  void _showVendorDetailsDialog(Vendor vendor) {
    showDialog(
      context: context,
      builder: (context) {
        if (_isEditing && _editingVendor == vendor) {
          // In edit mode
          return AlertDialog(
            title: Text('Edit Vendor'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name', hintText: 'Enter vendor name'),
                ),
                TextField(
                  controller: _contactPersonController,
                  decoration: InputDecoration(labelText: 'Contact Person', hintText: 'Enter contact person'),
                ),
                TextField(
                  controller: _contactDetailsController,
                  decoration: InputDecoration(labelText: 'Contact Details', hintText: 'Enter contact details'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address', hintText: 'Enter address'),
                ),
                TextField(
                  controller: _productsServicesController,
                  decoration: InputDecoration(labelText: 'Products/Services', hintText: 'Enter products/services'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Save the edited vendor information
                  setState(() {
                    vendor.name = _nameController.text;
                    vendor.contactPerson = _contactPersonController.text;
                    vendor.contactDetails = _contactDetailsController.text;
                    vendor.address = _addressController.text;
                    vendor.productsServices = _productsServicesController.text;
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
          _nameController.text = vendor.name;
          _contactPersonController.text = vendor.contactPerson;
          _contactDetailsController.text = vendor.contactDetails;
          _addressController.text = vendor.address;
          _productsServicesController.text = vendor.productsServices;

          return AlertDialog(
            title: Text('Vendor Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${vendor.name}'),
                Text('Contact Person: ${vendor.contactPerson}'),
                Text('Contact Details: ${vendor.contactDetails}'),
                Text('Address: ${vendor.address}'),
                Text('Products/Services: ${vendor.productsServices}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Switch to edit mode
                  _isEditing = true;
                  _editingVendor = vendor;
                  Navigator.pop(context);
                  _showVendorDetailsDialog(vendor);
                },
                child: Text('Edit'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    vendors.remove(vendor);
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

  void _clearTextFields() {
    _nameController.clear();
    _contactPersonController.clear();
    _contactDetailsController.clear();
    _addressController.clear();
    _productsServicesController.clear();
  }
  doesVendorExist(String name) {
    return vendors.any((vendor) => vendor.name == name);
  }
  void _addPurchase() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String vendorName = '';
        String productName = '';
        int quantity = 0;
        double unitPrice = 0.0;

        return AlertDialog(
          title: Text('Add Purchase'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Vendor'),
                onChanged: (value) {
                  vendorName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Product Name'),
                onChanged: (value) {
                  productName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Quantity'),
                onChanged: (value) {
                  quantity = int.parse(value);
                },
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Unit Price'),
                onChanged: (value) {
                  unitPrice = double.parse(value);
                },
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (!doesVendorExist(vendorName)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Vendor does not exist.'),
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
                              _showAddVendorDialog();
                            },
                            child: Text('Create Vendor'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Purchase newPurchase = Purchase(
                    vendor: vendorName,
                    productName: productName,
                    quantity: quantity,
                    unitPrice: unitPrice,
                    totalPrice: quantity * unitPrice,
                  );

                  setState(() {
                    purchases.add(newPurchase);
                  });

                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }


  void _showPurchaseDetailsDialog(Purchase purchase) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Purchase Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vendor: ${purchase.vendor}'),
              Text('Product Name: ${purchase.productName}'),
              Text('Quantity: ${purchase.quantity}'),
              Text('Unit Price: ${purchase.unitPrice}'),
              Text('Total Price: ${purchase.totalPrice}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _deletePurchase(purchase);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VendorPurchaseDetailsPage(vendor: getVendorByName(purchase.vendor), purchase: purchase),
                  ),
                );
              },
              child: Text('Print'),
            ),
          ],
        );
      },
    );
  }

  Vendor getVendorByName(String name) {
    return vendors.firstWhere((vendor) => vendor.name == name);
  }

  void _deletePurchase(Purchase purchase) {
    setState(() {
      purchases.remove(purchase);
    });
  }
  void searchVendor(String searchTerm) {
    // Check if the vendor exists in the list
    Vendor? foundVendor;
    for (Vendor vendor in vendors) {
      if (vendor.name.toLowerCase() == searchTerm.toLowerCase()) {
        foundVendor = vendor;
        break;
      }
    }

    if (foundVendor != null) {
      // Vendor found, show alert dialog with vendor info
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Vendor Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Name: ${foundVendor?.name}'),
                Text('Contact Person: ${foundVendor?.contactPerson}'),
                Text('Contact Details: ${foundVendor?.contactDetails}'),
                Text('Address: ${foundVendor?.address}'),
                Text('Products/Services: ${foundVendor?.productsServices}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      // Vendor not found, show scaffold messenger
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Vendor with that name does not exist.'),
        ),
      );
    }
  }

}

class Vendor {
  String name;
  String contactPerson;
  String contactDetails;
  String address;
  String productsServices;

  Vendor({
    required this.name,
    required this.contactPerson,
    required this.contactDetails,
    required this.address,
    required this.productsServices,
  });
}
class Purchase {
  final String vendor;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  Purchase({
    required this.vendor,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });
}