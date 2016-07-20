# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GoodsManage.Repo.insert!(%GoodsManage.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

GoodsManage.Repo.insert!(%GoodsManage.Account{uuid: UUID.uuid3(:dns, "admin"), account: "admin", password: :crypto.md5("admin")|> Base.encode16})
