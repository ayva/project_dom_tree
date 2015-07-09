Tag = Struct.new(:name, :class, :id, :name_attr, :data, :parent, :children)

class ParseTree

  attr_reader :start

  def initialize(coords, max_depth)

    x,y = coords

    @root = Tag.new(....)

    queue = ["something"]

    current_square = @root
   
    until queue.empty?
      current_square.children = find_children(current_square)
      queue += current_square.children
      current_square = queue.shift
    end
  end

  def find_children(current_square)