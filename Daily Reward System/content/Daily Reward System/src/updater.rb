class DailyReward
  @@name = "Daily Reward System"
  def self.check_for_updates()
    response = pbDownloadToString("https://raw.githubusercontent.com/MickTK/Pokemon-Essentials-Plugins/main/#{@@name.force_encoding("utf-8")}/meta.json")
    return if response == ""
    puts response["message"] if response["version"] > PluginManager.version(@@name)
  end
  check_for_updates
end
