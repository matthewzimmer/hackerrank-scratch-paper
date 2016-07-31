Tree::Node = Struct.new(:data, :left, :right) do

  def preorder_traverse
    result = []
    result << data
    unless left.nil?
      result+=left.preorder_traverse
    end
    unless right.nil?
      result+=right.preorder_traverse
    end
    result
  end

  def postorder_traverse
    result = []
    unless left.nil?
      result+=left.postorder_traverse
    end
    unless right.nil?
      result+=right.postorder_traverse
    end
    result << data
    result
  end

  def inorder_traverse
    result = []
    unless left.nil?
      result+=left.inorder_traverse
    end
    result << data
    unless right.nil?
      result+=right.inorder_traverse
    end
    result
  end

end
