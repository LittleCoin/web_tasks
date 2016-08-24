

class Message

  attr_accessor :id, :message, :author, :created_at

  def initialize(id, message, author)
    @id = id
    @message = message
    @author = author
    @created_at = Time.new
  end
end

class  Message_manage
  @@number = 0
  attr_accessor :message

  def initialize(message)
    @message = message
  end

  def mk_id
    @@number+=1
    return @@number
  end

  def add_mess(mess)
    @@number+=1
    mess.id = @@number
    @message << mess
    return mess.id
  end

  def search_id(id)
    result = []
    @message.each do |i|
      if i.id == id.to_i
        result << i
      end
    end
    return result
  end

  def search_author(author)
    result = []
    @message.each do |i|
      if i.author == author
        result << i
      end
    end
    return result
  end

  def delete_mes(id)
    n = -1
    @message.each do |i|
      if i.id == id.to_i
        n = i.id
        @message.delete(i)
      end
    end
    return  n
  end
end
