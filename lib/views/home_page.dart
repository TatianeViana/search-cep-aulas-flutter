import 'package:flutter/material.dart';
import 'package:search_cep/services/via_cep_service.dart';
import 'package:search_cep/temas/themes_black.dart';
import 'package:search_cep/temas/themes_light.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:share/share.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  var _searchCepController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  GlobalKey<FormState> _formResult = GlobalKey<FormState>();

}

class _HomePageState extends State<HomePage> {
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  String _result;

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar CEP'),
        actions: <Widget>[IconButton(
                    icon: Icon(Icons.lightbulb_outline),
                    onPressed: () {
                      if (Theme.of(context).brightness == Brightness.light){
                        DynamicTheme.of(context).setThemeData(myThemeLight);
                      }
                      else{
                        DynamicTheme.of(context).setThemeData(myThemeBlack);                        
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: (){
                      Share.share("CEP: ${_searchCepController.text}");
                    },
                  )],
                ),
    

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSearchCepTextField(),
            _buildSearchCepButton(),
            _buildResultForm()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCepTextField() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(labelText: 'Cep'),
      controller: _searchCepController,
      enabled: _enableField,
    );
  }

  Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RaisedButton(
        onPressed: (){
           if (_formKey.currentState.validate()){
            _searchCep();
           }
        },
        child: _loading ? _circularLoading() : Text('Consultar'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }


  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  Future _searchCep() async {
    _searching(true);

    final cep = _searchCepController.text;

    final resultCep = await ViaCepService.fetchCep(cep: cep);
    print(resultCep.localidade); // Exibindo somente a localidade no terminal

    setState(() {
      _result = resultCep.toJson();
    });

    _searching(false);
  }

  Widget _buildResultForm() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(_result ?? ''),
    );
  }
}
