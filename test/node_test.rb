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

  def test_that_node_initializes_with_empty_value
    node = Node.new
    assert_equal '', node.value
  end

  def test_that_node_initializes_with_chosen_value
    node = Node.new('a')
    assert_equal 'a', node.value
    node2 = Node.new('b')
    assert_equal 'b', node2.value
  end

  def test_that_node_flag_is_false_by_default
    node = Node.new
    refute node.flag
  end


end
