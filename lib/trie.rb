require './lib/node'
require 'pry'

class CompleteMe

  attr_reader :head

  def initialize
    @head = Node.new
  end

  def insert(word)
    @head.insert(word)
  end

  def count
   @head.build_flags_list.length
  end

  def suggest(suggestion)
    traverse_node = @head.get_node(suggestion)
    words = traverse_node.build_flags_list(suggestion)
    weighted_list = identify_preferences(words, suggestion)
    return weighted_list
  end

  def populate(dictionary)
    words = dictionary.split("\n").sort
    words.each do |word|
      word.gsub!(/\r/, '')
      insert(word)
    end
  end

  def select(suggestion, weighted_word)
    node = @head.get_node(weighted_word)
    node.weight(suggestion)
  end

  def delete(existing_word)
    node = @head.get_node(existing_word)
    node.remove_word
    disconnect_nodes(existing_word)
  end

  def identify_preferences(words, suggestion)
    words = get_weight_for_each_word(words, suggestion)
    words = group_words_by_weight(words)
    words = build_flags_list_by_weight(words)
    words = get_sorted_list(words)
    return words
  end

  def disconnect_nodes(word)
    parent_node, node = @head.get_parent_and_child(word)
    if node.char_map.empty?
      parent_node.remove_link(word[-1])
      if parent_node.flag == false
        disconnect_nodes(word[0..-2])
      end
    end
  end

  def get_weight_for_each_word(words, suggestion)
    words.each do | key, value|
      words[key] = value[suggestion].to_i
    end
    return words
  end

  def group_words_by_weight(words)
    words = words.group_by do | key, value |
      value
    end
    return words
  end

  def build_flags_list_by_weight(words)
    words.each do | key, value |
      words_array = value.flatten
      words_array = words_array.find_all { | e | e.class == String }
      words[key] = words_array.sort!
    end
    return words
  end

  def get_sorted_list(words)
    sorted_list = []
    words.keys.sort.reverse.each {|key| sorted_list.concat(words[key])}
    return sorted_list
  end

end
