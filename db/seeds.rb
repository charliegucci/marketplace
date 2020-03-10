# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 3rd-party APIs offering sample images can sometimes return 500 errors.
# If this happens, this method opens the url one more time.
def open_with_retry(url)
  open(url)
rescue OpenURI::HTTPError => e
  puts 'Retrying...'
  sleep(1)
  open_with_retry(url)
end

def sample_avatar_file
  open_with_retry FFaker::Avatar.image
end

def attach_avatar_to_user(user)
  initials = (0...2).map { ('a'..'z').to_a[rand(26)] }.join.upcase
  user.avatar.attach(io: sample_avatar_file, filename: "#{user.name}-#{rand(1000000)}")
end

# Gets file from url
def sample_dog_image_file
  response = Faraday.get "https://dog.ceo/api/breeds/image/random"
  json = JSON.parse(response.body)
  image_url = json["message"]

  open_with_retry(image_url)
end

Buyer::Message.destroy_all
Listing.destroy_all
User.destroy_all
Breed.destroy_all

Breed.create!([
{name:"Affenpinscher"},
{name:"Afghan Hound"},
{name:"Airedale Terrier"},
{name:"Akita"},
{name:"Alaskan Malamute"},
{name:"Standard American Eskimo Dog"},
{name:"Miniature American Eskimo Dog"},
{name:"Toy American Eskimo Dog"},
{name:"American Foxhound"},
{name:"American Staffordshire Terrier"},
{name:"American Water Spaniel"},
{name:"Anatolian Shepherd Dog"},
{name:"Australian Cattle Dog"},
{name:"Australian Shepherd"},
{name:"Australian Terrier"},
{name:"Basenji"},
{name:"Basset Hound"},
{name:"Beagle"},
{name:"Bearded Collie"},
{name:"Beauceron"},
{name:"Bedlington Terrier"},
{name:"Belgian Malinois"},
{name:"Belgian Sheepdog"},
{name:"Belgian Tervuren"},
{name:"Bernese Mountain Dog"},
{name:"Bichon Frise"},
{name:"Black and Tan Coonhound"},
{name:"Black Russian Terrier"},
{name:"Bloodhound"},
{name:"Border Collie"},
{name:"Border Terrier"},
{name:"Borzoi"},
{name:"Boston Terrier"},
{name:"Bouvier des Flandres"},
{name:"Boxer"},
{name:"Briard"},
{name:"Brittany"},
{name:"Brussels Griffon"},
{name:"Bulldog"},
{name:"Bullmastiff"},
{name:"Bull Terrier"},
{name:"Cairn Terrier"},
{name:"Canaan Dog"},
{name:"Cardigan Welsh Corgi"},
{name:"Cavalier King Charles Spaniel"},
{name:"Chesapeake Bay Retriever"},
{name:"Chihuahua"},
{name:"Chinese Crested"},
{name:"Chinese Shar-Pei"},
{name:"Chow Chow"},
{name:"Clumber Spaniel"},
{name:"Cocker Spaniel"},
{name:"Collie"},
{name:"Curly-Coated Retriever"},
{name:"Dachshund"},
{name:"Dalmatian"},
{name:"Dandie Dinmont Terrier"},
{name:"Doberman Pinscher"},
{name:"Dogue de Bordeaux"},
{name:"English Cocker Spaniel"},
{name:"English Foxhound"},
{name:"English Setter"},
{name:"English Springer Spaniel"},
{name:"English Toy Spaniel"},
{name:"Field Spaniel"},
{name:"Finnish Spitz"},
{name:"Flat-Coated Retriever"},
{name:"French Bulldog"},
{name:"German Pinscher"},
{name:"German Shepherd Dog"},
{name:"German Shorthaired Pointer"},
{name:"German Wirehaired Pointer"},
{name:"Giant Schnauzer"},
{name:"Glen of Imaal Terrier"},
{name:"Golden Retriever"},
{name:"Gordon Setter"},
{name:"Great Dane"},
{name:"Greater Swiss Mountain Dog"},
{name:"Great Pyrenees"},
{name:"Greyhound"},
{name:"Harrier"},
{name:"Havanese"},
{name:"Ibizan Hound"},
{name:"Irish Setter"},
{name:"Irish Terrier"},
{name:"Irish Water Spaniel"},
{name:"Irish Wolfhound"},
{name:"Italian Greyhound"},
{name:"Jack Russell Terrier"},
{name:"Japanese Chin"},
{name:"Keeshond"},
{name:"Kerry Blue Terrier"},
{name:"Komondor"},
{name:"Kuvasz"},
{name:"Labrador Retriever"},
{name:"Lakeland Terrier"},
{name:"Lhasa Apso"},
{name:"Lowchen"},
{name:"Maltese"},
{name:"Standard Manchester Terrier"},
{name:"Mastiff"},
{name:"Miniature Bull Terrier"},
{name:"Miniature Pinscher"},
{name:"Miniature Poodle"},
{name:"Miniature Schnauzer"},
{name:"Neapolitan Mastiff"},
{name:"Newfoundland"},
{name:"Norfolk Terrier"},
{name:"Norwegian Elkhound"},
{name:"Norwich Terrier"},
{name:"Nova Scotia Duck Tolling Retriever"},
{name:"Old English Sheepdog"},
{name:"Otterhound"},
{name:"Papillon"},
{name:"Parson Russell Terrier"},
{name:"Pekingese"},
{name:"Pembroke Welsh Corgi"},
{name:"Petit Basset Griffon Vendeen"},
{name:"Pharaoh Hound"},
{name:"Plott"},
{name:"Pointer"},
{name:"Polish Lowland Sheepdog"},
{name:"Pomeranian"},
{name:"Portuguese Water Dog"},
{name:"Pug"},
{name:"Puli"},
{name:"Rhodesian Ridgeback"},
{name:"Rottweiler"},
{name:"Saint Bernard"},
{name:"Saluki"},
{name:"Samoyed"},
{name:"Schipperke"},
{name:"Scottish Deerhound"},
{name:"Scottish Terrier"},
{name:"Sealyham Terrier"},
{name:"Shetland Sheepdog"},
{name:"Shiba Inu"},
{name:"Shih Tzu"},
{name:"Siberian Husky"},
{name:"Silky Terrier"},
{name:"Skye Terrier"},
{name:"Smooth Fox Terrier"},
{name:"Soft Coated Wheaten Terrier"},
{name:"Spinone Italiano"},
{name:"Staffordshire Bull Terrier"},
{name:"Standard Poodle"},
{name:"Standard Schnauzer"},
{name:"Sussex Spaniel"},
{name:"Swedish Vallhund"},
{name:"Tibetan Mastiff"},
{name:"Tibetan Spaniel"},
{name:"Tibetan Terrier"},
{name:"Toy Fox Terrier"},
{name:"Toy Manchester Terrier"},
{name:"Toy Poodle"},
{name:"Vizsla"},
{name:"Weimaraner"},
{name:"Welsh Springer Spaniel"},
{name:"Welsh Terrier"},
{name:"West Highland White Terrier"},
{name:"Whippet"},
{name:"Wire Fox Terrier"},
{name:"Wirehaired Pointing Griffon"},
{name:"Yorkshire Terrier"},
])
puts "Creating Sample User"
user = User.create(
  role: "seller",
  email: 't@g.com',
  name: FFaker::Name.name,
  password: 'asdfasdf',
  password_confirmation: 'asdfasdf',
  street_number_name: '1 Matalino St.,',
  suburb: 'Park Ridge',
  state: 'Queensland',
  postcode: '4125',
  breeder_supply_number: '0123456789',
)
attach_avatar_to_user(user)

