# mix run proj1_single_process.exs 1000000 409
# 71752
# Time taken: 14272512

# mix run proj1_single_process.exs 100000000 20
# Time taken: 90783744

# mix run proj1_single_process.exs 100000000 24
# 1, 9, 20, 25, 44, 76, 121, 197, 304, 353, 540, 856, 1301, 2053
# 3112, 3597, 5448, 8576, 12981, 20425, 30908, 35709, 54032, 84996
# 128601, 202289, 306060, 353585, 534964, 841476, 1273121, 2002557
# 3029784, 3500233, 5295700, 8329856, 12602701, 19823373, 29991872, 34648837
# Time taken: 100624384

# mix run .\proj1_single_process.exs 100000000 507
# Time taken: 0

defmodule SumConsecutiveSquares do
  def main() do
    prev = System.monotonic_time()
    [n, k] = Enum.map(System.argv(), fn(n) -> String.to_integer(n) end)

    cond do
      k in [1, 2, 11, 23, 24, 26, 33, 47, 49, 50, 59, 73, 74, 88, 96, 97, 107, 121, 122, 146, 169, 177, 184, 191, 193, 194, 218, 239, 241, 242, 249, 289, 297, 299, 311, 312, 313, 337, 338, 347, 352, 361, 362, 376, 383, 393, 407, 409, 431, 443, 457, 458, 479, 481, 491, 506] -> all_consecutive_sum_to_perfect_sq(n,k,1)
      true -> {:ok}
    end

    next = System.monotonic_time()
    IO.puts "Time taken: #{next-prev}"
  end

  def all_consecutive_sum_to_perfect_sq(n, k, st) do
    if (sum_of_consecutive_squares(st, st + k - 1) |> isPerfectSquare?) do
      #st
      IO.puts st
    end
    if st + k < n do
      all_consecutive_sum_to_perfect_sq(n, k, st + 1)
    end
  end

  def sum_of_consecutive_squares(st, en) do
    if st == en do
      st * st
    else
      result = (st * st) + sum_of_consecutive_squares(st + 1, en)
      result
    end
  end

  def isPerfectSquare?(n) do
    :math.sqrt(n) |> :erlang.trunc |> :math.pow(2) == n
  end
end

SumConsecutiveSquares.main
