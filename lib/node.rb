require 'pry'
class Node

  attr_reader   :char_map,:char_map_depth,:flag,:preference

  #char_map is the trie
  #char_map_depth is how far in the trie you are
  #flag is whether we are at the end of a trie or not
  #preference is used for weighting/doing suggestions

  def initialize(char_map_depth=0)
    @char_map       = {}
    @flag           = false
    @char_map_depth = char_map_depth
    @preference     = {}
  end

  def insert(word)
    letter = word[@char_map_depth]
    if letter == nil
      @flag = true
    else
      if @char_map[letter] == nil
        @char_map[letter] = Node.new(@char_map_depth + 1)
      end
      node = @char_map[letter]
      node.insert(word)
    end
  end

  def build_flags_list(suggestion="", list_of_words={})
    if @flag == true
      list_of_words[suggestion] = @preference
    end
    @char_map.each do | letter, child_node |
      list_of_words = child_node.build_flags_list(suggestion + letter, list_of_words)
    end
    return list_of_words
  end

  def get_node(suggestion)
    letter = suggestion[@char_map_depth]
    if letter == nil
      return self
    elsif @char_map[letter] == nil
      return nil
    else
      child_node = @char_map[letter]
      child_node.get_node(suggestion)
    end
  end

  def weight(suggestion)
    if @preference[suggestion].nil?
      @preference[suggestion] = 1
    else
      @preference[suggestion] += 1
    end
  end

  def get_parent_and_child(word)
    parent_node = get_node(word[0..-2])
    letter = word[-1]
    node = parent_node.char_map[letter]
    return parent_node, node
  end

  def remove_link(letter)
    @char_map.delete(letter)
  end

  def remove_word
    @flag = false
  end
end
