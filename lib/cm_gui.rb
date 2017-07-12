# Shoes.setup do
#  # require './complete_me'
# #   require './lib/trie'
# #   require './lib/node'
# #   # # require '.test/'
# end
#
Shoes.app(width:500, height: 500) do

  background "#ffffff"
  stack(margin: 12) do
    title "Zach and Aaron's CompleteMe"

    para "Enter something to see autocorrects:"

    flow do
      @input = edit_line width: 100
      @push_start = button "search (starts with)"
      @push_all = button "search (includes)"
    end

    @z = para 'no suggestions yet...'

    @push_start.click do
      suggestions = trie.suggest(@input.text)
      @z.replace suggestions.join("\n")
      # @z.replace image "http://spiralofhope.com/i/ruby-shoes--nks-kidnap.png"
    end

    @push_all.click do

    end

  end
  require './complete_me'
  dictionary = File.read('/usr/share/dict/words')
  trie = CompleteMe.new
  trie.populate(dictionary)
end
