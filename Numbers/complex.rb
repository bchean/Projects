#!/usr/local/bin/ruby

def usage_and_exit
	puts 'Usage: ./complex.rb (add|mult) num1 num2'
	puts 'Nums must be specified as either a+bi or a,b.'
	exit 1
end

if ARGV.length != 3
	usage_and_exit
end

op, arg1, arg2 = ARGV[0..2]

class ComplexNum
	attr_reader :a, :b

	SUM_NOTATION_REGEX = /(-?\d+)(\+\d+|-\d+)i/
	VECTOR_NOTATION_REGEX = /(-?\d+),(-?\d+)/

	def self.parse(str)
		case str
		when SUM_NOTATION_REGEX, VECTOR_NOTATION_REGEX
			ComplexNum.new($1, $2)
		else
			usage_and_exit
		end
	end

	def initialize(a, b=0)
		@a, @b = a.to_i, b.to_i
	end

	def +(other)
		ComplexNum.new(@a+other.a, @b+other.b)
	end

	def *(other)
		real = @a*other.a - @b*other.b
		imag = @a*other.b + @b*other.a
		ComplexNum.new(real, imag)
	end

	def to_s
		"#{@a}#{'+' if @b>=0}#{@b}i"
	end
end

num1, num2 = ComplexNum.parse(arg1), ComplexNum.parse(arg2)

case op
when 'add'
	puts num1 + num2
when 'mult'
	puts num1 * num2
else
	usage_and_exit
end

