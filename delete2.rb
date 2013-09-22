require 'digital_ocean'


dc = DigitalOcean::API.new :client_id => 'CLIENT ID GOES HERE',
                           :api_key   => 'API KEY GOES HERE'
                           
# Gets list of DigitalOcean active droplet information
do_list = dc.droplets.list.droplets

print "\n"

to_be_deleted = Array.new

# Checks if any droplets have -d in the name
do_list.each do |hash|
  if hash.name.include?("-d")
    # Adds the droplet ID to the array of droplets to be deleted
    to_be_deleted.push(hash.id)
end
to_be_deleted
end


if to_be_deleted.any? == true
  puts "Delete the following droplets? (yes or no)"
  puts to_be_deleted
  result = gets.chomp
    if result == "yes" or result =="y"
      to_be_deleted.each do |d|
        puts "#{d} will be deleted"
        dc.droplets.delete d
      end
    else
      puts "Nothing will be deleted"
  end
 
else 
  puts "No Droplets to Delete"

end

