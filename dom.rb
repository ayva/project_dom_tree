Tag = Struct.new(:name, :class, :id, :name_attr, :data, :parent, :children)
require './loader.rb'

load = Loader.new
test = load.load

# p test



class Parser

  def initialize(file)
    @file = file
  end

  # text == array

  # while i<array.size
  #   text[i] == scan(/^<\w*/)
  #   name= scan(/^<\w*/)
  #   closing_name="</"+name+">"
  #   until text[i]==closing_name
  #     return text[i_staring..i_match]
  #   end


  def parse_tag(text) 

    #This takes tag name like "div"
    
    t=Tag.new
    t.name = text.scan(/^<\w*/)[0][1..-1]
    # puts "Name of a tag is #{t.name}"
    
    #Takes attribute tag and value
    
    attributes = text.scan(/\w+=.+"/)[0].split("=")

    # puts "attributes are #{attributes}"
    case attributes[0]
      when "class"
        t.class=attributes[1]
      when "id"
        t.id=attributes[1]
      when "name"
        t.name_attr=attributes[1]
    end
      
    # puts "Class is #{t.class}"

    #Collects the data in a div
    t.data = text.scan(/>.*?</)[1..-2]
    # puts "Data is #{t.data}"
    # regex = /\w+=/
    # puts text.scan(regex)[0][0..-2]

  end



end

parser = Parser.new(test.join)

parser.parse_tag('<li class="bold funky important">One unordered list</li>')
