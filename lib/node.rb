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

head = Node.new #we just call it head cause it is the start of a fresh node/linkedlist/trie
head.insert("cat") #using our insert method to populate the nodes
head.insert("car")
suggestion = "ca" #specifiying the suggestion letters between our examples above
x = head.get_node(suggestion) #create a vairable x use our get_node method, calling our suggestion above as an argument
p words = x.build_flags_list(suggestion).sort #put words using our build_flags_list method and suggestion above as agrument to create an array of our inserts. .sort will by sorting self aka sorting the array just we made alphabetically
p x.build_flags_list #visually seeing what our build flags list method is doing
p x.build_flags_list.sort #here, the t is from cat, and the r is from car, because our @flag is being turned to true, because we are at the end of a word!
p x.build_flags_list(suggestion) #what is doing with suggestion argument
p x.build_flags_list(suggestion).sort
p head
