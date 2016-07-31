namespace :trees do
  namespace :traverse do
    task :preorder => :environment do

      n1 = Tree::Node.new(1)
      n2 = Tree::Node.new(2)
      n3 = Tree::Node.new(3)
      n5 = Tree::Node.new(5)
      n4 = Tree::Node.new(4)
      n6 = Tree::Node.new(6)
      root = n3

      root.left = n5
      root.right = n2

      n5.left = n1
      n5.right = n4

      n2.left = n6

      print root.preorder_traverse.join(' ')
    end

    task :postorder => :environment do

      n1 = Tree::Node.new(1)
      n2 = Tree::Node.new(2)
      n3 = Tree::Node.new(3)
      n5 = Tree::Node.new(5)
      n4 = Tree::Node.new(4)
      n6 = Tree::Node.new(6)
      root = n3

      root.left = n5
      root.right = n2

      n5.left = n1
      n5.right = n4

      n2.left = n6

      print root.postorder_traverse.join(' ')
    end


    task :inorder => :environment do

      n1 = Tree::Node.new(1)
      n2 = Tree::Node.new(2)
      n3 = Tree::Node.new(3)
      n5 = Tree::Node.new(5)
      n4 = Tree::Node.new(4)
      n6 = Tree::Node.new(6)
      root = n3

      root.left = n5
      root.right = n2

      n5.left = n1
      n5.right = n4

      n2.left = n6

      print root.inorder_traverse.join(' ')
    end

  end
end
