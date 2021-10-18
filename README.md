<!-- 本文件由 ./readme.make.md 自动生成，请不要直接修改此文件 -->

# req

try call a async function , return value same as the function , on exception print error and ignore

## use

```dart
import 'package:req/init.dart';

Future<int> test1() async {
  await Future.delayed(Duration(seconds: 1));
  throw Exception('test error');
}

Future<int> test2() async {
  await Future.delayed(Duration(seconds: 1));
  return 1;
}

void main() async {
  print('await sleep 1 seconds');
  var r = await tryCatch(() => test1());
  print(r); //null
  print(await tryCatch(() => test2())); //1
  print('done');
}

```
