defmodule Utils do

  defmacro left ~> right do
    {poppers, x, h} = right
    {poppers, x, (h ++ [left])}
  end

  def printest a, b do
    a <> b
  end
end

