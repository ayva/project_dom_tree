require "./loader.rb"
require "./dom.rb"

Tag = Struct.new(:name, :class, :id, :name_attr, :data, :parent, :children)

class ParseTree

  attr_reader :start

  def initialize(file)

    @all_tags=["html","head","title","body","div","main","header","span","h1","h2","ul","li"]

    @root = Tag.new(:name = "<!doctype html>", :class, :id, :name_attr, :data = Loader.new.load , :parent, :children)

    queue = [@root]

    until queue.empty?
      build_children(current_square)
      queue += current_square.children
      current_square = queue.shift
    end
  end

  def build_children(current_square)

    arr=current_square.data
    i=0
    until arr[i].nil?
      #"html"
      tag_name = arr[i].scan(regex)[0][1..-1]
      open_index=i
      @all_tags.include? tag_name
      closing_tag = "</#{tag_name}>"
      until arr[i].include? closing_tag
        i+=1
      end

      child=Tag.new
      child.data= arr[open_index..i]
      #parser
      current_square.children << child 

    end

  end