# Create a default client
Client.find_or_create_by!(name: 'John Doe')

# Create a default PM
Pm.find_or_create_by!(name: 'Project Manager')

# Create some video types
VideoType.find_or_create_by!(name: 'Highlight Reel', price: 500)
VideoType.find_or_create_by!(name: 'Full Documentary Edit', price: 2000)
VideoType.find_or_create_by!(name: 'Teaser', price: 250)
VideoType.find_or_create_by!(name: 'Social Media Clip', price: 150)
