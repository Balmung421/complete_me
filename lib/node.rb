class Node

  attr_reader :value,
              :flag,
              :map,
              :used

  def initialize (value = "")
    @value = value
    @flag = false #indicates if a node ends a word
    @map = {} #stores links
    @used = 0
  end

  def word?
    @flag == true
  end



end
