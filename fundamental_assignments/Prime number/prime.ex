defmodule Task1 do

  def new(n) do
      [h|t] = Enum.to_list(2..n)
      [h|rmv(h, t)]
  end

  def rmv(x, []) do [] end
  def rmv(x, [h|t]) do
    [h|rmv(h, Enum.filter(t, fn p -> rem(p, x) != 0 end))]
  end
end

defmodule Task2 do

  def new(n) do
      list = Enum.to_list(2..n)
      new(list, [])
  end

  def new(list, primes) do
    case list do
      [] -> primes
      [h|t] ->
          primes = addPrime(list, h, primes)
          new(t, primes)
    end
  end

  def addPrime(list, x, primes) do
      case isPrime(list, primes) do
          true -> primes ++ [x]
          false -> primes
      end
  end

  def isPrime(_, []) do true end

  def isPrime([h|t], [h2|t2]) do
    primes = [h2|t2]
      cond do
          rem(h, h2) == 0 ->
              false
          true ->
            isPrime([h|t], t2)
      end
  end
end

defmodule Task3 do

  def new(n) do
      list = Enum.to_list(2..n)
      new(list, [])
  end

  def new(list, primes) do
    case list do
      [] -> Enum.reverse(primes)
      [h|t] ->
        primes = addPrime(list, h, primes)
        new(t, primes)
    end
  end

  def addPrime(list, x, primes) do
    case isPrime(list, primes) do
      true -> [x] ++ primes
      false -> primes
    end
  end

  def isPrime(_, []) do true end

  def isPrime([h|t], primes = [h2|t2]) do
      cond do
          rem(h, h2) == 0 ->
              false
          true -> isPrime([h|t], t2)
      end
  end
end

defmodule Bench do

  def bench(n) do
      IO.inspect(:timer.tc(fn -> Task1.new(n) end))
      IO.inspect(:timer.tc(fn -> Task2.new(n) end))
      IO.inspect(:timer.tc(fn -> Task3.new(n) end))

      :ok
  end

end
