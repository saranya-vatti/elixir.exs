defmodule ConsecutiveSquares do
  def spawn_link(input) do
    spawn_link(__MODULE__, :init, [input])
  end

  def get_worker_size(k, n) do
    cond do
      k >= n ->
        n
      n/k < 10000 ->
        n
      true -> div(n, 10000)
    end
  end

  def init([n, k]) do
    if k in [1, 2, 11, 23, 24, 26, 33, 47, 49, 50, 59, 73, 74, 88, 96, 97, 107, 121, 122, 146, 169, 177, 184, 191, 193, 194, 218, 239, 241, 242, 249, 289, 297, 299, 311, 312, 313, 337, 338, 347, 352, 361, 362, 376, 383, 393, 407, 409, 431, 443, 457, 458, 479, 481, 491, 506] do
      worker_size = get_worker_size(n, k)
      num_of_children = div(n, worker_size)
      num_of_children = if rem(n, worker_size) == 0, do: num_of_children, else: num_of_children+1
      IO.puts "Number of child processes : #{num_of_children}"
      Enum.map(1..num_of_children, fn(child_num) ->
        start = ((child_num - 1) * worker_size) + 1
        en = start + worker_size - 1
        en = if (en > n), do: n, else: en
        pid = spawn_link(Worker, :init, [start, en, k])
        # IO.puts "Spawned PID : #{inspect pid}"
      end)
    end
  end
end

defmodule Worker do
  def init(batch_start, batch_end, k) do
    all_consecutive_sum_to_perfect_sq(batch_start, batch_end, k)
  end

  def all_consecutive_sum_to_perfect_sq(st, en, k) do
    if (sum_of_consecutive_squares(st, st + k - 1) |> isPerfectSquare?) do
      IO.puts st
    end
    if st < en do
      all_consecutive_sum_to_perfect_sq(st + 1, en, k)
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

prev = System.monotonic_time()
command_line_args = System.argv()
if length(command_line_args) < 2 do
  raise ArgumentError, message: "there must be at least two arguments: n and k"
end
[n, k | _tail] = command_line_args
[n, k] = Enum.map([n, k], fn(n) ->
  try do
    n |> String.trim_trailing |> String.to_integer
  rescue
    ArgumentError -> IO.puts("n and k must be integers. Defaulting #{n} to 1")
    1
  end
end)
ConsecutiveSquares.init([n, k])
next = System.monotonic_time()
IO.puts "Time taken: #{next-prev}"
