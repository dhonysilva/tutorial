defmodule TutorialWeb.AlbumLive do
  use TutorialWeb, :live_view

  alias Tutorial.Beatles

  def render(assigns) do
    ~H"""
    <div class="flex h-screen bg-slate-200">
      <div class="w-64 bg-slate-700 text-white shadow-md px-4 py-6">
        <h2 class="text-lg font-bold mb-4">
          <a href={~p"/albums"}>Albums</a>
          <a href={~p"/beatles"} class="text-sm hover:underline font-normal">
            View Beatles
          </a>
        </h2>
        <ul class="space-y-2">
          <li :for={album <- @albums} class="hover:bg-slate-600 rounded">
            <a href={~p"/albums/#{album}"} class="block p-2 w-full h-full">
              {album.name}
            </a>
          </li>
        </ul>
      </div>

      <div class="flex-1 p-6">
        <div :if={@album} class="bg-white shadow-md p-4 rounded-lg">
          <img
            src={"/images/albums/" <> @album.cover}
            alt={"#{@album.name} cover"}
            class="w-32 h-32 rounded-sm object-cover mb-4"
          />
          <h1 class="text-xl font-bold mb-2">{@album.name}</h1>
          <p class="text-gray-600 mb-1">
            <strong>Released:</strong> {Timex.format!(@album.released, "{Mfull} {D}, {YYYY}")}
          </p>
          <p class="text-gray-600 mb-1">
            <strong>Duration:</strong> {@album.duration} minutes
          </p>
          <p class="text-gray-600 mb-1">
            <strong>Label:</strong> {@album.label}
          </p>
          <p class="text-gray-600 mb-1">
            <strong>Number of tracks:</strong> {@album.number_of_tracks}
          </p>
        </div>

        <div :if={!@album} class="bg-white shadow-md p-4 rounded-lg">
          Select an album from the sidebar
        </div>
      </div>
    </div>
    """
  end

  def mount(params, _session, socket) do
    albums = Beatles.list_albums()

    album =
      case Map.fetch(params, "id") do
        {:ok, id} -> Enum.find(albums, &(to_string(&1.id) == id))
        :error -> nil
      end

    {:ok, assign(socket, album: album, albums: albums)}
  end
end
