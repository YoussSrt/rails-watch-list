require 'open-uri'
require 'json'

# L'URL de l'API TMDB pour récupérer les films
url = "https://tmdb.lewagon.com/movie/top_rated"

# Effectuer une requête HTTP pour récupérer les données des films
response = URI.open(url).read
movies_data = JSON.parse(response)["results"]

# L'URL de base pour les posters d'images
base_url = "https://image.tmdb.org/t/p/original"

# Créer les films dans la base de données
movies_data.each do |movie|
  url = base_url + movie["poster_path"]
  Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: url,
    rating: movie["vote_average"]
  )
end

puts Movie.last.poster_url
