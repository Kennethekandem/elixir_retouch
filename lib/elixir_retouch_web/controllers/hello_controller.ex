defmodule ElixirRetouchWeb.HelloController do
  use ElixirRetouchWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
