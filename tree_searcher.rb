class TreeSearcher
  def initialize(tree)
    @tree=tree
  end

  def search_by(sym, string)
    queue = [@tree.root]
    total_matches=[]
    until queue.empty?
      current_node = queue.shift


      total_matches << current_node if find_match?(current_node, sym, string)

      queue += current_node.children
    end

    puts "TOTAL MATCHES"
    render_nodes(total_matches)
  end

  def find_match?(node, sym, string)
    #same as node.name if sym==name
   
     node.send(sym) && node.send(sym).include?(string)
  end

  def search_descendents(node, sym, string)
    queue = [node]
    total_matches=[]
    until queue.empty?
      current_node = queue.shift

      total_matches << current_node if find_match?(current_node, sym, string)

      queue += current_node.children
      
    end

    puts "TOTAL MATCHES"
    render_nodes(total_matches)

  end

  def search_ancestors(node, sym, string)
    puts "We are looking from a #{node.name}"
    queue = [node]
    total_matches=[]
    until queue.empty?
      current_node = queue.shift

      total_matches << current_node if find_match?(current_node, sym, string)
      puts "NAME OF A PARENT #{current_node.parent.name}" unless current_node.parent.nil?
      queue << current_node.parent if current_node.parent
      
    end

    total_matches.empty? ? (puts "No matches") : (puts "TOTAL MATCHES #{total_matches[0].name}")

    #render_nodes(total_matches_parents)

  end

  def render_nodes(arr)
    arr.each do |node|
      NodeRender.new(@tree).render(node)
    end
  end

end