def check_for_updates()
  begin
    response = pbDownloadToString("https://raw.githubusercontent.com/MickTK/Pokemon-Essentials-Plugins/main/Daily%20Reward%20System/meta.json")
    response = HTTPLite::JSON.parse(response)
    puts "\e[32m#{response["message"]}\e[0m" if response["version"] > PluginManager.version("Daily Reward System")
  rescue; return; end
end
check_for_updates
