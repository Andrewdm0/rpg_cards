import 'dart:math';

final randomGenerator = Random();

int getRandomNumber(num){
  return randomGenerator.nextInt(num) + 1;
}
