#require "./parse_tree.rb"

class NodeRender

  def initialize(tree)

    @tree=tree
    @total=1
    

  end

  def render(node=tree.root)
    queue = [node]
    puts "Node is NIL" if node.nil?
    until queue.empty?
      current_node = queue.shift
      
      total_nodes(current_node)
      total_tag_type(current_node)

      queue += current_node.children
      puts
    end
    puts "Total nodes in a tree #{@total}"
  end

  def total_nodes(node)
    @total+=node.children.length unless node.nil?
  end

  def total_tag_type(node)
    h={}
    h.default=0
    node.children.each do |kid|
      h[kid.name]+=1
    end
    #puts "I'm in a total_tag_type method"
    puts "For PARENT #{node.name}" unless h.empty?
    h.keys.each do |key|
      puts "Tag #{key} counted #{h[key]} times" 
    end

  end

end





