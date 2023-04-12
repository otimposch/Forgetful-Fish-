import 'package:flutter/material.dart';

class HowToPlayPage extends StatelessWidget {
  const HowToPlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('遊び方'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Forgetful Fish（通称：ダンダーンゲーム）の遊び方',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '1. ゲームの準備',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Forgetful Fish Generator でデッキを生成します。',
            ),
            SizedBox(height: 16),
            Text(
              '2. デッキの構築',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'カードを登録し、デッキの構成を選択して、自動的にデッキを作成します。',
            ),
            SizedBox(height: 16),
            Text(
              '3. ゲームの進行',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'ゲームはプレイヤーがカードを引くことから始まります。プレイヤーはカードを引き、対戦相手にカード名を伝えます。対戦相手は、カードの効果を使用するかどうかを決定します。',
            ),
            SizedBox(height: 16),
            Text(
              '4. ゲームの終了',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'ゲームは、いずれかのプレイヤーが相手プレイヤーのライフポイントを0にするか、デッキからカードを引けなくなるまで続きます。',
            ),
            SizedBox(height: 16),
            Text(
              '注意事項',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Forgetful Fishは、通常のマジックザギャザリングの対戦とは異なるルールが適用されているため、戦術やカードの使い方が変わることがあります。常に新たな戦術やカードの組み合わせを試して、独自のプレイスタイルを楽しんでください。',
            ),
            SizedBox(height: 16),
            Text(
              'ルール変更や新たなアイデア',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'このゲームは、コミュニティのアイデアやフィードバックによって成長しています。新たなルールの提案やゲームに関する意見があれば、ぜひコンタクトページからお寄せください。',
            ),
          ],
        ),
      ),
    );
  }
}
