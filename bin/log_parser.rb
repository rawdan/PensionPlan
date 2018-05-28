class LogParser

  def parse(log: '')
    return false unless log.is_a? String
    return false if log.empty?
  end
end