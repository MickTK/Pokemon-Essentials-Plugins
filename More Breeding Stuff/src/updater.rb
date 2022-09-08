module MoreBreedingStuff
  def self.check_for_updates()
    name = "More Breeding Stuff"
    link = "https://raw.githubusercontent.com/MickTK/Pokemon-Essentials-Plugins/main/versions.json"
    begin
      data = HTTPLite::JSON.parse(pbDownloadToString(link))
      if data[name]["version"] > PluginManager.version(name)
        message = "UPDATE: A new version of \"#{name}\" is available! Download it here: #{data[name]["link"]}."
        puts "\e[32m#{message}\e[0m"
      end
    rescue Exception
    end
  end
  MoreBreedingStuff.check_for_updates
end
