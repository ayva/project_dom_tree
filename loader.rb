class Loader

  def initialize(file = 'test.html')

    @file = File.open(file, "r")

  end

  def load

    @file.readlines.map! {|word| word.strip}
   
  end

end


