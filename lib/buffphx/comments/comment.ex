defmodule Buffphx.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :markup_text, :string

    belongs_to :user, Buffphx.Accounts.User
    belongs_to :gist, Buffphx.Gists.Gist

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:markup_text, :user_id, :gist_id])
    |> validate_required([:markup_text, :user_id, :gist_id])
  end
end