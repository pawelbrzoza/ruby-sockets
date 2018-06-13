#!/usr/bin/ruby

begin
	a=2
	b=3
	eval("puts(a)")
	eval("puts(b)")
	eval("puts(a+b)")
	puts "[child] works"
	sleep(4)
rescue Exception
	puts "[child] error"
end
