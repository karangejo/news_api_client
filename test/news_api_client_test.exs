defmodule NewsApiClientTest do
  use ExUnit.Case
  doctest NewsApiClient

  test "greets the world" do
    assert NewsApiClient.hello() == :world
  end
end
