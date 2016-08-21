

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

  attr_accessor :message

  def initialize(message)
    @message = message
  end

  def add_mess(mess)
    if @message.empty?
      @message << mess
    else
      id = @message.at(-1).id
      mess.id = id + 1
      @message << mess
    end
    return mess.id
  end

  def search_id(id)
    result = Array.[]
    @message.each do |i|
      if i.id == id.to_i
        result << i
      end
    end
    return result
  end

  def search_author(author)
    result = Array.[]
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
