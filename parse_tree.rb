require "./loader.rb"
require "./dom.rb"

Tag = Struct.new(:name, :class, :id, :name_attr, :data, :parent, :children)

class ParseTree

  attr_reader :start

  # def initialize(file)

  #   @all_tags=["html","head","title","body","div","main","header","span","h1","h2","ul","li"]

  #   @root = Tag.new("<!doctype html>", nil, nil, nil, file , nil,[])

  #   queue = [@root]

  #   current_square = @root

  #   until queue.empty?
  #     build_children(current_square)
  #     queue += current_square.children
  #     current_square = queue.shift
  #   end
  # end

  def build_children(current_square)

    arr=current_square.data
    puts arr.inspect
    i=1
    puts "start build child"
    until arr[i].nil? 
      #"html"
      # t.name = text.scan(/^<\w*/)[0][1..-1]
      puts "arr[i] is #{arr[i]}"
      tag_name = arr[i].scan(/^<\w*/)[0][1..-1]
      puts "tag name is #{tag_name.inspect}"
      # next if tag_name.empty?
      open_index=i
      @all_tags.include? tag_name
      closing_tag = "</#{tag_name}>"
      puts "closing tag is #{closing_tag}"
      until arr[i].nil? || arr[i].include?(closing_tag)
        i+=1
      end

      child = Tag.new
      child.data= arr[open_index+1..i-1]
      puts "child data is #{child.data}"
      current_square.children << child 
      puts "added a child"
      i += 1
    end
  end

end


file = Loader.new
html = ParseTree.new #(load.load)

html.build_children(Tag.new("<!doctype html>", nil, nil, nil, file , nil,[]))



