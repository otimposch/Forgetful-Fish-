import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';
import 'constants.dart';
import 'about_page.dart';
import 'contact_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
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
        drawerEnableOpenDragGesture: false,
        drawer: const CustomDrawer(),
        body: Navigator(
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) => Column(
                      children: const [
                        ProgressIndicator(currentStep: 1),
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
      title: Semantics(
        header: true,
        child: Text(
          'ForgetfulFish Generator',
          style: TextStyle(fontSize: appBarFontSize),
          textAlign: TextAlign.center,
        ),
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

class TwitterShareWidget extends StatelessWidget {
  final String text;
  final String url;
  final List<String> hashtags;
  final String via;
  final String related;

  const TwitterShareWidget(
      {Key? key,
      required this.text,
      this.url = "",
      this.hashtags = const [],
      this.via = "",
      this.related = ""})
      : super(key: key);

  void _tweet() async {
    final Map<String, dynamic> tweetQuery = {
      "text": text,
      "url": url,
      "hashtags": hashtags.join(","),
      "via": via,
      "related": related,
    };

    final Uri tweetScheme =
        Uri(scheme: "twitter", host: "post", queryParameters: tweetQuery);

    final Uri tweetIntentUrl =
        Uri.https("twitter.com", "/intent/tweet", tweetQuery);

    await canLaunchUrl(tweetScheme)
        ? await launchUrl(tweetScheme)
        : await launchUrl(tweetIntentUrl);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.lightBlueAccent,
      onPressed: () {
        _tweet();
      },
      child: const Icon(MdiIcons.twitter),
    );
  }
}

//新Drawer
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String shareText = 'Forgetful Fish - マジックザギャザリングデッキ生成アプリ';
    String shareUrl = 'https://forgetful-fish.web.app';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icon/Dandan banner.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
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
          ListTile(
            leading: const Icon(Icons.lightbulb_outline),
            title: Row(
              children: const [
                Text(
                  'ForgetfulFishの遊び方',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '準備中',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            onTap: () {
              // 何もしない
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_page),
            title: const Text('コンタクト'),
            onTap: () {
              Navigator.of(context).pop(); // drawer を閉じる
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ContactPage()));
            },
          ),
          const SizedBox(height: 16), // ここでマージンを追加
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TwitterShareWidget(
                  text: shareText,
                  url: shareUrl,
                  hashtags: const ['ForgetfulFish', 'MTG'],
                ),
              ],
            ),
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

class ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  late int currentStep = widget.currentStep;
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation =
        Tween<double>(begin: 0, end: 0.25).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                Text(
                  stepTitles[currentStep - 1],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                RotationTransition(
                  turns: _animation,
                  child: const Icon(Icons.chevron_right),
                ),
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

//STEP1編集画面
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
                      .where((category) => !category.contains("(固定)")) // 追加
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
  final ScrollController _scrollController = ScrollController();

  int maxRows = 10;
  int initialCardCount = cards.length;

  @override
  void initState() {
    super.initState();
    initialCardCount = cards.length;
  }

  void addRow() {
    if (cards.length >= initialCardCount + maxRows) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("これ以上追加できません"),
          duration: Duration(milliseconds: 500),
        ),
      );
    } else {
      setState(() {
        cards.add({"name": "", "category": categories[0], "quantity": 0});
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width; //レスポンシブ対応用
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _buildMobileLayout()
              // child: screenWidth < 900 //レスポンシブ対応用（基本的にモバイル利用想定で良いと思ったのでコメントアウト）
              //     ? _buildMobileLayout()
              //     : _buildDesktopLayout(context),
              ),
          CustomElevatedButton(
            buttonText: '次へ',
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
      ),
    );
  }

  _buildMobileLayout() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: cards.length,
      itemBuilder: (BuildContext context, int index) {
        bool isFixedCategory = cards[index]["category"].contains("(固定)");
        Widget listTile = ListTile(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cards[index]["name"]),
                Text('${cards[index]['quantity']}枚')
              ]),
          subtitle: Text(cards[index]["category"]),
          onTap: isFixedCategory
              ? null
              : () {
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

        if (isFixedCategory) {
          return listTile;
        } else {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                cards.removeAt(index);
              });
            },
            child: listTile,
          );
        }
      },
    );
  }

  //レスポンシブ対応PC用
  // Widget _buildDesktopLayout(BuildContext context) {
  //   return SingleChildScrollView(
  //     controller: _scrollController,
  //     child: Center(
  //       child: DataTable(
  //         columns: const [
  //           DataColumn(label: Text('カード名')),
  //           DataColumn(label: Text('カテゴリ')),
  //           DataColumn(label: Text('所持枚数')),
  //         ],
  //         rows: List<DataRow>.generate(
  //           cards.length,
  //           (index) => DataRow(
  //             cells: [
  //               DataCell(
  //                 TextField(
  //                   decoration: InputDecoration(
  //                     hintText:
  //                         index < cards.length ? cards[index]["name"] : '',
  //                   ),
  //                   onChanged: (value) {
  //                     setState(() {
  //                       cards[index]["name"] = value;
  //                     });
  //                   },
  //                 ),
  //               ),
  //               DataCell(
  //                 DropdownButton<String>(
  //                   value: cards[index]["category"],
  //                   items: categories
  //                       .map<DropdownMenuItem<String>>(
  //                         (category) => DropdownMenuItem(
  //                           value: category,
  //                           child: Text(category),
  //                         ),
  //                       )
  //                       .toList(),
  //                   onChanged: (value) {
  //                     setState(() {
  //                       cards[index]["category"] = value!;
  //                     });
  //                   },
  //                 ),
  //               ),
  //               DataCell(
  //                 DropdownButton<int>(
  //                   value: cards[index]["quantity"],
  //                   items: quantities
  //                       .map<DropdownMenuItem<int>>(
  //                         (quantity) => DropdownMenuItem(
  //                           value: quantity,
  //                           child: Text('$quantity'),
  //                         ),
  //                       )
  //                       .toList(),
  //                   onChanged: (value) {
  //                     setState(() {
  //                       cards[index]["quantity"] = value!;
  //                     });
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
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

  int islandAmountMax = 32;
  int get memoryLapseIndex => widget.categories.indexOf("記憶の欠落(固定)");
  int get basicLandIndex => widget.categories.indexOf("基本土地(固定)");
  int get nonBasicLandIndex => widget.categories.indexOf("基本でない土地");
  bool memoryLapseCheckbox = false;
  List<String> get categories => widget.categories;
  late List<int> cardAmounts = List.generate(categories.length, (index) => 0);
  int getCategoryQuantitySum(String category) {
    return widget.cards!
        .where((card) => card['category'] == category)
        .fold<int>(0, (sum, card) => sum + card['quantity'] as int);
  }

  int get totalAmount {
    if (_tabController == null) {
      return 0;
    }
    int tabIndex = _tabController!.index;
    if (tabIndex < 0 || tabIndex >= cardAmountTemplates.length) {
      return 0;
    }
    return cardAmounts.reduce((a, b) => a + b);
  }

  void showSnackBar(
      BuildContext context, String templateName, String categoryName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            '$templateNameの$categoryNameの初期値を所持枚数以下に自動調整しました',
            textAlign: TextAlign.center,
          ),
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(vsync: this, length: cardAmountTemplates.length);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        List<int> initialTemplate = List.from(cardAmountTemplates[0]);
        for (int i = 0; i < initialTemplate.length; i++) {
          String category = categories[i];
          int categoryQuantitySum = getCategoryQuantitySum(category);
          if (initialTemplate[i] > categoryQuantitySum) {
            showSnackBar(context, 'テンプレート1', category);
            initialTemplate[i] = categoryQuantitySum;
          }
        }
        cardAmounts = initialTemplate;
        int nonBasicLandAmount = cardAmounts[nonBasicLandIndex];
        cardAmounts[basicLandIndex] = islandAmountMax - nonBasicLandAmount;
      });
    });

    _tabController?.addListener(() {
      setState(() {
        List<int> currentTemplate =
            List.from(cardAmountTemplates[_tabController?.index ?? 0]);
        String currentTemplateName = 'テンプレート${_tabController!.index + 1}';
        for (int i = 0; i < currentTemplate.length; i++) {
          String category = categories[i];
          int categoryQuantitySum = getCategoryQuantitySum(category);
          if (currentTemplate[i] > categoryQuantitySum) {
            showSnackBar(context, currentTemplateName, category);
            currentTemplate[i] = categoryQuantitySum;
          }
        }
        cardAmounts = currentTemplate;
        int nonBasicLandAmount = cardAmounts[nonBasicLandIndex];
        cardAmounts[basicLandIndex] = islandAmountMax - nonBasicLandAmount;
      });
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

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
              physics: const NeverScrollableScrollPhysics(),
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
                                  for (int i = 0;
                                      i <=
                                          getCategoryQuantitySum(
                                              categories[index]);
                                      i++)
                                    DropdownMenuItem(
                                        value: i, child: Text('$i')),
                                ],
                                onChanged: categories[index].contains("(固定)")
                                    ? null
                                    : (value) {
                                        setState(() {
                                          cardAmounts[index] = value!;
                                          if (index == nonBasicLandIndex) {
                                            cardAmounts[basicLandIndex] =
                                                islandAmountMax - value;
                                          }
                                        });
                                      },
                              ),
                            ),
                          ],
                        ),
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    memoryLapseCheckbox = !memoryLapseCheckbox;
                  });
                },
                child: const Text("記憶の欠落を6枚投入する"),
              ),
              Checkbox(
                value: memoryLapseCheckbox,
                onChanged: (value) {
                  setState(() {
                    memoryLapseCheckbox = value!;
                    memoryLapseCheckbox
                        ? cardAmounts[memoryLapseIndex] = 6
                        : cardAmounts[memoryLapseIndex] = 8;
                  });
                },
              ),
            ],
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
              CustomElevatedButton(
                buttonText: '次へ',
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
          newDeck.add({
            "name": selectedCard["name"],
            "quantity": cardQuantity,
            "category": category // ここを追加
          });
        }

        currentAmount += cardQuantity;
        categoryCards.removeAt(randomIndex);
      }
    }

    return newDeck;
  }

  Map<String, List<Map<String, dynamic>>> _categorizedDeck() {
    Map<String, List<Map<String, dynamic>>> categorizedDeck = {};

    for (var card in deck) {
      String category = card["category"];

      if (category.contains("(固定)")) {
        category = "固定";
      }

      if (!categorizedDeck.containsKey(category)) {
        categorizedDeck[category] = [];
      }

      categorizedDeck[category]!.add(card);
    }

    return categorizedDeck;
  }

  List<Widget> buildCategoryCardList(List<Map<String, dynamic>> cards) {
    return cards.map<Widget>((card) {
      return Container(
        color: const Color.fromARGB(255, 255, 255, 255), // カードの背景色を変更
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 6), // 高さを調整
          child: Text('${card["quantity"]} x ${card["name"]}'),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> categorizedDeck =
        _categorizedDeck();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categorizedDeck.keys.length,
              itemBuilder: (context, index) {
                String category = categorizedDeck.keys.elementAt(index);
                List<Map<String, dynamic>> categoryCards =
                    categorizedDeck[category]!;
                int totalCount = categoryCards.fold<int>(
                    0, (sum, card) => sum + card["quantity"] as int);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
                      child: Text(
                        '$category ($totalCount)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    const Divider(),
                    ...buildCategoryCardList(categoryCards),
                  ],
                );
              },
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
