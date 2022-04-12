require "uri"
require "net/http"
require "json"

def request(url)
    url = URI(url)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    results = JSON.parse(response.read_body)
end
# limitamos la respuesta a 10 registros
data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=UUwWiOoisWanWwJR7hLGZINRsSk46Lv0bU86KS60")
# recorremos la respuesta y obetnemos las "thumbnailUrl"
#photos = data.map do |photo|
#    photo["img_src"]
#end

html = ""
data.each do |photo|
    html += "<html>\n"
    html += "<img src='#{photo}'>\n"
    html += "<img src='https://mars.nasa.gov/msl-raw-images/msss/01000/mcam/398381687EDR_F0030000CCAM05010M_.JPG'>\n" 
end

File.write('index.html', html)

#puts buid_web_page("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=UUwWiOoisWanWwJR7hLGZINRsSk46Lv0bU86KS60")[0..9]
