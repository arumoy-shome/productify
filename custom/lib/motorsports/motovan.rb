require 'net/ftp'

Net::FTP.open('motovan.com', username: 'seotwist', password: 'M8gY64V4') do |ftp|
  ftp.login

  puts ftp.list

  ftp.close
end
