defmodule GoodsManage.Router do
  use GoodsManage.Web, :router
  alias GoodsManage.CheckoutToken, as: CheckoutToken

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CheckoutToken
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # only: except:
  # Get :index, :edit, :new, :show || Post :create || Patch :update  || Put :update
  scope "/", GoodsManage do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/session", PageController, :session

    resources "/accounts", AccountController

    get "/orders", OrderController, :index
    post "/orders", OrderController, :create
    get "/orders/:type", OrderController, :orders
  end

  # Other scopes may use custom stacks.
  # scope "/api", GoodsManage do
  #   pipe_through :api
  # end
end
