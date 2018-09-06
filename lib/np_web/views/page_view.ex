defmodule NpWeb.PageView do
  use NpWeb, :view

  def last_page?(page),  do: page.page_number == page.total_pages
  def first_page?(page), do: page.page_number == 1
end
