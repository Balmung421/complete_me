require_relative 'node'

require 'pry'

class Trie

  attr_accessor :root

  def initialize
    @root = Node.new
  end

  def insert(word)
    current_node = @root
    word.each_char.map do |char|
      if (current_node.char_map.has_key?(char)) == false
        current_node.char_map[char] = Node.new
      end
      current_node = current_node.char_map[char]
    end
    current_node.flag = true
    return
  end

  def count(current_node = @root, words = 0)
    # if current_node.flag == true
    #   words += 1
    # end
    if current_node.char_map.empty? != true
      current_node = current_node.char_map
      current_node.keys.each do |char|
        current_node = current_node[char]
        if current_node.flag == true
          count(current_node, words += 1)
        else
          count(current_node)
        end
      end
    end
    # if current_node.flag == true
    #   words += 1
    # end
    return words
  end


end

trie_one = Trie.new
trie_one.insert("hell")
trie_one.insert("hello")
p trie_one.count
