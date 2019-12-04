class DStack<E> {
  final List<E> _stack;
  final int capacity;
  int _top;

  DStack(this.capacity)
      : _top = -1,
        _stack = List<E>(capacity);

  bool get isEmpty => _top == -1;
  bool get isFull => _top == capacity - 1;
  int get size => _top + 1;

  void push(E e) {
    if (isFull) throw StackOverFlowException;
    _stack[++_top] = e;
  }

  E pop() {
    if (isEmpty) throw StackEmptyException;
    return _stack[_top--];
  }

  E get top {
    if (isEmpty) throw StackEmptyException;
    return _stack[_top];
  }
}

class StackOverFlowException implements Exception {
  const StackOverFlowException();
  String toString() => 'StackOverFlowException';
}

class StackEmptyException implements Exception {
  const StackEmptyException();
  String toString() => 'StackEmptyException';
}