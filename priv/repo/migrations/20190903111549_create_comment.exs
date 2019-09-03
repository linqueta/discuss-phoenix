defmodule Discuss.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string
      add :topic_id, references(:topics, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:comments, [:topic_id])
    create index(:comments, [:user_id])

  end
end
