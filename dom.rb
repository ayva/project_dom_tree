Tag = Struct.new(:name, :class, :id, :name_attr, :data, :parent, :children, :text)
require './loader.rb'

load = Loader.new
test = load.load

# p test



class Parser

  def initialize(file)
    @file = file
  end




  def parse_tag (current_node)

    #This takes tag name like "div"
    
    # t=Tag.new
    # t.name = @file.scan(/^<\w*/)[0][1..-1]
    # puts "Name of a tag is #{t.name}"
    
    #Takes attribute tag and value
    
    if @file.include? ("=")
    attributes = @file.scan(/\w+=.+"/).split("=")

    # puts "attributes are #{attributes}"
      case attributes[0]
        when "class"
          current_node.class=attributes[1]
        when "id"
          current_node.id=attributes[1]
        when "name"
          current_node.name_attr=attributes[1]
      end
    end
      
    # puts "Class is #{t.class}"

    #Collects the data in a div
    #t.data = @file.scan(/>.*?</)[1..-2]
    # puts "Data is #{t.data}"
    # regex = /\w+=/
    # puts text.scan(regex)[0][0..-2]

  end



end

# parser = Parser.new(test.join)

# parser.parse_tag('<li class="bold funky important">One unordered list</li>')
