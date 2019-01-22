package ;

import tink.unit.*;
import tink.testrunner.*;
import obfu.Obfu;

@:asserts
class RunTests {

  static function main() {
    Runner.run(TestBatch.make([
      new RunTests(),
    ])).handle(Runner.exit);
  }
  
  function new() {}
  
  public function string() {
    asserts.assert(Obfu.string('123') == '123');
    asserts.assert(Obfu.string('1234567890') == '1234567890');
    asserts.assert(Obfu.string('123456789012345678901234567890') == '123456789012345678901234567890');
    asserts.assert(Obfu.string('aaa') == 'aaa');
    asserts.assert(Obfu.string('aaaaaaaaaa') == 'aaaaaaaaaa');
    asserts.assert(Obfu.string('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa') == 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    return asserts.done();
  }
  
}