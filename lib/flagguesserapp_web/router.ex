defmodule FlagguesserappWeb.Router do
  use FlagguesserappWeb, :router

  import FlagguesserappWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :fetch_current_user
    plug :put_root_layout, html: {FlagguesserappWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :require_authenticated_user
    plug :require_admin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FlagguesserappWeb do
    pipe_through :browser

    live_session :browser,
      on_mount: {FlagguesserappWeb.UserAuth, :mount_current_user} do
      live "/", FlagLive.Overview, :index

      live "/flags/:id", FlagLive.Show, :show

      live "/quiz/:slug", QuizLive.Index, :index

      live "/regions/:id", RegionLive.Show, :show
    end
  end

  scope "/", FlagguesserappWeb do
    pipe_through [:browser, :admin]

    live_session :admin,
      on_mount: {FlagguesserappWeb.UserAuth, :mount_current_user},
      on_mount: {FlagguesserappWeb.UserAuth, :ensure_authenticated},
      on_mount: {FlagguesserappWeb.UserAuth, :ensure_admin} do
      live "/admin/flags", AdminFlagLive.Index, :index
      live "/admin/flags/new", AdminFlagLive.Form, :new

      live "/admin/flags/:id/edit", AdminFlagLive.Form, :edit

      live "/admin/regions", AdminRegionLive.Index, :index
      live "/admin/regions/new", AdminRegionLive.Form, :new

      live "/admin/regions/:id/edit", AdminRegionLive.Form, :edit

      live "/admin/users", AdminUserLive.Index, :index
      live "/admin/users/new", AdminUserLive.Form, :new

      live "/admin/users/:id/edit", AdminUserLive.Form, :edit
    end
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

  ## Authentication routes

  scope "/", FlagguesserappWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{FlagguesserappWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log-in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log-in", UserSessionController, :create
  end

  scope "/", FlagguesserappWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{FlagguesserappWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", FlagguesserappWeb do
    pipe_through [:browser]

    delete "/users/log-out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{FlagguesserappWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
