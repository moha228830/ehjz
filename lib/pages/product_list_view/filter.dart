import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool price1 = false,
      price2 = false,
      price3 = false,
      brand1 = false,
      brand2 = false,
      brand3 = false;
  bool occasion1 = false, occasion2 = false, occasion3 = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)
              .translate('filterPage', 'filterAppBarTitleString'),
          style: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            letterSpacing: 1.7,
          ),
        ),
        titleSpacing: 0.0,
      ),
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                minWidth: ((width) / 2),
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('filterPage', 'cancelButtonString'),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline6.color,
                      fontSize: (myLocale.languageCode == 'ru') ? 13.0 : 15.0,
                      fontFamily: 'Jost',
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).appBarTheme.color,
                ),
              ),
              ButtonTheme(
                minWidth: ((width) / 2),
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('filterPage', 'applyButtonString'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: (myLocale.languageCode == 'ru') ? 13.0 : 15.0,
                      fontFamily: 'Jost',
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
              child: Text(
                AppLocalizations.of(context)
                    .translate('filterPage', 'priceString'),
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Jost',
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline6.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              height: 1.0,
            ),
            checkbox('\$49 and below', price1),
            checkbox('\$50 to \$99', price2),
            checkbox('\$100 and above', price3),
            SizedBox(
              height: 8.0,
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
              child: Text(AppLocalizations.of(context).translate('filterPage','brandString'),
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Jost',
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline6.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              height: 1.0,
            ),
            checkbox("Calvin Klein", brand1),
            checkbox("Nike", brand2),
            checkbox("Puma", brand3),
            SizedBox(
              height: 8.0,
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
              child: Text(AppLocalizations.of(context).translate('filterPage','occasionString'),
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Jost',
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline6.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              height: 1.0,
            ),
            checkbox("Casual", occasion1),
            checkbox("Party & Festive", occasion2),
            checkbox("Wedding", occasion3),
          ],
        ),
      ),
    );
  }

  Widget checkbox(String title, bool boolValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: boolValue,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (bool value) {
            setState(() {
              switch (title) {
                case "\$49 and below":
                  price1 = value;
                  break;

                case "\$50 to \$99":
                  price2 = value;
                  break;

                case "\$100 and above":
                  price3 = value;
                  break;

                case "Calvin Klein":
                  brand1 = value;
                  break;

                case "Nike":
                  brand2 = value;
                  break;

                case "Puma":
                  brand3 = value;
                  break;

                case "Casual":
                  occasion1 = value;
                  break;

                case "Party & Festive":
                  occasion2 = value;
                  break;

                case "Wedding":
                  occasion3 = value;
                  break;
              }
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).textTheme.headline6.color,
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
