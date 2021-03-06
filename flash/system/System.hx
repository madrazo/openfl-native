package flash.system;


import flash.Lib;


class System {
	
	
	public static var deviceID (get, null):String;
	public static var totalMemory (get, null):Int;
	
	
	static public function exit (code:Int = 0) {
		
		Lib.close ();
		
	}
	
	
	static public function gc ():Void {
		
		#if neko
		return neko.vm.Gc.run(true);
		#elseif cpp
		return cpp.vm.Gc.run(true);
		#elseif js
		return untyped __js_run_gc();
		#else
		#error "System not supported on this target"
		#end
		
	}
	
	
	
	
	// Getters & Setters
	
	
	
	
	private static function get_deviceID ():String { return nme_get_unique_device_identifier (); }
	
	
	private static function get_totalMemory ():Int {
		
		#if neko
		return neko.vm.Gc.stats().heap;
		#elseif cpp
		return untyped __global__.__hxcpp_gc_used_bytes();
		#elseif js
		return untyped __js_get_heap_memory();
		#else
		#error "System not supported on this target"
		#end
		
	}
	
	
	
	
	// Native Methods
	
	
	
	
	private static var nme_get_unique_device_identifier = Lib.load ("nme", "nme_get_unique_device_identifier", 0);
	
	
}