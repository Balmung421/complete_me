task :default do
    FileList["./test/node_test.rb", "./test/complete_me_test.rb", "./test/complete_me_spec_harness.rb", "./test/spec_flow_test.rb"].each { |file| ruby file } 
end
