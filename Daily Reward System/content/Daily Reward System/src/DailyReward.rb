def pbDailyReward()
  return DailyReward.get
end

class DailyReward
  @@last_login = nil                       # Last login date
  def last_login;return @@last_login;end   # Getter
  @@logins = 1                             # Total logins
  def logins;return @@logins;end           # Getter
  @@consecutive = 1                        # Number of consecutive logins
  def consecutive;return @@consecutive;end # Getter

  # Informations
  def self.day(day = 0); return day == 0 || day == Time.now.day; end
  def self.month(month = 0); return month == 0 || month == Time.now.month; end
  def self.year(year = 0); return year == 0 || year == Time.now.year; end
  def self.date(day = 0, month = 0, year = 0); return day(day) && month(month) && year(year); end
  def self.days_passed
    now = Time.now
    @@last_login = (now-(60*60*24)) if @@last_login == nil
    return ((Time.local(now.year,now.month,now.day)-Time.local(@@last_login.year,@@last_login.month,@@last_login.day))/(60*60*24)).to_i
  end

  # Check if the player can get rewards
  def self.get()
    now = Time.now                                         # Get current datetime
    case days_passed                                       # Days passed since the last login
    when 0; return false
    when 1; @@consecutive = @@consecutive.to_i + 1         # Update consecutive logins counter
    else; @@consecutive = 1                                # Update consecutive logins counter
    end
    @@logins = @@logins.to_i + 1                           # Update logins counter
    REWARDS.call(now.day,now.month,now.year,@@logins,@@consecutive) if REWARDS
    @@last_login = now                                     # Update last login date
    return true
  end

  # Reset the counters
  def self.reset()
    @@last_login  = nil
    @@logins      = 1
    @@consecutive = 1
  end
  
  SaveData.register(:daily_rewards) do
    save_value { [@@last_login, @logins, @consecutive] }
    load_value do |data|
      @@last_login  = data[0]
      @@logins      = data[1]
      @@consecutive = data[2]
    end
  end
end
