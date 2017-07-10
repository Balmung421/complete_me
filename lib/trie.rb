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

  def build_flags_list(current_node = @root, flags = [])
    flags << current_node.flag
    if current_node.char_map.empty? == false
      current_node.char_map.keys.each do |char|
        build_flags_list(current_node.char_map[char], flags)
      end
    end
    return flags
  end

  def count(flags_list)
    count = 0
    flags_list.each do |flag|
      if flag == true
        count += 1
      end
    end
    return count
  end

  # def count_nodes(current_node = @root, words = 0)
  #   # if current_node.flag == true
  #   #   words += 1
  #   # end
  #   if current_node.char_map.empty? != true
  #     current_node = current_node.char_map
  #     current_node.keys.each do |char|
  #       current_node = current_node[char]
  #       if current_node.flag == true
  #         words += 1
  #          # I think this isn't working because words is a block variable here.
  #       end
  #       count_nodes(current_node)
  #     end
  #   end
  #   return words
  # end

  def populate(file)
    dictionary = File.read(file)
    dictionary = dictionary.split("\n")
    dictionary.each do |word|
      insert(word)
    end
  end


end

trie_one = Trie.new
# trie_one.insert("he")
# trie_one.insert("hell")
# trie_one.insert("hello")
# trie_one.insert("bat")
# trie_one.insert("batty")
# trie_one.insert("battycathy")
# p trie_one
trie_one.populate("/usr/share/dict/words")
x = trie_one.build_flags_list
p trie_one.count(x)
