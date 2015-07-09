Tag = Struct.new(:name, :class, :id, :name_attr, :data, :parent, :children)
require './loader.rb'

load = Loader.new
test = load.load

# p test



class Parser

  def initialize(file)

    @file = file


  end

  def parse


    text =  @file[10..12].join
    puts text
    #This takes tag name like "div"
    regex = /^<\w*/
    t=Tag.new
    t.name = text.scan(regex)[0][1..-1]
    puts "Name of a tag is #{t.name}"
    #<div class="inner-div">I'm an inner div!!!</div>
    #Takes attribute tag and value
    regex = /\w+=[^ >]+/

    attributes = text.scan(regex)[0].split("=")
    case attributes[0]
      when "class"
        t.class=attributes[1]
      when "id"
        t.id=attributes[1]
      when "name"
        t.name_attr=attributes[1]
    end
      
    puts "Class is #{t.class}"

    
    #Collects the data in a div
    regex = />.*?</
    t.data = text.scan(regex)[0][1..-2]
    puts "Data is #{t.data}"
    # regex = /\w+=/
    # puts text.scan(regex)[0][0..-2]




    





  end



end

parser = Parser.new(test)

parser.parse