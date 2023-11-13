# ___________________________________________________________________________________________________
# to_proc method

p ['a', 'b', 'c'].map{|e| e.upcase} # => ["A", "B", "C"]
p ['a', 'b', 'c'].map(&:upcase) # => ["A", "B", "C"]

# what happens underneath -> & transfers :upcase method to Proc and it beconmes a {|x| x.upcase} block
# Ex:
class Symbol
  def to_proc
    ->(obj, args=nil) { obj.send(self, *args) }
  end
end

# Steps:

p ['a', 'b', 'c'].map{|e| e.upcase} # => ["A", "B", "C"]
p ['a', 'b', 'c'].map(&:upcase) # => ["A", "B", "C"]
p ['a', 'b', 'c'].map(&:upcase.to_proc) # => ["A", "B", "C"]
p ['a', 'b', 'c'].map(&->(obj, args=nil) { obj.send(:upcase, *args) }) # => ["A", "B", "C"]

# ___________________________________________________________________________________________________
# to_proc method implementation

class SquareFormula
  def self.to_proc
    ->(obj) { obj * obj }
    # or Proc.new {|obj| obj * obj }
  end
end

class ToStringFormula
  def self.to_proc
    proc { |obj| obj.to_s }
    # or lambda { |obj| obj.to_s }
  end
end

p [1,2,3,4,5].map(&SquareFormula) # => [1, 4, 9, 16, 25]
p [1,2,3,4,5].map(&ToStringFormula) # => ["1", "2", "3", "4", "5"]

# ___________________________________________________________________________________________________