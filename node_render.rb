#require "./parse_tree.rb"

class NodeRender

  def initialize(tree)

    @tree=tree
    @total=1
    

  end

  def render(node=@tree.root)
    queue = [node]
    puts "Node is NIL" if node.nil?
    until queue.empty?
      current_node = queue.shift
      
      total_nodes(current_node)
      total_tag_type(current_node)
      tag_attr(current_node)

      queue += current_node.children
      
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
    
    puts "For PARENT #{node.name}" unless h.empty?
    h.keys.each do |key|
      puts "Tag #{key} counted #{h[key]} times" 
    end

  end

  def tag_attr(node)
    puts "Node #{node.name} has an ID #{node.id}" unless node.id.nil?
    puts "Node #{node.name} has an Class #{node.class}" unless node.class.nil?
    puts "Node #{node.name} has an Class #{node.name_attr}" unless node.name_attr.nil?
  end

end





