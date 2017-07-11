

Shoes.setup do
  # require './complete_me'
  require './lib/trie'
  require './lib/node'
  # # require '.test/'
end
#
Shoes.app(width:500, height: 500) do

  background "#ffffff"
  # image "http://spiralofhope.com/i/ruby-shoes--nks-kidnap.png"
  stack(margin: 12) do
    title "Zach and Aaron's CompleteMe"

    para "Enter something to see autocorrects:"
    #trie = CompleteMe.new
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
      # suggestion = trie.suggest(@input.text)
      # @z.replace suggestion.join("\n")
      # # @z.replace image "http://spiralofhope.com/i/ruby-shoes--nks-kidnap.png"
      # # @z.replace @suggestion.join("\n")
    end

    # @push_all.click do
    #   @preference = trie.suggest(@z.text)
    #   @z.replace @preference.join("\n")
    # end
  end

  dictionary = File.read('/usr/share/dict/words')
  trie = CompleteMe.new
  trie.populate(dictionary)
end

# Shoes.app :title => "Dictionary, powered by Definr", :width => 370, :height => 320 do
#   stack do
#     background red, :height => 60
#     flow :margin => 20 do
#       caption "Define: ", :stroke => white
#       @lookup = edit_line
#       button "Go" do
#         download "http://definr.com/definr/show/#{@lookup.text}" do |dl|
#           doc = dl.response.body.gsub('&nbsp;', ' ').
#               gsub(%r!(</a>|<br />|<a href.+?>)!, '').
#               gsub(%r!\(http://.+?\)!, '').strip
#           title, doc = doc.split(/\n+/, 2)
#           @deft.replace title
#           @defn.replace doc
#         end
#       end
#     end
#     stack :margin => 20 do
#       @deft = subtitle "", :margin => 10
#       @defn = para ""
#     end
#   end
# end
