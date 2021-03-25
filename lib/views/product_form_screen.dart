import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/product.dart';

///Tela para a adição/edição de um produto
class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImage);
    _imageUrlFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveForm,
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                onSaved: (value) => _formData['title'] = value,
                validator: (value) {
                  if (value.isEmpty || value.trim().isEmpty) {
                    return 'Título inválido!';
                  } else if (value.trim().length < 5) {
                    return 'O título deve ter pelo menos 5 letras!';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                focusNode: _priceFocusNode,
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.next,
                onSaved: (value) => _formData['price'] = double.parse(value),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                validator: (value) {
                  if (value.isEmpty ||
                      double.tryParse(value) == null ||
                      double.tryParse(value) < 0) {
                    return 'Preço inválido!';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                ),
                onSaved: (value) => _formData['description'] = value,
                validator: (value) {
                  if (value.isEmpty || value.trim().isEmpty) {
                    return 'Descrição inválida!';
                  } else if (value.trim().length < 10) {
                    return 'A descrição deve ter pelo menos 10 letras!';
                  } else {
                    return null;
                  }
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'URL da Imagem',
                      ),
                      onFieldSubmitted: (_) => saveForm(),
                      onSaved: (value) => _formData['imageUrl'] = value,
                      validator: (value) {
                        if (value.isEmpty ||
                            value.trim().isEmpty ||
                            !isValidImageUrl(value)) {
                          return 'URL inválida!';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text('Informe a URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateImage() {
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    var isValidProtocol = url.toLowerCase().startsWith('http://') ||
        url.toLowerCase().startsWith('https://');
    var isValidImageExtension = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValidProtocol && isValidImageExtension;
  }

  void saveForm() {
    if (_form.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Você não poderá submeter o formulário com erros de validação!',
          ),
        ),
      );
      return;
    }

    _form.currentState.save();
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      imageUrl: _formData['imageUrl'],
    );
  }
}
