defmodule Discuss.User do
  use Discuss.Web, :model

  schema "users" do
    field :email, :string
    field :token, :string
    field :provider, :string
    has_many :topics, Discuss.Topic

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :token, :provider])
    |> validate_required([:email, :token, :provider])
  end
end
