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
def correct(student)
  puts "请输入修改信息  姓名 年龄 性别"
  info = gets.split
  student.name = info[0].to_s
  student.age = info[1].to_i
  student.gender = info[2]
end
def store ( array )
   newArray = change(array)
   File.open("student.yaml","w") do |io|
     YAML.dump(newArray,io)
   end
end

def show(array)
  array.each do |i|
      puts i.info
  end
end


def change(array)   #用哈希数组保存学生信息
  newArray = Array.new
  array.each do |i|
     hash = Hash("id" => i.id, "name" => i.name, "age" => i.age, "gender" => i.gender)
     newArray.push(hash)
  end
  return  newArray
end

def rechange(newArray)
  array = Array.new
  newArray.each do |i|
     student = Student.new(i["id"].to_i, i["name"], i["age"], i["gender"])
     array.push(student)
  end
  return array
end


def order(array)
  puts "1.Id排序 2.姓名排序 3.年龄排序"
  n = gets
  case n.to_i
  when 1
    array = array.sort_by {|u| u.id.to_i}
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
   newArray = YAML.load_file("student.yaml")
   array = rechange(newArray)
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
   puts "                         1、添加学生"
   puts "                         2、删除学生"
   puts "                         3、修改学生信息"
   puts "                         4、查询学生信息"
   puts "                         5、学生排序"
   puts "                         0、退出"
   n = gets

   case n.to_i
   when 1
     array.push(add(array.length))
     store(array)
   when 2
     puts "请输入要删除学生的id"
     n = gets
     j=0
     array.each do |i|
       if i.id == n.to_i
          j = i.id
          array.delete(i)
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
     array.each do |i|
       if i.id == n.to_i
          correct(i)
          break
       end
     end
     store(array)
   when 4
     puts "请输入要查询学生的id"
     n = gets
     j=0
     array.each do |i|
       if i.id == n.to_i
          j = i
          puts i.info
          break
       end

     end
     if j == array.length
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
