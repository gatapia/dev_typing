#library('dev_typing');
#import('dart:html');
#source('lessons.dart');

void main() {
  final Element instructionsPnl = query('#instructions');
  final Element sourcePnl = query('#source');
  final Element targetPnl = query('#target');
  
  var lesson = LESSONS[(LESSONS.length * Math.random()).toInt()];
  new DevTypingTutor(lesson, instructionsPnl, sourcePnl, targetPnl);
}

class DevTypingTutor {  
  final Element _instructionsPnl, _sourcePnl, _targetPnl;
  final String _lesson;
  final List<String>_ignoreableIdentifiers;
  
  DevTypingTutor(this._lesson, this._instructionsPnl, this._sourcePnl, this._targetPnl) : 
        _ignoreableIdentifiers = new List<String>.from(['Alt', 'Shift', 'Control', 'Win', 'U+005D']) {    
    document.on.keyDown.add(_onKey);
    _sourcePnl.text = _lesson;
  }
  
  void _onKey(KeyboardEvent e) {        
    e.preventDefault();
    e.stopImmediatePropagation();
    if (_ignoreableIdentifiers.indexOf(e.keyIdentifier) >= 0) return;
    _processKey(e);    
  }
  
  void _processKey(KeyboardEvent e) {
    KeyName s;
    print('altGraphKey: ${e.altGraphKey} altKey ${e.altKey} ctrlKey ${e.ctrlKey} keyIdentifier ${e.keyIdentifier} keyLocation: ${e.keyLocation} metaKey: ${e.metaKey} shiftKey: ${e.shiftKey}');
    var key = e.keyIdentifier;
    if (e.altKey) key = 'Alt+$key';
    if (e.ctrlKey) key = 'Control+$key';
    if (e.shiftKey) key = 'Shift+$key';
    
    if (e.keyIdentifier.startsWith('U+')) {
      print('charchodeof ${e.keyIdentifier.charCodes}');
      print('unicode: ${e.keyIdentifier} codepointsToString: ${new String.fromCharCodes([e.keyIdentifier])}');
    }
    _targetPnl.text = '{_targetPnl.text}$key';    
  }
}