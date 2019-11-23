import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
void main() { runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Bank Transfer',
    home:Calculator(),
        theme: ThemeData(
         brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
        ),
    )
);
}
class Calculator extends StatefulWidget{
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Calculator();
  }
}
class _Calculator extends State<Calculator>  {
  var _Currencies = ['L.E', 'Dollars', 'Euro'];
  var _currentItemSelected = 'L.E';
  var _transferSelected ='L.E';
  final  _minPadding=5.0;
  TextEditingController currentControlled = TextEditingController();
   var displayResult='';
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle= Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(title: Text('Bank Transfer'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minPadding),
        child: ListView(
          children: <Widget>[
            getImage(),
          Row(
            children: <Widget>[
              Expanded(child:
              Container(
                child: TextField(
                  style: textStyle,
                keyboardType:TextInputType.number,
                controller: currentControlled,
                decoration: InputDecoration(
  //                labelStyle: textStyle,
                  hintText: 'Current Amount',
                  labelText: 'Current Amount e.g 100',
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1.0)
                  )
                ),
              ),
          )
      ),
              Container(width:_minPadding*7 ),

              Container(
                  padding: EdgeInsets.only(left: _minPadding),
                  child: DropdownButton<String>(
                   style: textStyle,
                    items: _Currencies.map((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value)
                      );
                    }).toList(),
                     value: _currentItemSelected,
                     onChanged: (String newValueSelected){
                       _onDropDownItemCurrent(newValueSelected);
                     },
                )
              )

            ],
          ),
            Padding(padding:
            EdgeInsets.all(
                _minPadding*2
            )
            ),
            Row(
              children: <Widget>[
               Expanded(child:
                Container(
                  padding: EdgeInsets.only(left: _minPadding),
                  child: Text('Transfer To: ',
                    style:TextStyle(
                    fontSize: 20.0
                    ) ,
                  ),
                )
               ),
                Container(width:_minPadding*20),

                  Container(
                    child: DropdownButton<String>(
                      style: textStyle,
                      items: _Currencies.map((String value){
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value)
                        );
                      }).toList(),
                      value: _transferSelected,
                      onChanged: (String newValueSelected){
                        _onDropDownItemChangeTo(newValueSelected);
                      },
                    )
                ),
              ],
            ),
            Padding(padding:
            EdgeInsets.all(
                _minPadding*2
            )
            ),
            Row(
            children: <Widget>[
            Expanded(
                child:
              RaisedButton(
                color: Colors.indigo,
                padding: EdgeInsets.only(left: _minPadding),
              child: Text('Transfer',
                style:TextStyle(fontSize: 18, color: Colors.black87),
              ),
                onPressed:(){
                 setState(() {
                   this.displayResult=_calcReturn();
                   });
                } ,
            )
            ),
              Container(
                width: _minPadding*3,),
              Expanded(child:
              RaisedButton(
                color: Colors.indigo,
                padding: EdgeInsets.only(left: _minPadding),
                child: Text('Reset',
                  textScaleFactor: 1.0,
                  style:TextStyle(fontSize: 18, color: Colors.black87),

                ),
                onPressed:(){
             setState(() {
               String res = '';
               currentControlled.text=res;
               displayResult='';
               _currentItemSelected=_Currencies[0];
               _transferSelected=_Currencies[0];
             });
                } ,
              )
              )
            ],
            ),
            Padding(padding:
            EdgeInsets.all(
                _minPadding*2
            )
            ),
            Container(
                child:Text(this.displayResult,
                  style: TextStyle(fontSize: 20,color: Colors.teal),
            )
            )
          ],
        ),
      )
    );
  }
  Widget getImage (){
    AssetImage assetimage = AssetImage('images/exchange.jpg');
    Image image =Image(
      image: assetimage, width: 200.0, height: 150.0);
    return Container(
      child: image, margin: EdgeInsets.all(_minPadding*10));
  }
  void _onDropDownItemCurrent(String newValueSelected) {
    setState(() {
      this._currentItemSelected =newValueSelected;
    });
  }
  void _onDropDownItemChangeTo (String newValueSelected) {
    setState(() {
      this._transferSelected = newValueSelected;
    });
  }
  String _calcReturn (){
    double calcu =double.parse(currentControlled.text);
     double totalAmount;
    if(
    _currentItemSelected==_Currencies[0]
        &&_transferSelected==_Currencies[1]
    ){
      totalAmount =calcu/16;
    }
    else if(
    _currentItemSelected==_Currencies[0]
        &&_transferSelected==_Currencies[2]
    ){
      totalAmount=calcu/17.5;
    }
   else if(_currentItemSelected==_Currencies[1]
        &&_transferSelected==_Currencies[0]){
     totalAmount=calcu*16;
    }
   else if(_currentItemSelected==_Currencies[1]
        &&_transferSelected==_Currencies[2]){
     totalAmount=calcu/1.0937;
    }
   else if(_currentItemSelected==_Currencies[2]
        &&_transferSelected==_Currencies[0]){
     totalAmount=calcu/0.05714;
    }
   else if(_currentItemSelected==_Currencies[2]
        &&_transferSelected==_Currencies[1]){
     totalAmount=calcu/0.91428;
    }
   String result = 'amount transfer from '
       '$_currentItemSelected to $_transferSelected = $totalAmount';
   return result;
  }
}