require 'simplecov'
SimpleCov.start
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test

  def test_file_setup_correctly
    assert true
  end

  def test_node_exists
    node = Node.new
    assert node
  end

  def empty_hash
      Hash.new
  end

  def test_node_defaults
    head = Node.new
    assert_equal empty_hash, head.links #empty has method above
    assert_equal false, head.end_of_word
    assert_equal 0, head.depth
  end

  def test_insert_single_letter
    head = Node.new
    head.insert("z")
    assert_equal ["z"], head.links.keys
    assert_equal 1, head.links["z"].depth
    assert_equal true, head.links["z"].end_of_word
  end

  def test_insert_short_word
    head = Node.new
    head.insert("cat")
    assert_equal ["c"], head.links.keys
    assert_equal 1, head.links["c"].depth
    assert_equal false, head.links["c"].end_of_word
    assert_equal false, head.links["c"].links["a"].end_of_word
    assert_equal true,  head.links["c"].links["a"].links["t"].end_of_word
    assert_equal 3, head.links["c"].links["a"].links["t"].depth
  end

  def test_insert_short_words_overlap
    head = Node.new
    head.insert("cat")
    head.insert("car")
    assert_equal ["c"], head.links.keys
    assert_equal 1, head.links["c"].depth
    assert_equal false, head.links["c"].end_of_word
    assert_equal false, head.links["c"].links["a"].end_of_word
    assert_equal true,  head.links["c"].links["a"].links["t"].end_of_word
    assert_equal 3, head.links["c"].links["a"].links["t"].depth
    assert_equal true,  head.links["c"].links["a"].links["r"].end_of_word
    assert_equal 3, head.links["c"].links["a"].links["r"].depth
  end



end
