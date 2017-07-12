require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/trie'

class CompleteMeTest < Minitest::Test

  def empty_hash
    Hash.new
  end

  def test_file_setup_correctly
    assert true
  end

  def test_complete_me_exists
    trie = CompleteMe.new
    assert trie
  end

  def test_head_exists
    trie = CompleteMe.new
    assert trie.head
  end

  def test_insert_single_letter
    trie = CompleteMe.new
    trie.insert("a")
    assert_equal ["a"], trie.head.char_map.keys
    assert_equal 1,     trie.head.char_map["a"].char_map_depth
  end

  def test_insert_short_word
    trie = CompleteMe.new
    trie.insert("bat")
    assert_equal ["b"], trie.head.char_map.keys
    assert_equal 1,     trie.head.char_map["b"].char_map_depth
    assert_equal false, trie.head.char_map["b"].flag
    assert_equal false, trie.head.char_map["b"].char_map["a"].flag
    assert_equal true,  trie.head.char_map["b"].char_map["a"].char_map["t"].flag
  end

  def test_if_insert_short_words_overlap
    trie = CompleteMe.new
    trie.insert("cat")
    trie.insert("car")
    trie.insert("cats")
    assert_equal ["c"], trie.head.char_map.keys
    assert_equal 1,     trie.head.char_map["c"].char_map_depth
    assert_equal false, trie.head.char_map["c"].flag
    assert_equal false, trie.head.char_map["c"].char_map["a"].flag
    assert_equal true,  trie.head.char_map["c"].char_map["a"].char_map["t"].flag
    assert_equal true,  trie.head.char_map["c"].char_map["a"].char_map["r"].flag
    assert_equal true,  trie.head.char_map["c"].char_map["a"].char_map["t"].char_map["s"].flag
  end

  def test_suggest_three_words
    trie = CompleteMe.new
    trie.insert("cat")
    trie.insert("car")
    trie.insert("cats")
    list_of_words = trie.suggest("ca").sort
    assert_equal ["car","cat","cats"], list_of_words
  end

  def test_populate_three_words
    trie = CompleteMe.new
    trie.populate("pizza\ndog\ncat")
    assert_equal 3, trie.count
  end

  def test_populate_entire_dictionary
    trie = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)
    assert_equal 235886, trie.count
  end

  def test_select_once
    trie = CompleteMe.new
    trie.insert("cat")
    trie.insert("car")
    trie.insert("care")
    trie.select("ca","cat")
    equals_hash = {"ca"=>1}
    assert_equal equals_hash, trie.head.char_map["c"].char_map["a"].char_map["t"].preference
  end

  def test_select_twice
    trie = CompleteMe.new
    trie.insert("cat")
    trie.insert("car")
    trie.insert("care")
    trie.select("ca","cat")
    trie.select("ca","cat")
    equals_hash = {"ca"=>2}
    assert_equal equals_hash, trie.head.char_map["c"].char_map["a"].char_map["t"].preference
  end

  def test_identify_preferences_all_equal
    trie = CompleteMe.new
    words = {"cat" => {},"car" => {},"cats" => {},}
    weighted_list = trie.identify_preferences(words,"ca")
    assert_equal ["car","cat","cats"], weighted_list
  end

  def test_identify_preferences_all_different
    trie = CompleteMe.new
    words = { "cat" => {"ca" => 1}, "car" => {"ca" => 2}, "cats" => {"ca" => 3},}
    weighted_list = trie.identify_preferences(words,"ca")
    assert_equal ["cats","car","cat"], weighted_list
  end

  def test_identify_preferences_two_equal
    trie = CompleteMe.new
    words = { "cat" => {},"car" => {"ca" => 1},"cats" => {"ca" => 1},}
    weighted_list = trie.identify_preferences(words,"ca")
    assert_equal ["car","cats","cat"], weighted_list
  end

  def test_delete_no_nodes
    trie = CompleteMe.new
    trie.insert("car")
    trie.insert("card")
    trie.insert("cards")
    card_node = trie.head.char_map["c"].char_map["a"].char_map["r"].char_map["d"]
    trie.delete("card")
    assert_equal false, card_node.flag
    assert_equal ["car","cards"], trie.suggest("ca")
  end

  def test_delete_one_node
    trie = CompleteMe.new
    trie.insert("car")
    trie.insert("card")
    car_node = trie.head.char_map["c"].char_map["a"].char_map["r"]
    trie.delete("card")
    assert_nil  car_node.char_map["d"]
    assert_equal ["car"], trie.suggest("ca")
  end

  def test_delete_two_nodes
    trie = CompleteMe.new
    trie.insert("car")
    trie.insert("cards")
    car_node = trie.head.char_map["c"].char_map["a"].char_map["r"]
    trie.delete("cards")
    assert_nil  car_node.char_map["d"]
    assert_equal ["car"], trie.suggest("ca")
  end

  def test_delete_one_word_wo_remove_sibling_or_cousin
    trie = CompleteMe.new
    trie.insert("car")
    trie.insert("card")
    trie.insert("cart")
    trie.insert("carting")
    trie.insert("carts")
    cart_node = trie.head.char_map["c"].char_map["a"].char_map["r"].char_map["t"]
    trie.delete("carts")
    assert_equal ["i"],                           cart_node.char_map.keys
    assert_equal ["car","card","cart","carting"], trie.suggest("ca")
  end

  def test_delete_two_nodes_wo_remove_sibling_or_cousin
    trie = CompleteMe.new
    trie.insert("car")
    trie.insert("card")
    trie.insert("cart")
    trie.insert("carting")
    trie.insert("carts")
    car_node  = trie.head.char_map["c"].char_map["a"].char_map["r"]
    cart_node = trie.head.char_map["c"].char_map["a"].char_map["r"].char_map["t"]
    trie.delete("carts")
    trie.delete("card")
    assert_equal ["t"],                    car_node.char_map.keys
    assert_equal ["i"],                    cart_node.char_map.keys
    assert_equal ["car","cart","carting"], trie.suggest("ca")
  end

  def small_address_list
    ["542 N Kalamath St Unit 1", "2080 California St Unit 1120", "2080 California St Unit 735", "9428 E 58th Dr", "9414 E 58th Dr", "160 W Bayaud Ave", "2673 S Pearl St", "1113 E 14th Ave Unit 400", "1331 17th St"].join("\n")
  end

  def test_populate_entire_address_list
    trie = CompleteMe.new
    #binding.pry
    trie.populate(large_address_list)
    assert_equal 304559, trie.count
  end

  def test_populate_addresses
    trie = CompleteMe.new
    trie.populate(small_address_list)
    assert_equal ["1", "2", "5", "9"], trie.head.char_map.keys
    assert_equal ["1", "3", "6"], trie.head.char_map["1"].char_map.keys
    assert_equal ["1331 17th St"], trie.suggest("1331")
  end

  def large_address_list
    File.read("./test/denver_addresses.txt")
  end

end
