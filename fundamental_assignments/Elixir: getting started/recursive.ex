defmodule Recursive do
  def product(m, n) do
    case m do
      0 -> 0
      x -> n + ((m - 1) * n)
    end
  end
  def exp(x,n) do
    case n do
      0 -> 1
      1 -> x
      n -> 
    end
  end
end
