Shoes.setup do
    require './complete_me'
end

Shoes.app(width:750, height: 600) do

  background "#ffffff"
  stack(margin: 12) do
  title "Zach and Aaron's CompleteMe"

  para "Enter something to see autocorrects:"

  flow do
    @input = edit_line width: 100
    @push_start = button "search!"
  end

  @temp = para 'no suggestions yet...'

  @push_start.click {
    # trie.insert(@input.text)
    # list_of_words = trie.suggest(@input.text).sort
    # @temp.replace list_of_words

    @temp.replace @input.text
  }

  end

  dictionary = File.read('/usr/share/dict/words')
  trie = CompleteMe.new
  trie.populate(dictionary)

end
