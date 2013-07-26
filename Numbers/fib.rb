#!/usr/local/bin/ruby

def usage_and_exit()
	puts 'Usage: ./fib.rb NUM'
	puts 'NUM must be positive.'
	exit 1
end

if ARGV.empty?
	usage_and_exit
end

begin
	num = Integer(ARGV.first)
rescue ArgumentError
	usage_and_exit
end

if num < 1
	usage_and_exit
end

if num < 3
	puts 1
	exit
end

a, b = 1, 1
current = 2
while current < num
	a, b = b, a+b
	current += 1
end

puts b

