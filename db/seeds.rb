# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#if not Rails.env.production?
@p = Poll.create(:title=>"test poll", :phone=>'1'+rand(10 ** 10).to_s, :start_date=>Time.now, :end_date=>Time.now + 1.week)
@q = @p.questions.create(:text=>"yes or no?", :question_type=>"YN")
@q.options.create(:text=>"yes", :value=>"yes")
@q.options.create(:text=>"no", :value=>"no")
53.times { 
  @resp = @q.responses.create(:from => '1'+rand(10 ** 10).to_s, :to => @p.phone, :response => ['y','n'].sample) 
  @resp.created_at = (rand*7).days.ago
  @resp.save
}

@p2 = Poll.create(:title=>"test poll", :phone=>'1'+rand(10 ** 10).to_s, :start_date=>Time.now, :end_date=>Time.now + 1.week)
@p2q = @p2.questions.create(:text=>"yes or no?", :question_type=>"YN")
@p2qy = @p2q.options.create(:text=>"yes", :value=>"yes")
@p2qyFup = @p2qy.follow_up.create( :text=>"why", :question_type=>"OPEN")
@p2q.options.create(:text=>"no", :value=>"no")
@p2q2 = @p2.questions.create(:text=>"where?", :question_type=>"OPEN")
puts "creating responses for p2"
10.times {
  @from = '1'+rand(10 ** 10).to_s
  @r = @p2q.responses.create(:from => @from, :to => @p2.phone, :response => 'yes')
  @rf = @p2qyFup.responses.create(:from => @from, :to => @p2.phone, :response => 'because')
  @r2 = @p2q2.responses.create(:from => @from, :to => @p2.phone, :response => 'wherever')
}
5.times {
  @from = '1'+rand(10 ** 10).to_s
  @r = @p2q.responses.create(:from => @from, :to => @p2.phone, :response => 'no')
  @r2 = @p2q2.responses.create(:from => @from, :to => @p2.phone, :response => 'everywhere')
}  

puts "creating p3"
@op = FactoryGirl.create(:poll_open)
@responses = ['Acme or Supreme', 'I buy groceries in Paris', 'I love Wal-mart', 'Walgreens at noon', 'CVS', 'Stater bros']
25.times {
  @resp = @op.questions.first.responses.create(:from => '1'+rand(10 ** 10).to_s, :to => @op.phone, :response => @responses.sample) 
  @resp.created_at = (rand*7).days.ago
  @resp.save
}




#first create one with a valid tropo phone number for later testing
#@polls = []
##3.times { @polls << FactoryGirl.create(:poll)}
#
#
#@polls.each do |p|
#  53.times { 
#    @resp = p.responses.create(:from => '1'+rand(10 ** 10).to_s, :to => p.phone, :response => @responses.sample) 
#    @resp.created_at = (rand*7).days.ago
#    @resp.save
#  }
#end
#
#@poll_multi = FactoryGirl.create(:poll_multi)
#60.times { 
#  @resp = @poll_multi.responses.create(:from => '1'+rand(10 ** 10).to_s, :to => @poll_multi.phone, :response => @choices.sample)
#  @resp.created_at = (rand*7).days.ago
#  @resp.save
#}
#
#begin
#  FactoryGirl.create(:poll_valid_phone)
#rescue
#  puts "Valid phone number poll already created #{$!}"
#end
#
# Response.craete()
#   factory :poll do
#     start_date { Time.now }
#     end_date { Time.now + 1.week }
#     phone { '9091234567' }
#     text { 'Where do you buy your groceries?' }
#     title { 'Groceries' }
#     
#     factory :poll_multi do
#       choices {{ "a" => "Wal-mart", "b" => "Bi-rite", "c" => "Bodega"}}
#       poll_type { 'MULTI' }
#     end
#     
#     factory :poll_open do
#       poll_type { 'OPEN' }
#     end

#     factory :poll_ended do
#       start_date { Time.now - 1.week }
#       end_date { Time.now - 3.days }
#     end
#   end
# end

