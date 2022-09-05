def pbDailyReward()
	return DailyReward.check
end
class DailyReward
	@@last_login  = nil # Date of last login
	@@logins      = 1   # Total logins
	@@consecutive = 1   # Number of consecutive logins

  def self.check()
    now = Time.now
    @@last_login = (now-(60*60*24)) if @@last_login == nil
    days_passed = ((Time.local(now.year,now.month,now.day)-Time.local(@@last_login.year,@@last_login.month,@@last_login.day))/(60*60*24)).to_i
    case days_passed
		when 0
			return false
		when 1
			@@consecutive = @@consecutive.to_i + 1
		else
			@@consecutive = 1
		end
		@@logins = @@logins.to_i + 1
		REWARDS.call(now.day,now.month,now.year,@@logins,@@consecutive) if REWARDS != nil
		@@last_login = now
		return true
	end

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
