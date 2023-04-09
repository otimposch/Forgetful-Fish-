import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';
import 'constants.dart';
import 'about_page.dart';
import 'contact_page.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

//Home
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: CustomAppBar(),
        drawer: const CustomDrawer(),
        body: Navigator(
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => Column(
                      children: [
                        const ProgressIndicator(currentStep: 1),
                        Expanded(
                          child: Step1Screen(),
                        ),
                      ],
                    );
                break;
              case '/step2':
                final Map<String, dynamic> args =
                    settings.arguments as Map<String, dynamic>;
                final cards = args['cards'];
                final categories = args['categories'];
                builder = (BuildContext context) => Column(children: [
                      const ProgressIndicator(currentStep: 2),
                      Expanded(
                        child:
                            Step2Screen(cards: cards, categories: categories),
                      )
                    ]);
                break;
              case '/step3':
                final Map<String, dynamic> args =
                    settings.arguments as Map<String, dynamic>;
                final cards = args['cards'];
                final categories = args['categories'];
                final cardAmounts = args['cardAmounts'];
                builder = (BuildContext context) => Column(children: [
                      const ProgressIndicator(currentStep: 3),
                      Expanded(
                        child: Step3Screen(
                            cards: cards,
                            categories: categories,
                            cardAmounts: cardAmounts),
                      )
                    ]);
                break;

              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ),
      ),
    );
  }
}

//新Appbar
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double appBarFontSize;
    if (screenWidth < 400) {
      appBarFontSize = 18;
    } else if (screenWidth < 600) {
      appBarFontSize = 20;
    } else {
      appBarFontSize = 22;
    }

    return AppBar(
      title: Text(
        'Forgetful fishデッキ生成',
        style: TextStyle(fontSize: appBarFontSize),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }
}

//新Drawer
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('ForgetfulFishとは？'),
            onTap: () {
              Navigator.of(context).pop(); // drawer を閉じる
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.help),
          //   title: const Text('ヘルプ'),
          //   onTap: () {
          //     Navigator.of(context).pop(); // drawer を閉じる
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => const AboutPage()));
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.contact_page),
            title: const Text('コンタクト'),
            onTap: () {
              Navigator.of(context).pop(); // drawer を閉じる
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ContactPage()));
            },
          ),
        ],
      ),
    );
  }
}

//リング状プログレスインジケータ
class ProgressIndicator extends StatefulWidget {
  final int currentStep;

  const ProgressIndicator({Key? key, required this.currentStep})
      : super(key: key);

  @override
  ProgressIndicatorState createState() => ProgressIndicatorState();
}

class ProgressIndicatorState extends State<ProgressIndicator> {
  late int currentStep = widget.currentStep;
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleExpand,
      child: Container(
        color: Colors.transparent,
        padding:
            const EdgeInsets.all(10), // optional padding for better touch area
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 5.0,
                  percent: currentStep / 3,
                  center: Text("$currentStep/3"),
                  progressColor: Colors.blue,
                  animation: true,
                  animationDuration: 500,
                ),
                const SizedBox(width: 10),
                Text(stepTitles[currentStep - 1]),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 10),
              Text(stepDescriptions[currentStep - 1]),
            ],
          ],
        ),
      ),
    );
  }
}

//SPサイズの時のSTEP1編集画面
class CardEditScreen extends StatefulWidget {
  final int index;
  final Map<String, dynamic> card;
  final List<String> categories;
  final List<int> quantities;
  final Function(int, Map<String, dynamic>) onSave;

  const CardEditScreen({
    Key? key,
    required this.index,
    required this.card,
    required this.categories,
    required this.quantities,
    required this.onSave,
  }) : super(key: key);

  @override
  CardEditScreenState createState() => CardEditScreenState();
}

class CardEditScreenState extends State<CardEditScreen> {
  late TextEditingController _nameController;
  late String _selectedCategory;
  late int _selectedQuantity; // 追加

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.card["name"]);
    _selectedCategory = widget.card["category"];
    _selectedQuantity = widget.card["quantity"];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("カード編集"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 追加
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "カード名"),
                ),
                const SizedBox(height: 16),
                DropdownButton<int>(
                  value: _selectedQuantity,
                  items: widget.quantities
                      .map<DropdownMenuItem<int>>(
                        (quantity) => DropdownMenuItem(
                          value: quantity,
                          child: Text('$quantity枚'), // 「枚」を追加
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedQuantity = value!;
                    });
                  },
                  hint: const Text("所持枚数"), // 追加
                ),
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: widget.categories
                      .map<DropdownMenuItem<String>>(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  hint: const Text("カテゴリ"), // 追加
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    widget.onSave(widget.index, {
                      "name": _nameController.text,
                      "quantity": _selectedQuantity,
                      "category": _selectedCategory,
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("保存"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//ElevatedButton共通化
class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;

  const CustomElevatedButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 20), // ここでマージンを追加
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text(buttonText),
      ),
    );
  }
}

