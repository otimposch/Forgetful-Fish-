import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgetful Fishとは？'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/top_image.png'), // トップ画像を配置する
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    // Mobile layout
                    return _mobileLayout(context);
                  } else {
                    // Desktop layout
                    return _desktopLayout(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _commonElements(context),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _commonElements(context),
          ),
        ),
        const SizedBox(width: 32),
        const Expanded(
          child: Placeholder(), // この部分に追加情報や画像を配置してください
        ),
      ],
    );
  }

  List<Widget> _commonElements(BuildContext context) {
    return [
      const Text(
        'Forgetful Fishの魅力に触れよう！',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      const Text(
          'Dandan MTGが開発したForgetful Fishは、マジック:ザ・ギャザリングの独特で魅力的なフォーマットです。このフォーマットでは、1つのデッキで2人、さらに双頭巨人のルールを適用すれば最大4人で楽しめます。'),
      const SizedBox(height: 16),
      const Text(
        '独自のルールと戦術',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      const Text(
          'Forgetful Fishでは通常のマジックとは異なるカードの組み合わせや戦術が生まれます。例えば、記憶の欠落（Memory Lapse）やダンダーン（Dandan）などのカードが非常に複雑で面白い動きを見せ、戦略性が高まります。'),
      const SizedBox(height: 16),
      const Text(
        '幻視の魔除けと神の怒り',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      const Text(
          'ダンダーンの生息条件を利用して、幻視の魔除け（Vision Charm）が1マナで神の怒り（Wrath of God）の効果を発揮することができるのも、このフォーマットならではの刺激的な要素です。'),
      const SizedBox(height: 16),
      const Text(
        'アクセシビリティの高さ',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      const Text(
          'デッキが1つあればすぐに遊ぶことができるため、多くのプレイヤーにとってアクセシビリティが高いフォーマットです。マジックを長い間プレイしていない方や、カードを持っていない方でも楽しむことができます。'),
      const SizedBox(height: 16),
      const Text(
        'Forgetful Fishの歴史',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      const Text(
          'Dandan MTGコミュニティが独自のルールを探求し、従来のマジックの枠にとらわれない楽しみ方を追求することから始まりました。これにより、プレイヤーは新たな戦術や戦略を発見し、マジックの世界に新たな息吹を与えることができました。'),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () {
          // STEP1 に遷移する
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        child: const Text('早速デッキを作る'),
      ),
    ];
  }
}
