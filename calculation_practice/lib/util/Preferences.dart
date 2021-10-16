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

  /// Instantiates preferences with absolute max/min values and sets the current operation as the one specified.
  /// * operation: The specified operation.
  Preferences(String operation) {
    _n = 0;
    _minN = _MIN_N;
    _maxN = _MAX_N;
    _minA = _MIN_A_VALUE;
    _maxA = _MAX_A_VALUE;
    this._operation = operation;
  }

  /// Returns n.
  int getN() {
    return _n;
  }

  /// Returns the minimum value n can be.
  int getMinN() {
    return _minN;
  }

  /// Returns the maximum value n can be.
  int getMaxN() {
    return _maxN;
  }

  /// Returns the minimum value a can be.
  int getMinA() {
    return _minA;
  }

  /// Returns the maximum value a can be.
  int getMaxA() {
    return _maxA;
  }

  /// Returns the current operation.
  String getOperation() {
    return _operation;
  }

  /// Sets the minimum value n can be.
  /// * returns true if successful, false otherwise.
  bool setMinN(int value) {
    // Don't let users enter a greater min than max
    if((value <= _maxN) && (value >= _MIN_N)){
      _minN = value;
      return true;
    }else{
      return false;
    }
  }

  /// Sets the maximum value n can be.
  /// * returns true if successful, false otherwise.
  bool setMaxN(int value) {
    // Don't let users enter a smaller max than min
    if((value >= _minN) && (value <= _MAX_N)){
      _maxN = value;
      return true;
    }else{
      return false;
    }
  }

  /// Sets the minimum value a can be.
  /// * returns true if successful, false otherwise.
  bool setMinA(int value) {
    // Don't let users enter a greater min than max
    if((value <= _maxA) && (value >= _MIN_A_VALUE)){
      _minA = value;
      return true;
    }else{
      return false;
    }
  }

  /// Sets the maximum value a can be.
  /// * returns true if successful, false otherwise.
  bool setMaxA(int value) {
    // Don't let users enter a smaller max than min
    if((value >= _minA) && (value <= _MAX_A_VALUE)){
      _maxA = value;
      return true;
    }else{
      return false;
    }
  }

  /// Sets the current operation.
  void setOperation(String newOperation) {
    _operation = newOperation;
  }

  /// Randomizes the minimum and maximum values n can be.
  void randomizeRangeOfN() {
    // Ensure there are at least two terms
    _minN = Random.secure().nextInt(_MAX_N - _MIN_N) + _MIN_N;
    _maxN = Random.secure().nextInt(_MAX_N + 1);
    // Ensure _maxN >= _minN
    if(_minN > _maxN){
      int range = _MAX_N - _minN;
      _maxN = _minN;
      _maxN += Random.secure().nextInt(range) + 1;
    }
  }

  /// Randomizes the minimum and maximum values a can be.
  void randomizeRangeOfA() {
    _minA = Random.secure().nextInt(_MAX_A_VALUE - _MIN_A_VALUE) + _MIN_A_VALUE;
    _maxA = Random.secure().nextInt(_MAX_A_VALUE);
    //Ensure _maxN > _minN
    if(_minA > _maxA){
      int range = _MAX_A_VALUE - _minA;
      _maxA = _minA;
      _maxA += Random.secure().nextInt(range) + 1;
    }
  }

  /// Randomize the value of n within the range of its minimum and maximum possible values.
  void randomizeN() {
    //print('$_maxN - $_minN');
    if(_maxN == _minN) {
      _n = _maxN;
    } else {
      _n = Random.secure().nextInt(_maxN - _minN) + _minN;
    }
  }

  /// Returns a random constant within the range of its minimum and maximum possible values.
  int generateConstant() {
    if(_maxA == _minA) {
      return _maxA;
    } else {
      return Random.secure().nextInt(_maxA - _minA) + _minA;
    }
  }
}