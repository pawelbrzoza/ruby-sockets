#!/usr/bin/ruby

class SimpleNumber

	def initialize(num)
		raise unless num.is_a?(Numeric)
			@x = num
      add(num)
      multiply(num)
  	end

  	def add(y)
    	puts(@x + y)
  	end

  	def multiply(y)
    	puts (@x * y)
  	end
  	
end