# -*- coding: UTF-8 -*-
puts "hellow world";
puts "我是你爸爸";
print <<EOF
    我是你爸爸
    信不信啊你
EOF



print <<`EOC`                 # 执行命令
	echo fuck him
	echo quick
EOC

print <<"foo", <<"bar"	      # 您可以把它们进行堆叠
	I said foo.
foo
	I said bar.
bar

print <<"EOF";
     个人个看过还
EOF

puts "我在中间"

END {
   puts "我在后面"
}
BEGIN {
   puts "我在前面"
}

puts "听说这个能用\\\ "
puts '听说这个不能用"\\" \ \\'

name="Mr yu"
puts "#{name+" is your father"}"
hash = Hash.new [[1,"yuqinghan"] => [15,"男"]]
puts "#{hash[1]}"
