gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/trie.rb'

require 'pry'

class NodeTest < Minitest::Test

  def test_that_trie_exists
    trie_one = Trie.new
    assert_instance_of Trie, trie_one
  end

  def test_that_count_returns_number_of_words_in_trie
    trie_one = Trie.new
    trie_one.insert("hell")
    trie_one.insert("hello")
    assert_equal 2, trie_one.count
  end
  
end
