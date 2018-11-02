import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  // Config ImagePicker
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  // Controllers
  final _nameController = TextEditingController();
  final _empresaController = TextEditingController();
  final _unidadeController = TextEditingController();

  bool _userEdited = false;

  // Categorias Cargo
  List<DropdownMenuItem<String>> _listDropCargo;
  String _selectedCargo;

  List<DropdownMenuItem<String>> _getListDropCargo() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(new DropdownMenuItem(
      value: 'selecionarCargo',
      child: new Text('Selecionar Cargo'),
    ));
    items.add(new DropdownMenuItem(
      value: 'programador',
      child: new Text('Programador'),
    ));
    items.add(new DropdownMenuItem(
      value: 'gerente',
      child: new Text('Gerente'),
    ));
    items.add(new DropdownMenuItem(
      value: 'diretor',
      child: new Text('Diretor'),
    ));

    return items;
  }

  void changeDropDownItem(String selectedItemCargo) {
    setState(() {
      _selectedCargo = selectedItemCargo;
    });
  }

  // Categorias Área
  List<DropdownMenuItem<String>> _listDropArea;
  String _selectedArea;

  List<DropdownMenuItem<String>> _getListDropArea() {
    List<DropdownMenuItem<String>> itemsArea = new List();

    itemsArea.add(new DropdownMenuItem(
      value: 'selecionarArea',
      child: new Text('Selecionar Área'),
    ));
    itemsArea.add(new DropdownMenuItem(
      value: 'administrativa',
      child: new Text('Administrativa'),
    ));
    itemsArea.add(new DropdownMenuItem(
      value: 'operacional',
      child: new Text('Operacional'),
    ));
    itemsArea.add(new DropdownMenuItem(
      value: 'logistica',
      child: new Text('Logistica'),
    ));

    return itemsArea;
  }

  void changeDropDownItemArea(String selectedItemArea) {
    setState(() {
      _selectedArea = selectedItemArea;
    });
  }

  @override
  void initState() {
    _listDropCargo = _getListDropCargo();
    _selectedCargo = _listDropCargo[0].value;
    _listDropArea = _getListDropArea();
    _selectedArea = _listDropArea[0].value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _requestPop,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Editar Perfil',
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ),
        body: new SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new GestureDetector(
                child: new Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/OpenCamera1.png"),
                    ),
                  ),
                ),
                onTap: () {
                  ImagePicker.pickImage(source: ImageSource.camera)
                      .then((file) {
                    if (file == null) return;
                    setState(() {
                      _image = file.path as File;
                    });
                  });
                },
              ),
              new TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nome"),
                keyboardType: TextInputType.text,
              ),
              new SizedBox(height: 16.0),
              new DropdownButton(
                isExpanded: true,
                style: new TextStyle(color: Colors.black),
                value: _selectedArea,
                items: _getListDropArea(),
                onChanged: changeDropDownItemArea,
              ),
              new SizedBox(height: 16.0),
              new DropdownButton(
                isExpanded: true,
                style: new TextStyle(color: Colors.black),
                value: _selectedCargo,
                items: _getListDropCargo(),
                onChanged: changeDropDownItem,
              ),
              new TextField(
                controller: _empresaController,
                decoration: InputDecoration(labelText: "Empresa"),
                keyboardType: TextInputType.text,
              ),
              new TextField(
                controller: _unidadeController,
                decoration: InputDecoration(labelText: "Unidade"),
                keyboardType: TextInputType.text,
              ),
              new SizedBox(
                height: 30.0,
              ),
              new SizedBox(
                height: 50.0,
                child: new FlatButton(
                  child: new Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.black,
                  // color: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Tratar sair da tela sem preencher todos os dados
  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
