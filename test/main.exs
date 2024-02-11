defmodule X do
  def main(args) do
    case args do
      [w_str] ->
        w = String.to_float(w_str)
        # lets do milli eV
        k = 8.6173 * 10 ** -2
        result = k * :math.log(w)
        IO.puts(Float.round(result, 4))

      _ ->
        nil
    end
  end
end

X.main(System.argv())