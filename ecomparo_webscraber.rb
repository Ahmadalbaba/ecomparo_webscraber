require 'nokogiri'
require "open-uri"
require 'csv'

url = 'https://www.ecomparo.de/webdesign-internet-agenturen-fuer-onlineshop-finden/'
data = Nokogiri::HTML(open(url).read)
info_keys = ["Nummer", "Shopsystem" , "Agentur" , "Land" , "PLZ" , "Stadt" , "Referenz", "Branche", "Durchgeführte Arbeit"]
agenturen_info_array=[]
infos_array =[]
i = 0
while i<774
	infos_hash = {}
agentur_info = data.xpath("//tr[@id='tbl_0_row_#{i}']/td")
 
agentur_info = agentur_info.to_a
agentur_info_array = []
agentur_info.each do |info|
	infos_hash = {}
	info = info.text
	#puts info
	agentur_info_array << info
	end

	page     =  data.xpath("//tr[@id='tbl_0_row_#{i}']/td")
agenturen = page.search('a').map{ |tag|
	case tag.name.downcase
	when 'a'
		tag['href']
	end
}
agentur_linken = []
agenturen.each do |link|
	link = link.to_s
	agentur_linken  << link
end
agentur_info_array.each do |info|
	agentur_linken.each do |link|
agentur_info_array[2] = agentur_linken[0]
agentur_info_array[6] = agentur_linken[1]

end 

end 
i=i+1

infos_hash["Shopsystem"] = agentur_info_array[1]
infos_hash["Agentur"] = agentur_info_array[2]
infos_hash["Land"] = agentur_info_array[3]
infos_hash["PLZ"] = agentur_info_array[4]
infos_hash["Stadt"] = agentur_info_array[5]
infos_hash["Referenz"] = agentur_info_array[6]
infos_hash["Branche"] = agentur_info_array[7]
infos_hash["Durchgeführte Arbeit"] = agentur_info_array[8]
infos_array << infos_hash
end


puts infos_array.class




 

CSV.open("informationen.csv", "w") do |csv|
	infos_array.each do |h|
		str = []
		h.each do |key , value|
			str << value
		end
		csv << str	
  end
end

