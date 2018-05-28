class LogParser

  def parse(log: '')
    return false unless log.is_a? String
    return false if log.empty?
    data = log.match(/(?<web_page>.*)\s(?<user_ip>\d{3}\.\d{3}\.\d{3}\.\d{3})/)
    {
        page: data[:web_page],
        user: data[:user_ip]
    }
  end
end