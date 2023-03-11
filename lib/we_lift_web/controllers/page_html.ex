defmodule WeLiftWeb.PageHTML do
  use WeLiftWeb, :html

  use Phoenix.Component

  embed_templates "page_html/*"

  def feature(assigns) do
    ~H"""
    <div class="flex lg:h-[580px] h-[730px] flex-row p-8">
      <div class="flex lg:flex-row flex-col container mx-auto">
        <div class="flex lg:w-1/2 p-8">
          <div class="flex flex-col justify-center max-w-2xl">
            <div class="font-bold lg:text-start text-center text-4xl"><%= @title %></div>
            <div class="text-xl lg:text-start text-center"><%= @description %></div>
          </div>
        </div>
        <div class="flex lg:w-1/2 justify-center">
          <div class="flex flex-col justify-center max-w-xl">
            <img class="border-2 border-black rounded-2xl" src={@image} />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
