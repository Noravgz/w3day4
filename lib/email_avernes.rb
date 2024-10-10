require 'nokogiri'
require 'open-uri'

begin
# Ouvre la page et parse le contenu
  page = Nokogiri::HTML(URI.open("https://lannuaire.service-public.fr/navigation/ile-de-france/val-d-oise/mairie"))

  

  #méthode pour définir mon email
 def get_townhall_email(townhall_url) 


    # Ouvre la page de la mairie
 page = Nokogiri::HTML(URI.open(townhall_url))


# Cherche l'élément qui contient l'e-mail
email = page.xpath('//*[@id="contentContactEmail"]/span[2]/a/text()') # Code pour récupérer l'e-mail
return email # Retourne l'e-mail trouvé
end


 # Définit l'URL de la mairie
  url = "https://lannuaire.service-public.fr/ile-de-france/val-d-oise/c23327b7-7798-43a7-9316-569727c7e278"


  # Appelle la méthode et récupère l'e-mail
  email = get_townhall_email(url)

    
  # Affiche l'email 
    if email
    puts "L'email de la Mairie est : #{email}"
  else
    puts "Je n'ai pas trouvé d'email."
  end


rescue OpenURI::HTTPError => e
  puts "Erreur lors de l'ouverture de l'URL : #{e.message}" # Si on ne peut pas ouvrir la page
rescue Errno::ENOENT => e
  puts "Erreur de fichier : #{e.message}" # Pour capturer une autre erreur de fichier
end

