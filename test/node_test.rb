require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test

  def empty_hash
    Hash.new
  end

  def test_if_file_correctly_setup
    assert true
  end

  def test_if_node_exists
    node = Node.new
    assert node
  end

  def test_node_defaults_are_expected
    head = Node.new
    assert_equal empty_hash,  head.char_map
    assert_equal false,       head.flag
    assert_equal 0,           head.char_map_depth
    assert_equal empty_hash,  head.preference
  end

  def test_insert_single_letter
    head = Node.new
    head.insert("a")
    assert_equal ["a"], head.char_map.keys
    assert_equal 1,     head.char_map["a"].char_map_depth
    assert_equal true,  head.char_map["a"].flag
  end

  def test_insert_short_word
    head = Node.new
    head.insert("cat")
    assert_equal ["c"], head.char_map.keys
    assert_equal 1,     head.char_map["c"].char_map_depth
    assert_equal false, head.char_map["c"].flag
    assert_equal false, head.char_map["c"].char_map["a"].flag
    assert_equal true,  head.char_map["c"].char_map["a"].char_map["t"].flag
  end

  def test_insert_short_words_overlap
    head = Node.new
    head.insert("cat")
    head.insert("car")
    assert_equal ["c"], head.char_map.keys
    assert_equal 1,     head.char_map["c"].char_map_depth
    assert_equal false, head.char_map["c"].flag
    assert_equal false, head.char_map["c"].char_map["a"].flag
    assert_equal true,  head.char_map["c"].char_map["a"].char_map["t"].flag
    assert_equal true,  head.char_map["c"].char_map["a"].char_map["r"].flag
  end

  def test_if_get_node_empty_string
    head = Node.new
    head.insert("cat")
    node = head.get_node("")
    assert_equal head, node
  end

  def test_if_get_node_no_char_map
    head = Node.new
    head.insert("a")
    node = head.get_node("at")
    assert_nil node
  end

  def test_if_get_node_short_string
    head = Node.new
    head.insert("cat")
    node = head.get_node("ca")
    assert_equal 2,     node.char_map_depth
    assert_equal ["t"], node.char_map.keys
  end

  def test_build_flags_list_short_list
    head = Node.new
    head.insert("cat")
    head.insert("car")
    suggestion = "ca"
    search_node = head.get_node(suggestion)
    words = search_node.build_flags_list(suggestion).sort
    assert_equal [["car",empty_hash],["cat",empty_hash]], words
  end

  def test_weight_no_existing_preference
    head = Node.new
    head.insert("cat")
    head.insert("car")
    cat = head.get_node("cat")
    car = head.get_node("car")
    assert_equal 0, cat.preference.length
    assert_equal 0, car.preference.length
    cat.weight("ca")
    assert_equal 1, cat.preference["ca"]
    assert_equal 0, car.preference.length
  end

  def test_weight_and_existing_weight
    head = Node.new
    head.insert("cat")
    cat = head.get_node("cat")
    assert_equal 0, cat.preference.length
    cat.weight("ca")
    cat.weight("ca")
    assert_equal 2, cat.preference["ca"]
  end

  def test_if_can_get_parent_and_child_node
    head = Node.new
    head.insert("cat")
    head.insert("car")
    parent_node, child_node = head.get_parent_and_child("car")
    assert_equal head.char_map["c"].char_map["a"],            parent_node
    assert_equal head.char_map["c"].char_map["a"].char_map["r"], child_node
  end

  def test_if_can_remove_word
    head = Node.new
    head.insert("car")
    node = head.char_map["c"].char_map["a"].char_map["r"]
    node.remove_word
    assert_equal false, node.flag
  end

  def test_if_can_remove_link
    head = Node.new
    head.insert("car")
    node = head.char_map["c"].char_map["a"]
    node.remove_link("r")
    assert_equal 0, node.char_map.length
  end

end
