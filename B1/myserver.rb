require 'sinatra'
require File.expand_path('../messageboard', __FILE__)

def newpass( len )
      chars = ("a".."z").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      return newpass
end

mess = Array.[]
10.times do |i|
  au = newpass(5).capitalize
  mes = newpass(20)
  mess << Message.new(i, mes, au)
end


messmanager = Message_manage.new(mess)


get '/' do
  method = params[:method].to_s
  info = params[:info].to_s
  if info == ""
    @newmess = messmanager.message.sort_by{ |i| i.created_at }
    erb :show
  elsif method == "id"
    @newmess = messmanager.search_id(info.to_i)
    erb :show
  else method == "author"
    @newmess = messmanager.search_author(info)
    erb :show
  end
end


enable :sessions

get "/add" do
  erb :add
end

post "/add" do
  if params[:message].to_s.length >= 10 && params[:author] != ""
     mes = Message.new(0, params[:message], params[:author], )
     messmanager.add_mess(mes)
     '<p style="text-align:center;">添加完成<br>两秒后返回留言板</p><meta http-equiv ="refresh" content="2;url=/">'
  else
    session["message"] = params[:message]
    session["author"] = params[:author]
    '<p style="text-align:center;">添加失败，请确认作者不为空，留言内容不少于十个字<br>两秒后返回重新编辑</p><meta http-equiv ="refresh" content="2;url=/re_add">'
  end
end

get "/re_add" do
  @message = session["message"]
  @author = session["author"]
  erb :add
end

get "/delete/:id" do
  m = messmanager.delete_mes(params["id"])
  if m == -1
    '<p style="text-align:center;">id错误,发现不存在id<br>两秒后返回留言板</p><meta http-equiv ="refresh" content="2;url=/">'
  else
    '<p style="text-align:center;">删除成功<br>两秒后返回留言板</p><meta http-equiv ="refresh" content="2;url=/">'
  end
end

get '/edit/:id' do
  @message = ''
  @author = ''
  @id = 0
  messmanager.message.each do |i|
    if i.id == params["id"].to_i
      @message = i.message
      @author = i.author
      @id = i.id
      break
    end
  end
  erb :edit
end

post "/edit" do
  if params[:message].to_s.length >= 10 && params[:author] != ""
    messmanager.message.each do |i|
      if i.id == params[:id].to_i
        i.message = params[:message]
        i.author = params[:author]
        i.created_at = Time.new
        break
      end
    end
  '<p style="text-align:center;">编辑完成<br>两秒后返回留言板</p><meta http-equiv ="refresh" content="2;url=/">'
  else
    session["id"] = params[:id]
    session["message"] = params[:message]
    session["author"] = params[:author]
    '<p style="text-align:center;">编辑失败，请确认作者不为空，留言内容不少于十个字<br>两秒后返回重新编辑</p><meta http-equiv ="refresh" content="2;url=/fail_re_edit">'
  end
end

get "/fail_re_edit" do
  @id = session["id"].to_i
  @message = session["message"]
  @author = session["author"]
  erb :edit
end

error do
  '对不起，这里发生错误' + env['sinatra.error'].message
end
