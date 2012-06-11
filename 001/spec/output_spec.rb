require_relative '../lib/output'

describe Output, "#scrabble board" do
  before do
    @answer = Output.new("jeffrey",0,0,10000,90)
    @answer2 = Output.new("Clare", 0, 0, 10230, 180)
    @answer_array = [@answer, @answer2]
  end
 it "prints out a score statement" do
   @answer.to_s.should == "jeffrey at location 0,0 (90) with a score of 10000"
 end
 
 it "checks for zero" do
   @answer.score_zero?.should be_false
 end
 
 it "determines the greater score" do
   @answer_array.sort.should == [@answer2,@answer]
 end
 
end