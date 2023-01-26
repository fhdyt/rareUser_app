import 'package:app_rareuser/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode myTextFieldFocusNode = FocusNode();
  void initState() {
    super.initState();

    myTextFieldFocusNode.requestFocus();
  }

  @override
  void dispose() {
    myTextFieldFocusNode.dispose();
    super.dispose();
  }

  void findResult(String value) {
    Navigator.pushNamed(context, Resultscreen.routeName, arguments: value);
  }

  final TextEditingController _controller = TextEditingController();
  void clearTextField() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
          child: Center(
            child: TextField(
              focusNode: myTextFieldFocusNode,
              controller: _controller,
              onSubmitted: (value) {
                findResult(value);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    clearTextField();
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text('Seach Screen'),
      ),
    );
  }
}
