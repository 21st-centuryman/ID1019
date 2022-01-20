defmodule Fibonacci do
  def bench_fib() do
    ls = [8,10,12,14,16,18,20,22,24,26,28,30,32]
    n = 10
    bench = fn(l) ->
    t = time(n, fn() -> fib(l) end)
    :io.format("n: ~4w fib(n) calculated in: ~8w us~n", [l, t])
    end
    Enum.each(ls, bench)
  end

  def fib(n) do
    case n do
      1 -> 1
      2 -> 1
      n -> fib(n-1)+fib(n-2)
    end
end

end
