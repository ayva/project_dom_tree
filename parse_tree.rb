require "./loader.rb"
require "./dom.rb"

Tag = Struct.new(:name, :class, :id, :name_attr, :data, :parent, :children)

class ParseTree

  attr_reader  :root

  def initialize(file)

    @all_tags=["html","head","title","body","div","main","header","span","h1","h2","ul","li"]

    @root = Tag.new("<!doctype html>", nil, nil, nil, file , nil,[])

  end


  def build_tree
    queue = [@root]

    
    
    until queue.empty?
      current_square = queue.shift
      build_children(current_square)
      queue += current_square.children
      
      puts "For parent #{current_square.name}"
      current_square.children.each do |kid|
        puts "Kids name #{kid.name}"
      end
      queue.each do |tag|
        puts "QUEUE -------- Tags name #{tag.name}"
      end
      


    end
  end

  def build_children(current_square)

    arr=current_square.data
    #puts arr.inspect
    i=0
    puts "Beggining build a child"
    until arr[i].nil? 
      
      #puts "arr[i] is #{arr[i]}"
      if arr[i].scan(/^<\w*/).empty? 
        i+=1
        next 
      else
        tag_name = arr[i].scan(/^<\w*/)[0][1..-1]
      end

      puts "tag name is #{tag_name.inspect}"
      # next if tag_name.empty?
      open_index=i
      @all_tags.include? tag_name
      closing_tag = "</#{tag_name}>"
      puts "closing tag is #{closing_tag}"
      
      stack = [tag_name]
      #puts arr[i].class
      until arr[i].nil? || stack.empty?
        p stack

        # arr[i].to_s.empty? || arr[i].include?(closing_tag)
        if arr[i].scan(/^<\w*/)
          stack << arr[i] if arr[i] == "<#{tag_name}>"
        elsif arr[i] == closing_tag
          stack.pop
        end

        # puts i
        i+=1
      end
      puts "tag name #{tag_name}"
      unless tag_name.empty?

      child = Tag.new(tag_name, nil, nil, nil, arr[open_index+1..i-1], current_square, [])

      
      puts "child name is #{child.name}"
      current_square.children << child 

      # puts "added a child"
      end
      i += 1
    end
  end

end


file = Loader.new.load
html = ParseTree.new(file)

#html.build_children(html.root)
html.build_tree


