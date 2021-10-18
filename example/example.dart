import 'package:req/init.dart';

void main() async {
  final r = await req.get(Uri.parse('https://www.qq.com/robots.txt'));

  print(r.statusCode);
  print(await r.text());
  print('done');
}
