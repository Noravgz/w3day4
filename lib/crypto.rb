require 'nokogiri'
require 'open-uri'

begin
  # Ouvre la page et parse le contenu
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

  # On cherche les noms et les prix des cryptomonnaies
  noms = page.xpath('//td[2]/div/a[2]/text()')
  prix = page.xpath('//td[5]/div/span/text()')

  # Je crée un hash vide
  crypto_info = {}

  # Vérifie si le nombre de noms et de prix correspond
  if noms.size == prix.size
    # Parcours mes éléments dans le tableau
    noms.each_with_index do |nom, index|
      crypto_info[nom.to_s] = prix[index].to_s  # On crée un hash avec le nom et le prix
    end

    # Affiche ce qu'il y a dans crypto_info
    crypto_info.each do |nom, prix|
      puts "Cryptomonnaie : #{nom}, Prix : #{prix}"
    end
  else
    puts "Le nombre de cryptomonnaies et de prix ne correspond pas."
  end

  # Affiche le hash complet
  puts crypto_info

rescue OpenURI::HTTPError => e
  puts "Erreur lors de l'ouverture de l'URL : #{e.message}" # Si on ne peut pas ouvrir la page
rescue Errno::ENOENT => e
  puts "Erreur de fichier : #{e.message}" # Pour capturer une autre erreur de fichier
end

