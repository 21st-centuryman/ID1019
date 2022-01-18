# 1. Simple arithmetic
  # > 6 + 2
  # 8
  # > 6 / 2
  # 3.0
  # > div(7,2)
  # 3
  # > rem(7,2)
  # 1
  # > rem(-1,5)
  # -1
  # > 3 == 3
  # true
  # > 3 != 4
  # true
  # > 4 < 7
  # true
  # > h()
  # Helping section

# 2. A first program
  defmodule Test do
    # Compute the double of a number.
    def double(n) do
    ...
    end
  end

# 3. Recursive definitions


# 4. List operations


# 5. Reverse


# 6. More challenges

  # 6.1 Integer to binary

  # 6.2 Binary to interger

  def to_integer(x) do to_integer(x, ...) end
  def to_integer([], n) do ... end
  def to_integer([x | r], n) do
    to_integer(..., ...)
  end

# 7. Fibonacci
  def bench_fib() do
      ls = [8,10,12,14,16,18,20,22,24,26,28,30,32]
      n = 10

    bench = fn(l) ->
      t = time(n, fn() -> fib(l) end)
      :io.format("n: ~4w fib(n) calculated in: ~8w us~n", [l, t])
    end
    Enum.each(ls, bench)
  end
