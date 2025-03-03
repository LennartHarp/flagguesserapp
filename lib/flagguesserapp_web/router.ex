defmodule FlagguesserappWeb.Router do
  use FlagguesserappWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FlagguesserappWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FlagguesserappWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/flags/overview", FlagLive.Overview, :index

    live "/flags", AdminFlagLive.Index, :index
    live "/flags/new", AdminFlagLive.Form, :new

    live "/flags/:id", FlagLive.Show, :show
    live "/flags/:id/edit", AdminFlagLive.Form, :edit

    live "/quiz/:slug", QuizLive.Index, :index

    live "/regions", AdminRegionLive.Index, :index
    live "/regions/new", AdminRegionLive.Form, :new

    live "/regions/:id", RegionLive.Show, :show
    live "/regions/:id/edit", AdminRegionLive.Form, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", FlagguesserappWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:flagguesserapp, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FlagguesserappWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
