Struct.new(:name, :class, :id, :name_attr, :data, :parent, :children)
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
    p text
    regex = /^<\w*/
    name = text.scan(regex)[0][1..-1]


    





  end



end

parser = Parser.new(test)

parser.parse