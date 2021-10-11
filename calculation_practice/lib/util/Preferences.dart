import 'dart:math';

class Preferences {

  final int _MIN_N = 2;
  final int _MAX_N = 30;
  final int _MIN_A_VALUE = 0;
  final int _MAX_A_VALUE = 100;

  int _n = 0;
  int _minN = 0;
  int _maxN = 0;
  int _minA = 0;
  int _maxA = 0;

  String _operation = '';

  Preferences(String operation) {
    _n = 0;
    _minN = _MIN_N;
    _maxN = _MAX_N;
    _minA = _MIN_A_VALUE;
    _maxA = _MAX_A_VALUE;
    this._operation = operation;
  }

  int getN() {
    return _n;
  }

  int getMinN() {
    return _minN;
  }

  int getMaxN() {
    return _maxN;
  }

  int getMinA() {
    return _minA;
  }

  int getMaxA() {
    return _maxA;
  }

  String getOperation() {
    return _operation;
  }

  bool setMinN(int value) {
    // Don't let users enter a greater min than max
    if((value < _maxN) && (value >= _MIN_N)){
      _minN = value;
      return true;
    }else{
      return false;
    }
  }

  bool setMaxN(int value) {
    // Don't let users enter a smaller max than min
    if((value > _minN) && (value <= _MAX_N)){
      _maxN = value;
      return true;
    }else{
      return false;
    }
  }

  bool setMinA(int value) {
    // Don't let users enter a greater min than max
    if((value < _maxA) && (value >= _MIN_A_VALUE)){
      _minA = value;
      return true;
    }else{
      return false;
    }
  }

  bool setMaxA(int value) {
    // Don't let users enter a smaller max than min
    if((value > _minA) && (value <= _MAX_A_VALUE)){
      _maxA = value;
      return true;
    }else{
      return false;
    }
  }

  void setOperation(String newOperation) {
    _operation = newOperation;
  }

  void randomizeRangeOfN() {
    // Ensure there are at least two terms
    _minN = Random.secure().nextInt(_MAX_N - _MIN_N) + _MIN_N;
    _maxN = Random.secure().nextInt(_MAX_N + 1);
    // Ensure _maxN > _minN
    if(_minN > _maxN){
      int range = _MAX_N - _minN;
      _maxN = _minN;
      _maxN += Random.secure().nextInt(range) + 1;
    }
  }

  void randomizeRangeOfA() {
    _minA = Random.secure().nextInt(_MAX_A_VALUE);
    _maxA = Random.secure().nextInt(_MAX_A_VALUE);
    //Ensure _maxN > _minN
    if(_minA > _maxA){
      int range = _MAX_A_VALUE - _minA;
      _maxA = _minA;
      _maxA += Random.secure().nextInt(range) + 1;
    }
  }

  void randomizeN() {
    _n = Random.secure().nextInt(_maxN) + 1;
  }
}