defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Router.Helpers

  def init(_) do
  end

  def call(conn, _) do
    case conn.assigns[:user] do
      nil ->
        conn
        |> put_flash(:error, "You must be logged in.")
        |> redirect(to: Helpers.topic_path(conn, :index))
        |> halt()
      _ -> conn
    end
  end
end