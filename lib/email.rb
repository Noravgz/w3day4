require 'nokogiri'
require 'open-uri'

begin
# Ouvre la page et parse le contenu
  page = Nokogiri::HTML(URI.open("https://lannuaire.service-public.fr/navigation/ile-de-france/val-d-oise/mairie"))

  # Récupère les URLs des mairies
  townhall_urls = page.xpath('//p/a/@href').map { |url| URI.join("https://lannuaire.service-public.fr", url.to_s) }


  #méthode pour définir mon email
 def get_townhall_email(townhall_url) 
 # Ouvre la page de la mairie
 page = Nokogiri::HTML(URI.open(townhall_url))


# Cherche l'élément qui contient l'e-mail
email = page.xpath('//*[@id="contentContactEmail"]/span[2]/a/text()') # Code pour récupérer l'e-mail
email = email.text.strip if email.any?
return email # Retourne l'e-mail trouvé
end


townhall_urls = get_townhall_urls
# On va voir chaque mairie pour chercher l'email
townhall_urls.each do |url|
email = get_townhall_email(url) # On utilise la petite boîte magique

    
  # Affiche l'email 
    if email && !email.empty?
    puts "L'email de la Mairie est : #{email}"
  else
    puts "Je n'ai pas trouvé d'email: #{url}"
  end
end

rescue OpenURI::HTTPError => e
  puts "Erreur lors de l'ouverture de l'URL : #{e.message}" # Si on ne peut pas ouvrir la page
rescue Errno::ENOENT => e
  puts "Erreur de fichier : #{e.message}" # Pour capturer une autre erreur de fichier
end



