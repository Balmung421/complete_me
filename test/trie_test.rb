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


end
