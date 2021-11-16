import 'dart:math';

class Preferences {

  // These values should be doubles in the future
  final int _MIN_N = -30;
  final int _MAX_N = 30;
  final int _MIN_A_VALUE = -100;
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

    bool minNChanged = false;
    bool minAChanged = false;
    bool maxAChanged = false;

    // Constrain minimum values depending on the operation
    switch(operation) {
      case '+':
      case '-':
      case '*':
      case '/':
        _minN = 2;
        minNChanged = true;
        break;

      case 'root':
      case '!':
        _minA = 0;
        minAChanged = true;
        break;

      case 'log':
        _minA = 1;
        _minN = 2;
        minAChanged = true;
        minNChanged = true;
        break;

      case 'sum':
        _minN = 1;
        _maxA = 0;
        minNChanged = true;
        maxAChanged = true;
        break;
    }

    if(!minNChanged) {
      _minN = _MIN_N;
    }
    if(!minAChanged) {
      _minA = _MIN_A_VALUE;
    }
    if(!maxAChanged) {
      _maxA = _MAX_A_VALUE;
    }

    _maxN = _MAX_N;
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
  /// * Returns true if successful, false otherwise.
  bool setMinN(int value) {

    // Arithmetic and log operations have special _minN constraints
    switch(_operation) {
      case '+':
      case '-':
      case'*':
      case'/':

        if(value < 2) {
          return false;
        }
        break;

      case 'log':

        if(value <= 0) {
          return false;
        }
        break;

      case 'sum':

        if(value < _maxA) {
          return false;
        }
        break;
    }

    // Don't let users enter a greater min than max
    if((value <= _maxN) && (value >= _MIN_N)){
      _minN = value;
      return true;
    }else{
      return false;
    }
  }

  /// Sets the maximum value n can be.
  /// * Returns true if successful, false otherwise.
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
  /// * Returns true if successful, false otherwise.
  bool setMinA(int value) {

    // Root, factorial, and log operations have special _minA constraints
    switch(_operation) {
      case 'root':
      case '!':

        if(value < 0) {
          return false;
        }
        break;

      case 'log':

        if(value <= 1) {
          return false;
        }
        break;
    }

    // Don't let users enter a greater min than max
    if((value <= _maxA) && (value >= _MIN_A_VALUE)){
      _minA = value;
      return true;
    }else{
      return false;
    }
  }

  /// Sets the maximum value a can be.
  /// * Returns true if successful, false otherwise.
  bool setMaxA(int value) {
    // Don't let users enter a smaller max than min
    if((value >= _minA) && (value <= _MAX_A_VALUE)){
      // Special case for the sum operation
      if(_operation.compareTo('sum') == 0) {
        // i cannot be greater than n
        if(value > _minN) {
          return false;
        }
      }
      _maxA = value;
      return true;
    }else{
      return false;
    }
  }
  
  /// Sets the current operation.
  void setOperation(String newOperation) {

    // Constrain minimum values depending on the operation
    switch(newOperation) {
      case '+':
      case '-':
      case '*':
      case '/':
        _minN = 2;
        break;

      case 'root':
      case '!':
        _minA = 0;
        break;

      case 'log':
        _minA = 2;
        _minN = 1;
        break;
      case 'sum':
        _minN = 1;
        _maxA = 0;
    }

    _operation = newOperation;
  }

  /// Randomizes the minimum and maximum values n can be.
  void randomizeRangeOfN() {

    int newMinN;

    // Ensure _minN <= _maxN
    do {
      // Constrain minimum values depending on the operation
      switch(_operation) {
        case '+':
        case '-':
        case '*':
        case '/':

          // Ensure there are at least two terms
          newMinN = Random.secure().nextInt(_MAX_N) + 2;
          break;

        case 'log':

          // Ensure n > 0
          newMinN = Random.secure().nextInt(_MAX_N) + 1;
          break;

        default:
          newMinN = Random.secure().nextInt(_MAX_N - _MIN_N + 1) + _MIN_N;
          break;
      }
    } while (!setMinN(newMinN));

    int newMaxN;

    // Ensure _maxN >= _minN
    do {
      newMaxN = Random.secure().nextInt(_MAX_N + 1);
    } while (!setMaxN(newMaxN));
  }

  /// Randomizes the minimum and maximum values a can be.
  void randomizeRangeOfA() {

    int newMinA;

    //Ensure _minA <= _maxA
    do {
      // Constrain minimum values depending on the operation
      switch(_operation) {
        case 'root':
        case '!':

          // Ensure a >= 0
          newMinA = Random.secure().nextInt(_MAX_A_VALUE + 1);
          break;

        case 'log':

          // Ensure a > 0
          newMinA = Random.secure().nextInt(_MAX_A_VALUE) + 1;
          break;

        default:
          newMinA = Random.secure().nextInt(_MAX_A_VALUE - _MIN_A_VALUE + 1) + _MIN_A_VALUE;
          break;
      }
    } while(!setMinA(newMinA));

    int newMaxA;

    //Ensure _maxA >= _minA
    do {
      newMaxA = Random.secure().nextInt(_MAX_A_VALUE + 1);
    } while(!setMaxA(newMaxA));
  }

  /// Randomize the value of n within the range of its minimum and maximum possible values.
  void randomizeN() {
    if(_maxN == _minN) {
      _n = _maxN;
    } else {
      _n = Random.secure().nextInt(_maxN - _minN + 1) + _minN;
    }
  }

  /// Generates a random constant within the range of its minimum and maximum possible values.
  /// * Returns a random constant between the minimum and maximum values of A.
  int generateConstant() {
    if(_maxA == _minA) {
      return _maxA;
    } else {
      return Random.secure().nextInt(_maxA - _minA + 1) + _minA;
    }
  }
}