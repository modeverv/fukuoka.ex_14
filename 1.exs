case [1,2,3] do
	[1,z,3] when z > 0 ->
		"match"
	_ ->
		"not match"
end

z #=> undefined スコープかね？
case {1, 2, 3} do
   {1, x, 3} when x > 0 ->
     "Will match"
   _ ->
     "Won't match"
end
#{}はタプル

sum = fn (a,b) -> a + b end
sum.(2,3)

#省略気泡
sum = &(&1 + &2)

defmodule Greeter do
	def hello(name) do
		"hello, " <> name
	end
	#, do:
	def h(name), do: "Hello, " <> name
end
Greeter.hello("Mike")
Greeter.h("hhh")

defmodule Length do
	def of([]), do: 0
	def of([_ | tail]), do: 1 + of(tail)
end

Length.of [1,2,3]

# Elixirは複数のマッチング関数にデフォルト引数があるのを好みません。混乱の元になる可能性があります。これに対処するには、デフォルト引数付きの関数を先頭に追加します:

defmodule Greeter do
  def hello(names, language_code \\ "en")

  def hello(names, language_code) when is_list(names) do
    names
    |> Enum.join(", ")
    |> hello(language_code)
  end

  def hello(name, language_code) when is_binary(name) do
    phrase(language_code) <> name
  end

  defp phrase("en"), do: "Hello, "
  defp phrase("es"), do: "Hola, "
end

Greeter.hello ["Sean", "Steve"]
"Hello, Sean, Steve"

Greeter.hello ["Sean", "Steve"], "es"
"Hola, Sean, Steve"

"Hello Sean Steve" |> String.split()


# 構造体
defmodule Example.User do
	defstruct name: "Sean", roles: []
end

%Example.User()


for x <- [1,2,3],do: x * x
for x <- [1,2,3] do x * x end

import Integer
for x <- 1..10, is_even(x), do: x


for {k, v} <- [one: 1, two: 2, three: 3], into: %{}, do: {k, v}
for c <- [72, 101, 108, 108, 111], into: "", do: <<c>>