//STEP1
class Step1Screen extends StatefulWidget {
  const Step1Screen({Key? key}) : super(key: key);

  @override
  Step1ScreenState createState() => Step1ScreenState();
}

class Step1ScreenState extends State<Step1Screen> {
  void addRow() {
    setState(() {
      cards.add({"name": "", "category": categories[0], "quantity": 0});
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: screenWidth < 900
                  ? _buildMobileLayout()
                  : _buildDesktopLayout(context),
            ),
            CustomElevatedButton(
              buttonText: 'STEP2へ',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/step2',
                  arguments: {
                    'cards': cards,
                    'categories': categories,
                  },
                );
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addRow,
          child: const Icon(Icons.add),
        ));
  }

  _buildMobileLayout() {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cards[index]["name"]),
                Text('${cards[index]['quantity']}枚')
              ]),
          subtitle: Text(cards[index]["category"]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CardEditScreen(
                  index: index,
                  card: cards[index],
                  categories: categories,
                  quantities: quantities,
                  onSave: (int index, Map<String, dynamic> editedCard) {
                    setState(() {
                      cards[index] = editedCard;
                    });
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('カード名')),
            DataColumn(label: Text('カテゴリ')),
            DataColumn(label: Text('所持枚数')),
          ],
          rows: List<DataRow>.generate(
            cards.length,
            (index) => DataRow(
              cells: [
                DataCell(
                  TextField(
                    decoration: InputDecoration(
                      hintText:
                          index < cards.length ? cards[index]["name"] : '',
                    ),
                    onChanged: (value) {
                      setState(() {
                        cards[index]["name"] = value;
                      });
                    },
                  ),
                ),
                DataCell(
                  DropdownButton<String>(
                    value: cards[index]["category"],
                    items: categories
                        .map<DropdownMenuItem<String>>(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        cards[index]["category"] = value!;
                      });
                    },
                  ),
                ),
                DataCell(
                  DropdownButton<int>(
                    value: cards[index]["quantity"],
                    items: quantities
                        .map<DropdownMenuItem<int>>(
                          (quantity) => DropdownMenuItem(
                            value: quantity,
                            child: Text('$quantity'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        cards[index]["quantity"] = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//STEP2
class Step2Screen extends StatefulWidget {
  final List<Map<String, dynamic>>? cards;
  final List<String> categories;

  const Step2Screen({
    Key? key,
    required this.cards,
    required this.categories,
  }) : super(key: key);

  @override
  Step2ScreenState createState() => Step2ScreenState();
}

class Step2ScreenState extends State<Step2Screen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  int dandanAmount = 10;
  int islandAmount = 0;
  int islandAmountMax = 32;
  int get nonBasicLandIndex => widget.categories.indexOf("基本でない土地");

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(vsync: this, length: cardAmountTemplates.length);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set the initial card amounts based on the first template
      setState(() {
        cardAmounts = List.from(cardAmountTemplates[0]);
        int nonBasicLandAmount = cardAmounts[nonBasicLandIndex];
        islandAmount = islandAmountMax - nonBasicLandAmount;
      });
    });

    _tabController?.addListener(() {
      setState(() {
        cardAmounts =
            List.from(cardAmountTemplates[_tabController?.index ?? 0]);
        int nonBasicLandAmount = cardAmounts[nonBasicLandIndex];
        islandAmount = islandAmountMax - nonBasicLandAmount;
      });
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  List<String> get categories => widget.categories;

  late List<int> cardAmounts = List.generate(categories.length, (index) => 0);

  int get totalAmount {
    if (_tabController == null) {
      return 0;
    }
    int tabIndex = _tabController!.index;
    if (tabIndex < 0 || tabIndex >= cardAmountTemplates.length) {
      return 0;
    }
    return cardAmounts.reduce((a, b) => a + b) +
        dandanAmount +
        memoryLapseAmount +
        islandAmount;
  }

  bool memoryLapseCheckbox = false;
  int get memoryLapseAmount => memoryLapseCheckbox ? 8 : 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            color: const Color.fromARGB(255, 232, 232, 232), // タブバーの背景色
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color.fromARGB(255, 32, 32, 32),
              labelColor: const Color.fromARGB(255, 32, 32, 32),
              unselectedLabelColor: const Color.fromARGB(255, 124, 124, 124),
              tabs: const [
                Tab(child: Text('テンプレート1\n標準', textAlign: TextAlign.center)),
                Tab(child: Text('テンプレート2\n呪文戦', textAlign: TextAlign.center)),
                Tab(child: Text('テンプレート3\n殴り合い', textAlign: TextAlign.center)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(), // スワイプ禁止
              children: List.generate(cardAmountTemplates.length, (i) {
                return SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('カテゴリ')),
                      DataColumn(label: Text('投入枚数')),
                    ],
                    rows: [
                      ...List<DataRow>.generate(
                        categories.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text(categories[index])),
                            DataCell(
                              DropdownButton<int>(
                                  value: cardAmounts[index],
                                  items: [
                                    for (int i = 0; i <= 20; i++)
                                      DropdownMenuItem(
                                          value: i, child: Text('$i')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      cardAmounts[index] = value!;
                                      if (index == nonBasicLandIndex) {
                                        // 基本でない土地の投入枚数が変更された場合だけ、islandAmountを更新
                                        islandAmount = islandAmountMax - value;
                                      }
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                      DataRow(
                        cells: [
                          const DataCell(Text('ダンダーン')),
                          DataCell(
                            DropdownButton<int>(
                              value: dandanAmount,
                              items: [
                                DropdownMenuItem(
                                    value: dandanAmount,
                                    child: Text('$dandanAmount')),
                              ],
                              onChanged: null,
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          const DataCell(Text('記憶の欠落')),
                          DataCell(
                            DropdownButton<int>(
                              value: memoryLapseAmount,
                              items: [
                                DropdownMenuItem(
                                  value: memoryLapseAmount,
                                  child: Text('$memoryLapseAmount'),
                                ),
                              ],
                              onChanged: null,
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          const DataCell(Text('島(基本土地)')),
                          DataCell(
                            DropdownButton<int>(
                              value: islandAmount,
                              items: [
                                DropdownMenuItem(
                                  value: islandAmount,
                                  child: Text('$islandAmount'),
                                ),
                              ],
                              onChanged: null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Text('合計値: $totalAmount'),
          if (totalAmount != 80)
            const Text('投入枚数が80枚になるようにしてください。',
                style: TextStyle(color: Colors.red)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("記憶の欠落を8枚投入する"),
              Checkbox(
                value: memoryLapseCheckbox,
                onChanged: (value) {
                  setState(() {
                    memoryLapseCheckbox = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                buttonText: 'STEP1へ',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CustomElevatedButton(
                buttonText: 'STEP3へ',
                onPressed: totalAmount == 80
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/step3',
                          arguments: {
                            'cards': widget.cards,
                            'categories': widget.categories,
                            'cardAmounts': cardAmounts,
                          },
                        );
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//STEP3
class Step3Screen extends StatefulWidget {
  final List<Map<String, dynamic>>? cards;
  final List<String> categories;
  final List<int> cardAmounts;

  const Step3Screen(
      {Key? key,
      this.cards,
      required this.categories,
      required this.cardAmounts})
      : super(key: key);

  @override
  Step3ScreenState createState() => Step3ScreenState();
}

class Step3ScreenState extends State<Step3Screen> {
  late List<Map<String, dynamic>> deck;

  @override
  void initState() {
    super.initState();
    deck = _generateDeck();
  }

  List<Map<String, dynamic>> _generateDeck() {
    List<Map<String, dynamic>> newDeck = [];
    List<Map<String, dynamic>> filteredCards =
        widget.cards!.where((card) => card["quantity"] > 0).toList();

    for (int i = 0; i < widget.categories.length; i++) {
      String category = widget.categories[i];
      int targetAmount = widget.cardAmounts[i];

      List<Map<String, dynamic>> categoryCards =
          filteredCards.where((card) => card["category"] == category).toList();
      int currentAmount = 0;

      while (currentAmount < targetAmount && categoryCards.isNotEmpty) {
        int randomIndex = Random().nextInt(categoryCards.length);
        Map<String, dynamic> selectedCard = categoryCards[randomIndex];

        int cardQuantity =
            min(selectedCard["quantity"], targetAmount - currentAmount);

        Map<String, dynamic>? existingCard = newDeck.firstWhereOrNull(
            (deckCard) => deckCard["name"] == selectedCard["name"]);

        if (existingCard != null) {
          existingCard["quantity"] += cardQuantity;
        } else {
          newDeck.add({"name": selectedCard["name"], "quantity": cardQuantity});
        }

        currentAmount += cardQuantity;
        categoryCards.removeAt(randomIndex);
      }
    }

    return newDeck;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('カード名')),
                  DataColumn(label: Text('枚数')),
                ],
                rows: List<DataRow>.generate(
                  deck.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text(deck[index]["name"])),
                      DataCell(Text(deck[index]["quantity"].toString())),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                buttonText: '戻る',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // 更新ボタンを追加
              CustomElevatedButton(
                buttonText: '再生成',
                onPressed: () {
                  setState(() {
                    deck = _generateDeck();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}