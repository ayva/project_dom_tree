require "./loader.rb"
require "./dom.rb"



class ParseTree

  attr_reader  :root

  def initialize(file)

    @all_tags=["html","head","title","body","div","main","header","span","h1","h2","ul","li"]

    @root = Tag.new("<!doctype html>", nil, nil, nil, file , nil,[])

  end


  def build_tree
    queue = [@root]

    
    
    until queue.empty?
      current_node = queue.shift
      build_children(current_node)
      queue += current_node.children
      
      puts "PARENT #{current_node.name} !!!!"
      current_node.children.each do |kid|
        print "/ #{kid.name} /"
        
      end
      puts
      queue.each do |tag|
        puts "QUEUE ----tag----  #{tag.name}"
      end
      


    end
  end

  def build_children(current_node)
    i=0
    arr=current_node.data 
    
    until arr[i].nil? 

      tag_name = take_tag(arr[i])

      unless tag_name
        puts "Tag name is empty"
        i+=1
        next
      end
      raise "Ups, empty" if tag_name.empty?

      open_index=i
      find_closing_tag(arr,open_index+1,tag_name)

      child = Tag.new(tag_name, nil, nil, nil, arr[open_index+1..i-1], current_node, [])
      puts "child name is #{child.name}"
      current_node.children << child 
      i += 1
    end

  end

  def  find_closing_tag(arr,i,tag_name)
    stack = [tag_name]
        
    until stack.nil? || arr[i].nil?
      if take_tag(arr[i])
        if take_tag(arr[i]) == tag_name
          stack << take_tag(arr[i])
        elsif  take_tag(arr[i]) == "/" + tag_name
          stack.pop
        end
        puts "Checking stack : #{stack}"
      end
      i+=1
    end
    puts "Didn't find closing tag" if arr[i].nil?
    #index of a closing tag
    i-1
  end

  def take_tag(string)
    
    string.scan(/^<\w*/).empty? ? false : string.scan(/^<\w*/)[0][1..-1]
    #for closing tag returns 2.2.1 :004 > "</html>".scan(/^<\w*/)=> ["<"]
  end

end


file = Loader.new.load
html = ParseTree.new(file)

html.build_children(html.root)
#html.root.children.each {|kid| puts kid.name}
#html.build_tree

 #find_closing_tag(html.root.data,0,"head")


