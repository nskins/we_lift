defmodule WeLiftWeb.PageHTML do
  use WeLiftWeb, :html

  use Phoenix.Component

  embed_templates "page_html/*"

  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :image, :string, required: true
  attr :border, :boolean, default: false
  attr :black, :boolean, default: false
  attr :reverse, :boolean, default: false
  attr :hero, :boolean, default: false
  attr :link, :boolean, default: false

  def feature(assigns) do
    assigns =
      assigns
      |> assign(:border_style, if(assigns.border, do: "border-2 border-black", else: ""))
      |> assign(
        :color_style,
        if(assigns.black, do: "bg-black text-white", else: "bg-white text-black")
      )
      |> assign(
        :image_order_style,
        if(assigns.reverse, do: "lg:order-1 order-2", else: "order-2")
      )
      |> assign(:text_order_style, if(assigns.reverse, do: "lg:order-2 order-1", else: "order-1"))
      |> assign(
        :height_style,
        if(assigns.hero, do: "lg:h-[680px] h-fit", else: "lg:h-[580px] h-fit")
      )
      |> assign(:title_font_size, if(assigns.hero, do: "sm:text-6xl text-4xl", else: "text-4xl"))
      |> assign(:description_font_size, if(assigns.hero, do: "sm:text-2xl text-xl", else: "text-xl"))

    ~H"""
    <div class={"flex #{@height_style} flex-row p-8 #{@color_style}"}>
      <div class="flex lg:flex-row flex-col container mx-auto">
        <div class={"flex lg:w-1/2 p-8 #{@text_order_style}"}>
          <div class="flex flex-col justify-center max-w-2xl">
            <div class={"font-bold lg:text-start text-center #{@title_font_size}"}><%= @title %></div>
            <div class={"lg:text-start text-center #{@description_font_size}"}>
              <%= @description %>
            </div>
            <%= if @link do %>
              <a
                class="lg:text-start text-center text-blue-700 underline text-xl"
                href="https://github.com/nskins/we_lift"
              >
                View the source code
              </a>
            <% end %>
          </div>
        </div>
        <div class={"flex lg:w-1/2 lg:p-0 pb-8 justify-center #{@image_order_style}"}>
          <div class="flex flex-col justify-center max-w-xl">
            <img class={"rounded-2xl #{@border_style}"} src={@image} />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
