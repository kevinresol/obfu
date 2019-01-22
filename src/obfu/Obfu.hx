package obfu;

import haxe.io.Bytes;
import haxe.macro.Expr;
import haxe.macro.Context;

class Obfu {
	public static macro function string(e:Expr):Expr {
		switch e.expr {
			case EConst(CString(v)):
				var key = Bytes.alloc(8);
				for(i in 0...key.length) key.set(i, Std.random(255));
				
				var k = 0;
				var out = Bytes.alloc(v.length);
				for(i in 0...v.length) {
					var code = v.charCodeAt(i);
					out.set(i, code ^ key.get(k++));
					if(k == key.length) k = 0;
				}
				
				return macro obfu.Obfu._string($v{out.toHex()}, $v{key.toHex()});
			case _:
				throw Context.error('Expected string literal', e.pos);
		}
	}
	
	public static function _string(sh:String, kh:String) {
		var sl = sh.length >> 1;
		var kl = kh.length >> 1;
		var s = haxe.io.Bytes.alloc(sl);
		var k = haxe.io.Bytes.alloc(kl);
		for(i in 0...sl) s.set(i, Std.parseInt('0x' + sh.substr(i*2, 2)));
		for(i in 0...kl) k.set(i, Std.parseInt('0x' + kh.substr(i*2, 2)));
		
		var o = haxe.io.Bytes.alloc(sl);
		var ki = 0;
		for(i in 0...sl) {
			o.set(i, s.get(i) ^ k.get(ki++));
			if(ki == kl) ki = 0;
		}
		return o.toString();
	}
}