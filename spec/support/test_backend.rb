class TestBackend
  attr_accessor :data

  def initialize(data = {})
    @data = data
  end

  def files
    @data.keys
  end

  def extract(path)
    if @data[path]
      File.open(path, 'w') { |f| f.write(@data[path]) }
    end
  end
end
