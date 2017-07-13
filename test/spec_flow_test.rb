# require 'simplecov'
# SimpleCov.start
#
# require 'minitest/autorun'
# require 'minitest/pride'
# require './lib/complete_me'
#
#
# class CompleteMeFlowTest < Minitest::Test
#
#   puts "simulating tests from our directions page"
#
#   def setup
#     @completion = CompleteMe.new
#     @node = Node.new
#   end
#
#   def test_first_insert_and_count
#     skip
#     @completion.insert("pizza")
#     assert @completion.insert("pizza")
#     assert_equal 1, @completion.count
#   end
#
#   def test_suggest
#     skip
#     @completion.insert("pizza")
#     @completion.suggest("piz")
#     z = assert_equal ["pizza"], @completion.suggest("piz")
#       if z == true
#         return p @completion.suggest("piz")
#       end
#   end
#
#
#   # trie = CompleteMe.new
#   # trie.insert("cat")
#   # trie.insert("car")
#   # trie.insert("cats")
#   # list_of_words = trie.suggest("ca").sort
#   # assert_equal ["car","cat","cats"], list_of_words
# # completion.suggest("piz")
# # => ["pizza"]
# #
# # dictionary = File.read("/usr/share/dict/words")
# #
# # completion.populate(dictionary)
# #
# # completion.count
# # => 235886
# #
# # completion.suggest("piz")
# # => ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"]
#
#
# end
