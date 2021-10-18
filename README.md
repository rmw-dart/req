<!-- 本文件由 ./readme.make.md 自动生成，请不要直接修改此文件 -->

# req

http get or post with timeout ( default 60 seconds )

## use

```dart
import 'package:req/init.dart';

void main() async {
  final r = await req.get('https://www.qq.com/robots.txt');

  print(r.statusCode);
  print(await r.text());
  print('done');
}

```
