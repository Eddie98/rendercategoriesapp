// ignore_for_file: avoid_init_to_null

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:rendercategoriesapp/model.dart';
import 'package:http/http.dart' as http;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TreeView Example',
      home: const MyHomePage(title: 'Example App'),
      theme: ThemeData().copyWith(
        hoverColor: Colors.red.shade100,
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(primary: Colors.red)
            .copyWith(secondary: Colors.deepPurple),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedNode = '';
  late TreeViewController _treeViewController = TreeViewController();
  final ExpanderPosition _expanderPosition = ExpanderPosition.start;
  final ExpanderType _expanderType = ExpanderType.caret;
  final ExpanderModifier _expanderModifier = ExpanderModifier.none;
  final bool _allowParentSelect = false;
  final bool _supportParentDoubleTap = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TreeViewTheme _treeViewTheme = TreeViewTheme(
      expanderTheme: ExpanderThemeData(
        type: _expanderType,
        modifier: _expanderModifier,
        position: _expanderPosition,
        // color: Colors.grey.shade800,
        size: 20,
        color: Colors.blue,
      ),
      labelStyle: const TextStyle(
        fontSize: 16,
        letterSpacing: 0.3,
      ),
      parentLabelStyle: TextStyle(
        fontSize: 16,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w800,
        color: Colors.blue.shade700,
      ),
      iconTheme: IconThemeData(
        size: 18,
        color: Colors.grey.shade800,
      ),
      colorScheme: Theme.of(context).colorScheme,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TreeView(
                controller: _treeViewController,
                allowParentSelect: _allowParentSelect,
                supportParentDoubleTap: _supportParentDoubleTap,
                onExpansionChanged: (key, expanded) =>
                    _expandNode(key, expanded),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                onNodeTap: (key) {
                  setState(() {
                    _selectedNode = key;
                    _treeViewController =
                        _treeViewController.copyWith(selectedKey: key);
                  });
                },
                theme: _treeViewTheme,
              ),
            ),
            if (_treeViewController.children.isEmpty)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  void fetchData() async {
    final response = await http.get(
      Uri.parse('https://test-docs.stores.kg/api/categories'),
      headers: {
        "Content-Type": "application/ld+json",
        "secretKey": "test_key",
      },
    );

    if (response.statusCode == 200) {
      var model = Model.fromRawJson(response.body);

      setState(() {
        _treeViewController = TreeViewController(
          children: createNode(model),
          selectedKey: _selectedNode,
        );
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Node> createNode(Model model) {
    List<Node> nodes = [];

    for (var category in model.hydraMember!) {
      void find(c, {Node? n = null}) {
        bool isNull = n == null;
        bool isCc = c is CategoryCategory;
        bool cChecker =
            isNull && (c.categories != null && c.categories!.isNotEmpty);
        bool ccChecker = !isNull &&
            !isCc &&
            (c.categoryCategories != null && c.categoryCategories!.isNotEmpty);

        if (isNull ? cChecker : ccChecker) {
          var newNode = Node(key: c.slug!, label: c.name!, children: []);
          n?.children.add(newNode);
          if (isNull) nodes.add(newNode);

          if (!isCc) {
            for (var ct in isNull ? c.categories : c.categoryCategories) {
              find(ct, n: newNode);
            }
          }
        } else {
          var newNode = Node(
              key: isCc ? c.categorySlug! : c.slug!,
              label: isCc ? c.categoryName! : c.name!);
          n?.children.add(newNode);
          if (isNull) nodes.add(newNode);
        }
      }

      find(category);
    }

    return nodes;
  }

  void _expandNode(String key, bool expanded) {
    Node node = _treeViewController.getNode(key)!;
    List<Node> updated;
    updated =
        _treeViewController.updateNode(key, node.copyWith(expanded: expanded));
    setState(() {
      _treeViewController = _treeViewController.copyWith(children: updated);
    });
  }
}
