import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('コンタクト'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/contact/profile.jpeg'),
                radius: 60,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'お問い合わせ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'お問い合わせは以下の連絡先までお願いします。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'GitHub',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            InkWell(
              onTap: () => launchUrl(
                  Uri.parse('https://github.com/otimposch/Forgetful-Fish-')),
              child: const Text(
                'https://github.com/otimposch/Forgetful-Fish-',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Twitter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            InkWell(
              onTap: () =>
                  launchUrl(Uri.parse('https://twitter.com/Dandan_Tenten')),
              child: const Text(
                '@Dandan_Tenten',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'プロフィール',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'サイト作成者は、ダンダーンゲームを日本に普及させるべく尽力しているフリーランスのプログラマーです。このアプリはGPT-4を使ってほぼコピペで作りました。すごい、GPTすごい',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'その他の情報',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'このwebアプリは、ダンダーンゲームを愛してやまない作成者が個人的に遊ぶために開発したアプリです。不具合があった場合教えてくれると助かります。',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
