import 'package:flutter/material.dart';
import 'package:my_store/functions/localizations.dart';
import 'package:my_store/pages/product_list_view/filter.dart';
import 'package:page_transition/page_transition.dart';

class FilterRow extends StatefulWidget {
  @override
  _FilterRowState createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  int selectedRadioSort;
  bool satVal = false;
  bool sunVal = false;

  @override
  void initState() {
    super.initState();
    selectedRadioSort = 0;
  }

  setSelectedRadioSort(int val) {
    setState(() {
      selectedRadioSort = val;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            onTap: () {
              _sortModalBottomSheet(context);
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.sort,
                    size: 25.0,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('productListViewPage', 'sortString'),
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20.0,
            width: 1.0,
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Filter()));
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.filter_list,
                    size: 25.0,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(AppLocalizations.of(context).translate('productListViewPage','filterString'),
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
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

  void _sortModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).appBarTheme.color,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)
                              .translate('productListViewPage', 'sortByString'),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost',
                            letterSpacing: 0.7,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 1.0,
                        ),
                        RadioListTile(
                          value: 1,
                          groupValue: selectedRadioSort,
                          title: Text(
                            "Popularity",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          onChanged: (val) {
                            setSelectedRadioSort(val);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        RadioListTile(
                          value: 2,
                          groupValue: selectedRadioSort,
                          title: Text(
                            "Price -- Low to High",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          onChanged: (val) {
                            setSelectedRadioSort(val);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        RadioListTile(
                          value: 3,
                          groupValue: selectedRadioSort,
                          title: Text(
                            "Price -- High to Low",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          onChanged: (val) {
                            setSelectedRadioSort(val);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        RadioListTile(
                          value: 4,
                          groupValue: selectedRadioSort,
                          title: Text(
                            "Newest First",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          onChanged: (val) {
                            setSelectedRadioSort(val);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
