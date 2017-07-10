gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node.rb'

require 'pry'

class NodeTest < Minitest::Test

  def test_that_node_exists
    node = Node.new
    assert_instance_of Node, node
  end

  def test_that_node_flag_is_false_by_default
    node = Node.new
    refute node.flag
  end

  def test_that_node_map_is_empty_by_default
    node = Node.new
    assert_equal ({}), node.map
  end

  def test_that_node_preference_is_empty_by_default
    node = Node.new
    assert_equal ({}), node.preference
  end


end
