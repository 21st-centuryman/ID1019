defmodule Moves do


  def single({:one, n}, {main, one, two}) do
      cond do
          length(main) - n < 0 ->
              {main, one, two}
          n < 0 ->
              {Lists.append(main, Lists.take(one, n*-1)), Lists.drop(one, n * -1), two}
          n > 0 ->
              {Lists.take(main, length(main)-n), Lists.append(Lists.drop(main, length(main)-n), one), two}
          true -> {main, one, two}
      end
  end


  def single({:two, n}, {main, one, two}) do
      cond do
          length(main) - n < 0 ->
              {main, one, two}
          n < 0 ->
              {Lists.append(main, Lists.take(two, n*-1)), one, Lists.drop(two, n*-1)}
          n > 0 ->
              {Lists.take(main, length(main)-n), one, Lists.append(Lists.drop(main, length(main)-n), two)}
          true -> {main, one, two}
      end
  end

  def move(moves, state) do
      case moves do
          [] -> [state]
          [h|t] -> [state | move(t, single(h, state))]
      end
  end
end
