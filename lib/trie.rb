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

  def count(flags_list = build_flags_list)
    count = 0
    flags_list.each do |flag|
      if flag == true
        count += 1
      end
    end
    return count
  end

  def populate(file)
    dictionary = File.read(file)
    dictionary = dictionary.split("\n")
    dictionary.each do |word|
      insert(word)
    end
  end

  def find_root_node_for_suffix(word, current_node = @root)
    word.each_char do |char|
      if current_node.char_map.has_key?(char) == false
        return nil
      else
        current_node = current_node.char_map[char]
      end
    end
    return current_node
  end

  def suggest(word, current_node = @root)
    suggestions = []
    current_node = find_root_node_for_suffix(word, current_node)
    collect_words_from_given_node(word, current_node, suggestions)
    return suggestions
  end

  def collect_words_from_given_node(word, current_node, suggestions)
    if current_node.flag
      suggestions << word
    end
    if current_node.char_map.empty? == false
      current_node.char_map.keys.each do |char|
        temp_word = word
        temp_word = temp_word + char
        collect_words_from_given_node(temp_word, current_node.char_map[char], suggestions)
      end
    end
    return suggestions
  end

  def select(prefix, chosen_word, current_node = @root)
    current_node = find_root_node_for_suffix(prefix, current_node)
    suggestions = suggest(prefix)
    suggestions.each do |word|
      if word == chosen_word
        current_node.preference << word
      end
    end
  end

  def check_preference_for_given_prefix(prefix, current_node = @root)
    current_node = find_root_node_for_suffix(prefix, current_node)
    current_node.preference # need to finish this so we can count the number of times a word shows up in preference
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
p trie_one.suggest('piz')
p trie_one.select('piz', 'pizza')
p trie_one.select('piz', 'pizza')
p trie_one.select('piz', 'pizzeria')
p trie_one.select('piz', 'pizzle')
p trie_one.check_preference_for_given_prefix('piz')
