import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:slad_app/customWidgets/radio_group.dart';
import 'package:slad_app/models/telescope.dart';
import 'package:slad_app/pages/brand_page.dart';
import 'package:slad_app/providers/telescope_provider.dart';
import 'package:slad_app/utils/constants.dart';

import '../models/brand_model.dart';

class AddTelescopePage extends StatefulWidget {
  static const String routeName = 'addtelescope';

  const AddTelescopePage({super.key});

  @override
  State<AddTelescopePage> createState() => _AddTelescopePageState();
}

class _AddTelescopePageState extends State<AddTelescopePage> {
  final _modelController = TextEditingController();
  final _dimensionController = TextEditingController();
  final _weightController = TextEditingController();
  final _lensDiameterController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Brand? brand;
  String? imageLocalPath;
  String mountDescription = TelescopeUtils.mountList.first;
  String focusType = TelescopeUtils.focusList.first;
  String telescopeType = TelescopeUtils.typeList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Telescope'),
        actions: [
          IconButton(onPressed: _saveTelescope, icon: const Icon(Icons.done))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Column(
                children: [
                  imageLocalPath == null
                      ? const Icon(
                    Icons.photo,
                    size: 100,
                  )
                      : Image.file(
                    File(imageLocalPath!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    'Select Telescope Image \n from',
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () async{
                          getImage(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera_alt_rounded),
                        label: const Text('Camera'),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.browse_gallery),
                        label: const Text('Gallery'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<TelescopeProvider>(
                  builder: (context, provider, child) =>
                      DropdownButtonFormField<Brand>(
                          decoration:
                          const InputDecoration(border: InputBorder.none),
                          hint: const Text('Select Brand'),
                          isExpanded: true,
                          value: brand,
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a brand';
                            }
                            return null;
                          },
                          items: provider.brandList
                              .map((item) =>
                              DropdownMenuItem<Brand>(
                                value: item,
                                child: Text(item.name),
                              ))
                              .toList(),
                          onChanged: (value) {
                            brand = value;
                          }),
                ),
              ),
            ),
            RadioGroup(
              label: 'Select Telescope Type',
              groupValue: telescopeType,
              items: TelescopeUtils.typeList,
              onItemSelected: (value) {
                telescopeType = value!;
              },
            ),
            RadioGroup(
              label: 'Select Mount Type',
              groupValue: mountDescription,
              items: TelescopeUtils.mountList,
              onItemSelected: (value) {
                mountDescription = value!;
              },
            ),
            RadioGroup(
              label: 'Select Focus Type',
              groupValue: focusType,
              items: TelescopeUtils.focusList,
              onItemSelected: (value) {
                focusType = value!;
              },
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Please add extra details of Telescope'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _modelController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            labelText: 'Model'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: _dimensionController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            labelText: 'Dimension'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: _weightController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            labelText: 'Weight(lb)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: _lensDiameterController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            labelText: 'Lens Diameter (mm'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            labelText: 'Price'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          if (num.parse(value) <= 0) {
                            return 'Price should be greater than 0';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: _stockController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            labelText: 'Stock'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must not be empty';
                          }
                          if (num.parse(value) <= 0) {
                            return 'Quantity should be greater than 0';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _modelController.dispose();
    _dimensionController.dispose();
    _weightController.dispose();
    _lensDiameterController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void getImage(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source, imageQuality: 50);
    if(file != null){
      setState(() {
        imageLocalPath = file.path;
      });
    }
  }
  void _saveTelescope() async {
    if (imageLocalPath == null) {
      showMsg(context, 'Please select a telescope image');
      return;
    }
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait!');
      try {
        final imageModel =
        await Provider.of<TelescopeProvider>(context, listen: false)
            .uploadImage(imageLocalPath!);
        final telescope = Telescope(
            model: _modelController.text,
            brand: brand!,
            type: telescopeType,
            dimension: _dimensionController.text,
            weightInPound: num.parse(_weightController.text),
            focusType: focusType,
            lensDiameterInMM:num.parse(_lensDiameterController.text) ,
            mountDescription: mountDescription,
            price: num.parse(_priceController.text),
            stock: num.parse(_stockController.text),
            thumbnail: imageModel,
            additionalImage: []
        );

        await TelescopeProvider.addTelescope(telescope);
        EasyLoading.dismiss();
        showMsg(context, 'saved');
        _resetFields();
      } catch (error) {
        EasyLoading.dismiss();
        print(error.toString());
      }
    }
  }

  void _resetFields() {
    setState(() {
       _modelController.clear();
       _dimensionController.clear();
       _weightController.clear();
       _lensDiameterController.clear();
       _priceController.clear();
       _stockController.clear();
       brand = null;
       imageLocalPath = null;
       mountDescription = TelescopeUtils.mountList.first;
       focusType = TelescopeUtils.focusList.first;
       telescopeType = TelescopeUtils.typeList.first;
    });
  }
}
