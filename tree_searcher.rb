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
      puts  
    end
    total_matches.each do |node|
      NodeRender.new(@tree).render(node)
    end
  end

  def find_match?(node, sym, string)
    #same as node.name if sym==name
     node.send(sym) == string 
     
  end

end