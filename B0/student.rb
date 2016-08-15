#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
require 'yaml'


class  Student
    attr_accessor :id, :name, :age, :gender                             #类
    def initialize (id, name, age, gender)
      @id = id
      @name = name
      @age = age
      @gender = gender
    end
    def  info
      s = format("%03d", @id)
      s + @name + @age.to_s + @gender
    end

end

def newpass( len )
      chars = ("a".."z").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      return newpass
end

def add( i )
   puts "请输入学生的信息 姓名 年龄 性别(以空格或回车隔开)："
   info = gets.split
   Student.new(i, info[0], info[1], info[2])
end

def store ( array )
   File.open("student.yaml","w") do |io|
   YAML.dump(array,io)
   end
end

def show(array)
  array.each do |i|
      puts array[i].info
  end
end


def change(array)   #用哈希保存学生信息
  hash = Hash.new


end


def order(array)
  puts "1.Id排序 2.姓名排序 3.年龄排序"
  n = gets
  case n.to_i
  when 1
    array = array.sort_by {|u| u.id}
    show(array)
  when 2
    array = array.sort_by {|u| u.name}
    show(array)
  when 3
    array = array.sort_by {|u| u.age.to_i}
    show(array)

  else
    print  "编号输入错误，请重新输入"
  end
end

if File::exists?( "student.yaml" )
   array = YAML.load_file("student.yaml")
else
   array =Array.new
   100.times do |i|
      names = newpass(6)
      names = names.capitalize
      gen = rand(2).zero? ? "男" : "女"
      array[i] =  Student.new(i, names, rand(15..20), gen)
   end
   store(array)
end

loop do
   puts "                       学生管理系统"
   puts "                         1、添加"
   puts "                         2、删除"
   puts "                         3、修改"
   puts "                         4、查询"
   puts "                         5、排序"
   puts "                         0、退出"
   n = gets

   case n.to_i
   when 1
     array.push(add(array.length-1))
     store(array)
   when 2
     puts "请输入要删除学生的id"
     n = gets
     j=0
     array.each do |i|
       if array[i].id == n.to_i
          array.delete_at(i)
          j = i
          break
       end
     end
     if j == array.length-1
        puts "此学生不存在！"
     end
     store(array)
   when 3
     puts "请输入要修改学生的id"
     n = gets
     stu = add(n.to_i)
     array.each do |i|
       if array[i].id == n.to_i
          array.delete_at(i)
          array[i] = stu
          break
       end
     end
     store(array)
   when 4
     puts "请输入要查询学生的id"
     n = gets
     j=0
     array.each do |i|
       if array[i].id == n.to_i
          puts array[i].info
          break
       end
       j = i
     end
     if j == array.length-1
        puts "此学生不存在！"
     end

   when 5
      order(array)

   when 0
     exit(0)
   else
     puts "编号输入错误，请重新输入"
   end

end
