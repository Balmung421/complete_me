#Psudeocode
#Let's build off the nodes from the last project!
#Create and initialize a Node class
#What attributes?
### links aka the letters in the word
### depth aka how long is the word, and how deep we are in the trie
### we need to know when we are the end! end_of_word?
### can we use something like weights? to determine the suggestion for auto correct?
# lets test the ability to insert a word, like before (append)
require 'pry'
class Node

  attr_reader   :links, :depth, :end_of_word

  def initialize(depth=0)
    @links = {}
    @end_of_word = false
    @depth = depth

  end

  def insert(word)
    letter = word[@depth]
    if letter == nil
      @end_of_word = true
    else
      if @links[letter] == nil
        @links[letter] = Node.new(@depth+1)
      end
      node = @links[letter]
      node.insert(word)
    end
  end







end
