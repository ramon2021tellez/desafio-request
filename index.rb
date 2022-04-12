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
# descargamos la informacion en la variable data
data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=UUwWiOoisWanWwJR7hLGZINRsSk46Lv0bU86KS60")

#seleccionamos las fotos en la variable picture
picture = data['photos']
html = ""


    html += "<html>\n"
    html += "<head>\n"
    html += "</head>\n"
    html += "<body>\n"
    #cuenta la cantidad de fotos la variable photos_count
    photos_count = picture.size
    html += "<p> Cantidad de fotos :#{photos_count}</p>\n "
    html += "</ul>\n"  
    #recorremos el hash mostrando las imagenes 
    picture.each do |photo|
        html += "<li><img src = '#{photo['img_src']}' width='300' height= '300' class='img-fluid rounded'><li>\n"
        html += "<p> '#{photo['camera.full_name']}'</p>\n "
    end  
    html += "</ul>\n"   
    html += "</body>\n"
    html += "</html>\n"
   
   #generamos en index con la estructura html 
   
    File.write('index.html', html)

