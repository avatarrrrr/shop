import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';

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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final product = ModalRoute.of(context).settings.arguments as Product;
      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;
        _imageUrlController.text = product.imageUrl;
      }
    }
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
        title: Text(
          _formData['title'] == null ? 'Novo produto' : _formData['title'],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['title'],
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
                      initialValue: _formData['price'] != null
                          ? _formData['price'].toString()
                          : '',
                      focusNode: _priceFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Preço',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) =>
                          _formData['price'] = double.parse(value),
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode),
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
                      initialValue: _formData['description'],
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
                              : Image.network(
                                  _imageUrlController.text,
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

  Future<void> saveForm() async {
    if (!_form.currentState.validate()) {
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
    final product = Product(
      id: _formData['id'],
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      imageUrl: _formData['imageUrl'],
    );

    setState(() => _isLoading = true);

    final products = context.read<Products>();
    if (_formData['id'] == null) {
      try {
        await products.addProduct(product);
        Navigator.of(context).pop();
      } on Exception catch (_) {
        await showDialog<Null>(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Ocorreu um erro!'),
            content: Text('Ocorreu um erro no salvamento do produto!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Fechar'),
              ),
            ],
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    } else {
      products.updateProduct(product);
    }
  }
}
