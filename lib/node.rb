class Node

  attr_accessor :flag,
                :char_map,
                :preference

  def initialize
    @flag = false #indicates if a node ends a word
    @char_map = {} #stores links
    @preference = {} #stores preference given to certain letters based on select history
  end





end
