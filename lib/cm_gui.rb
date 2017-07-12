Shoes.setup do
  # require './complete_me'
  require './lib/trie'
  require './lib/node'
  # # require '.test/'
end
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

    end

    @push_all.click do

    end
  end

  dictionary = File.read('/usr/share/dict/words')
  trie = CompleteMe.new
  trie.populate(dictionary)
end
# Shoes.setup do
#   # require './complete_me'
#   require './lib/trie'
#   require './lib/node'
#   # # require '.test/'
# end
#
# auto_complete = CompleteMe.new
#
# dictionary = File.read('/usr/share/dict/words')
#
# auto_complete.populate(dictionary)
#
# Shoes.app do
#   @text  = title "Auto-complete"
#   stack do
#     edit_box do |e|
#       if e.text == ""
#         @counter.text = para ""
#       elsif auto_complete.suggest(e.text).empty?
#         @counter.text = para ""
#       else
#         @counter.text = auto_complete.suggest(e.text).first(20).join("\n")
#       end
#     end
#   end
#   @counter = para ""
# end
