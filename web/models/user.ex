defmodule Discuss.User do
  use Discuss.Web, :model

  schema "users" do
    field :name, :string
    field :token, :string
    field :provider, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :token, :provider])
    |> validate_required([:name, :token, :provider])
  end
end
