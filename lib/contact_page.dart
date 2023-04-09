import 'package:flutter/material.dart';

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
                backgroundImage: AssetImage('assets/images/your_photo.jpg'),
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
              'メールアドレス',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('example@example.com', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              'ツイッター',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('@your_twitter_handle', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              'その他の情報',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'お問い合わせ内容については、必要に応じて返信させていただきます。お問い合わせの際は、具体的な内容や連絡先をお書き添えください。',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
