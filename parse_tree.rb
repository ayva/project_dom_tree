require "./loader.rb"
require "./dom.rb"
require "./node_render.rb"
require "./tree_searcher.rb"

class ParseTree

  attr_reader  :root

  def initialize(file)

    @all_tags=["html","head","title","body","div","main","header","span","h1","h2","ul","li"]

    @root = Tag.new("<!doctype html>", nil, nil, nil, file , nil,[], [])

  end


  def build_tree
    queue = [@root]

    
    
    until queue.empty?
      current_node = queue.shift
      build_children(current_node)
      queue += current_node.children
      queue.each do |tag|
        #puts "QUEUE ----tag----  #{tag.name}"
      end
      puts "PARENT #{current_node.name} !!!!"
      current_node.children.each do |kid|
        print "/ #{kid.name} /"
        
      end
      puts
      
    end
    
  end

  def build_children(current_node)
    i=0
    arr=current_node.data 
    
    until arr[i].nil? 

      if take_tag_name(arr[i]) && take_tag_name(arr[i])[0] == ""

        tag_name = take_tag_name(arr[i])[1]

        p tag_name

        classy = take_class(arr[i]) if has_class?(arr[i])

        id = take_id(arr[i]) if has_id?(arr[i])

        name_attr = take_name_attr(arr[i]) if has_name_attr?(arr[i])
      else
        i+=1
        next
      end
      
      raise "Oops, empty" if tag_name.empty?

      open_index = i
      
      if arr.length<2
        puts "Only one line in array"
        return
      end

      i = find_closing_tag(arr,open_index,tag_name)
      
      grab_text(open_index, i, current_node)


      
      child = Tag.new(tag_name, classy, id, name_attr, arr[open_index+1..i-1], current_node, [],[])
      puts "child name is #{child.name}"
      current_node.children << child 
      
      i += 1
      
    end

  end

  def  find_closing_tag(arr,i,tag_name)

    #Should return i if arr has only one element
    return i if check_tag_sameline(arr,i)
    stack = [tag_name]
    i+=1    
    until stack.empty? || arr[i].nil?
      if take_tag_name(arr[i])
        #puts "take tag #{take_tag_name(arr[i])}"
        if take_tag_name(arr[i])[1] == tag_name
          if take_tag_name(arr[i])[0] == "/" 
            stack.pop
          else
            stack << tag_name
          end
        end
      end
      i+=1
      return i-1 if stack.empty?
    end
    puts "Didn't find closing tag" if arr[i].nil?
    #index of a closing tag
    
  end

  def take_tag_name(string)
    #for open tag returns  [["", "html"]], for closing tag [["/", "html"]]

    # old regex = /<(\/?)(\w+)>/

    regex = /<(\/?)(\w+)/

    scanned = string.scan(regex)[0]

    scanned.nil? ? false : scanned

  end

  def has_class?(string)
    regex = /class="[^"]*"/

    !!string.scan(regex)[0]
  end

  def take_class(string)

    regex = /class="[^"]*"/

    classy = string.scan(regex)[0]

    classy.slice!("class=")

    classy

  end

  def has_id?(string)
    regex = /id="[^"]*"/
    !!string.scan(regex)[0]
  end

  def take_id(string)

    regex = /id="[^"]*"/

    id = string.scan(regex)[0]

    id.slice!("id=")

    id

  end

  def has_name_attr?(string)
    regex = /name="[^"]*"/
    !!string.scan(regex)[0]
  end

  def take_name_attr(string)

    regex = /name="[^"]*"/

    name = string.scan(regex)[0]

    name.slice!("name=")

    name

  end

  def grab_text(open_index, close_index, current_node)
    #current_node.text = []
    arr = current_node.data
    #regex looking for text between tags <tag>Text</tag>
    regex = />.*</

    if open_index == close_index && check_tag_sameline(arr, open_index)
      p
      current_node.text << arr[open_index].scan(regex)[0][1..-2]

      puts "here"
    end
    
    regex = />\w*</

    until open_index == close_index
      if !take_tag_name(arr[open_index])
        current_node.text << arr[open_index]

      elsif arr[open_index].scan(regex)[0].nil?

      elsif arr[open_index].scan(regex)[0][1..-2]
        current_node.text << arr[open_index].scan(regex)[0][1..-2]
      end
      open_index += 1
    end


    puts "Tag #{current_node.name} text #{current_node.text }"
  end

  def check_tag_sameline(arr,i)
    
    #true if found tags in one line
    #false if no 2 tag in one line

    !arr[i].scan(/>.*</)[0].nil?

  end


end


file = Loader.new.load
html = ParseTree.new(file)

html.build_children(html.root)
#html.root.children.each {|kid| puts kid.name}
# html.take_tag_name('</div class="class 2" id="id" name="name1 name2">')

#NodeRender.new(html).render

# TreeSearcher.new(html).search_by(:name,"title")

 #find_closing_tag(html.root.data,0,"head")


