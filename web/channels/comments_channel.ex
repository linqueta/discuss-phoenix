defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  alias Discuss.{Topic, Comment}

  def join("comments:" <> topic_id, _params, socket) do
    topic = Topic
     |> Repo.get(handle_topic_id(topic_id))
     |> Repo.preload(comments: [:user])

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic

    changeset = topic
      |> build_assoc(:comments, user_id: socket.assigns.user_id)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{topic.id}:new", %{comment: comment})
        reply_handled(:ok, socket)
      {:error, _} -> reply_handled({:error, %{errors: changeset}}, socket)
    end
  end

  defp reply_handled(content, socket) do
    {:reply, content, socket }
  end

  defp handle_topic_id(topic_id) do
    String.to_integer(topic_id)
  end
end