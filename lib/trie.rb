require_relative 'node'

require 'pry'

class Trie

  attr_accessor :root

  def initialize
    @root = Node.new
  end

  def insert(word)
    current_node = @root
    binding.pry
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
          count(current_node, words = (words + 1)) # I think this isn't working because words is a block variable here.
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

  def populate(file)
    dictionary = File.read(file)
    dictionary = dictionary.split("\n")
    dictionary.each do |word|
      insert(word)
    end
  end


end

trie_one = Trie.new
p trie_one.count
trie_one.populate("/usr/share/dict/words")
p trie_one.count