guest = User.create(
  role: "guest",
  email: 'guest@g.com',
  name: FFaker::Name.name,
  password: 'asdfasdf',
  password_confirmation: 'asdfasdf',
  street_number_name: '11 Mas Matalino St.,',
  suburb: 'Park Ridge',
  state: 'Queensland',
  postcode: '4125',
  breeder_supply_number: '12345',
)
attach_avatar_to_user(guest)

admin = User.create(
  role: "admin",
  email: 'admin@g.com',
  name: FFaker::Name.name,
  password: 'asdfasdf',
  password_confirmation: 'asdfasdf',
  street_number_name: '10 Mas Matalino St.,',
  suburb: 'Park Ridge',
  state: 'Queensland',
  postcode: '4125',
  breeder_supply_number: '12345',
)
attach_avatar_to_user(admin)

puts "Creating Sample Listing"
Listing.create(breed: Breed.first, user: user, description: 'This is my dog', breeder_prefix: 'Mang Kiko')

puts "Seed Completed"

if ENV['SEED_DOGS']
  puts "Populating with Sample Listings..."

  seed_dogs_count = 50
  seed_dogs_count.times do |n|
    puts "Creating listing # #{n + 1}..."
    breed = Breed.order('RANDOM()').first
    listing_user = User.sellers.order('RANDOM()').first
    description = FFaker::HipsterIpsum.words(100).join(" ")
    breeder_prefix = FFaker::Company.name

    image_file = sample_dog_image_file

    listing = Listing.create(breed: breed, description: description, user: listing_user, breeder_prefix: breeder_prefix)
    listing.picture.attach(io: image_file, filename: "#{breed.name}-#{rand(1000000)}")
  end
end