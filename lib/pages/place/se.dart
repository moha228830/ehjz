import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sizer/sizer.dart';

class CharacterSearchInputSliver extends StatefulWidget {
  const CharacterSearchInputSliver({
    Key key,
    this.onChanged,
    this.debounceTime,
  }) : super(key: key);
  final ValueChanged<String> onChanged;
  final Duration debounceTime;

  @override
  _CharacterSearchInputSliverState createState() =>
      _CharacterSearchInputSliverState();
}

class _CharacterSearchInputSliverState
    extends State<CharacterSearchInputSliver> {
  final StreamController<String> _textChangeStreamController =
  StreamController();
  StreamSubscription _textChangesSubscription;

  @override
  void initState() {
    _textChangesSubscription = _textChangeStreamController.stream
        .debounceTime(
      widget.debounceTime ?? const Duration(seconds: 1),
    )
        .distinct()
        .listen((text) {
      if (widget.onChanged != null) {
        widget.onChanged(text);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) =>

      SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child:
      Container(
        color: Colors.white,
        child: TextField(
          decoration: new InputDecoration(
            prefixIcon: Icon(Icons.search,size: 20.0.sp,),
              contentPadding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 0.8.h),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue[800])),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue[800])
            ),

              fillColor: Colors.white,
              hintText: "ما الذي تبحث عنه",
              ),
          onChanged: _textChangeStreamController.add,
        ),
      ),
    ),
  );

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    super.dispose();
  }
}