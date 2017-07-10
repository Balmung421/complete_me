require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test
  def test_if_correct_file_setup
    assert true
  end

  def test_if_complete_me_exists
    trie = CompleteMe.new
    assert trie
  end

  def test_if_head_exists
    trie = CompleteMe.new
    assert trie.head
  end

  def test_insert_single_letter
    trie = CompleteMe.new
    trie.insert("z")
    assert_equal ["z"], trie.head.links.keys
    assert_equal 1, trie.head.links["z"].depth
  end

  def test_insert_short_word
    trie = CompleteMe.new
    trie.insert("cat")
    assert_equal ["c"], trie.head.links.keys
    assert_equal 1, trie.head.links["c"].depth
    assert_equal false, trie.head.links["c"].end_of_word
    assert_equal false, trie.head.links["c"].links["a"].end_of_word
    assert_equal true,  trie.head.links["c"].links["a"].links["t"].end_of_word
  end

  def test_count_works
    skip
    trie = CompleteMe.new
    trie.insert("pizza")
    assert_equal 1, trie.count
  end


end
