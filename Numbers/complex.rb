#!/usr/local/bin/ruby

def usage_and_exit
	puts 'Usage: ./complex.rb (add|sub|mul|div|neg|inv) num1 [num2]'
	puts 'Nums must be specified as either a+bi or a,b.'
	puts 'a and b must be integers.'
	exit 1
end

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
		@a, @b = a.to_f, b.to_f
	end

	def neg
		ComplexNum.new(-@a, -@b)
	end

	def inv
		ComplexNum.new(1, 0) / self
	end

	def conj
		ComplexNum.new(@a, -@b)
	end

	def +(other)
		ComplexNum.new(@a+other.a, @b+other.b)
	end

	def -(other)
		self + other.neg
	end

	def *(other)
		real = @a*other.a - @b*other.b
		imag = @a*other.b + @b*other.a
		ComplexNum.new(real, imag)
	end

	def /(other)
		temp = self * other.conj
		denom = (other * other.conj).a
		real = temp.a / denom
		imag = temp.b / denom
		ComplexNum.new(real, imag)
	end

	def to_s
		"#{@a}#{'+' if @b>=0}#{@b}i"
	end
end

if ARGV.length != 2 and ARGV.length != 3
	usage_and_exit
end

op, arg1, arg2 = ARGV[0..2]

num1 = ComplexNum.parse(arg1)
num2 = ComplexNum.parse(arg2) if arg2

case op
when 'add'
	puts num1 + num2
when 'sub'
	puts num1 - num2
when 'mul'
	puts num1 * num2
when 'div'
	puts num1 / num2
when 'neg'
	puts num1.neg
when 'inv'
	puts num1.inv
else
	usage_and_exit
end

