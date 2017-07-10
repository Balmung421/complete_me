task :default do
    FileList["./test/node_test.rb", "./test/complete_me_test.rb"].each { |file| ruby file } #do/end on one line!!!
    #just type rake in your directory where your rakefile.rb is
end
