defmodule GoodsManage.Utility do

  #access.99754106633f94d350db34d548d6091a 的value -->> uuid:trader_id
  def generate_token(uuid) do
		case Exredis.start_link do
			{:ok, pid} ->
				currentTime = :os.system_time(:seconds)
				access_token = :crypto.hash(:sha, to_string(currentTime)) |> Base.encode16
				IO.puts "utility access." <> access_token
				Exredis.query(pid, ["SET", "access." <> access_token, uuid])
				Exredis.query(pid,["expire", "access." <> access_token, 2592000]) # 一个月
				# refresh_token = :crypto.hash(:sha, to_string(currentTime) <> to_string(:random.uniform)) |> Base.encode16
				# IO.puts "refresh." <> refresh_token
				# Exredis.query(pid, ["SET", "refresh." <> refresh_token, access_token <> ":" <> uuid <> ":" <> trader_id])
				# Exredis.query(pid, ["expire", "refresh." <> refresh_token, 2592000 * 3])
				# expires_in = currentTime + 86400
				{:ok, %{access_token: access_token}}
			_ ->
				{:error, "can not link redis"}
		end
	end

end
