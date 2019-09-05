defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  alias Discuss.{Topic, Comment}

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Repo.get(Topic, topic_id)

    {:ok, %{}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic

    changeset = topic
      |> build_assoc(:comments)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} -> reply_handled(:ok, socket)
      {:error, _} -> reply_handled({:error, %{errors: changeset}}, socket)
    end
  end

  defp reply_handled(content, socket) do
    {:reply, content, socket }
  end
end