
defmodule Emulator do

  @type literal() :: {:num, number()} | {:var, atom()}

  @type expr() :: literal()
  | {:label, expr()}
  | {:add, expr(), expr(), expr()}
  | {:sub, expr(), expr(), expr()}
  | {:addi, expr(), expr(), literal()}
  | {:lw, expr(), expr(), literal()}
  | {:sw, expr(), expr(), literal()}
  | {:beq, expr(), expr(), literal()}
  | {:bne, expr(), expr(), literal()}

  def run(code, mem, out) do
    reg = Register.new()
    run(0, code, mem, reg, out)
  end

  def run(pc, code, reg, mem, out) do

    next = Program.read_instruction(code, pc)

    case next do

      {:halt} ->
        Out.close(out)

      {:out, rs} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        out = Out.put(out, s)
        run(pc, code, reg, mem, out)

      {:add, rd, rs, rt} ->
        reg = Register.write(reg, rd, Register.read(reg, rs)+ Register.read(reg,rt))
        run(pc, code, mem, reg, out)

      {:sub, rd, rs, rt} ->
        reg = Register.write(reg, rd, Register.read(reg, rs) - Register.read(reg,rt))
        run(pc, code, mem, reg, out)

      {:addi, rd, rs, imm} ->
        reg = Register.write(reg, rd, Register.read(reg,rs) + imm)
        run(pc, code, mem, reg, out)

      {:beq, rs, rt, offset} ->
        if Register.read(reg, rs) == Register.read(reg,rt) do
          pc = pc+offset
        end
        run(pc, code, mem, reg, out)

      {:bne, rs, rt, offset} ->
        if Register.read(reg, rs) != Register.read(reg,rt) do
          pc = pc+offset
        end
        run(pc, code, mem, reg, out)

      #{:lw, rd, rs, imm} ->
	      val = Memory.read(mem, (Register.read(reg, rs) + imm))
	      reg = Register.write(reg, rd, val)
	      run(pc+1, code, mem, reg, out)
      #{:sw, rd, rs, imm} ->

      ##{:label, label} ->

    end
  end
end



defmodule Program do

  def load(prgm) do
    {:code, List.to_tuple(prgm)}
  end

  def read_instruction({:code, code}, pc) do
    elem(code, pc)
  end
end


defmodule Out do
  def new() do [] end
  def put(out, s) do [s|out] end
  def close(out) do Enum.reverse(out) end
end


defmodule Register do
  def read(_, 0) do 0 end
  def read(reg, i) do elem(reg, i) end

  def write(reg, rs, imm) do put_elem(reg, rs, imm)end

  def new() do
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  end

  """
  def newLabels() do {0,0,0,0,0} end

  def writeLabels(labels, locale, pc) do put_elem(labels, locale, pc) end
  """
end



defmodule Test do

  def test() do
    code = Program.load(demo())
    mem = Memory.new([])
    out = Out.new()
    Emulator.run(code, mem, out)
  end

  def demo() do
    [{:addi, 1, 0, 10},    # $1 <- 10
     {:addi, 2, 0, 5},     # $2 <- 5
     {:add, 3, 1, 2},      # $3 <- $1 + $2
     {:addi, 5, 0, 1},     # $5 <- 1
     {:sub, 4, 4, 5},      # $4 <- $4 - $5
     {:out, 4},            # out $4
     {:bne, 4, 0, -3},     # branch if not equal
     {:halt}]
  end
end




defmodule Memory do

  def new() do
    new([])
  end

  def new(segments) do
    f = fn({start, data}, layout) ->
      last = start +  length(data) -1
      Enum.zip(start..last, data) ++ layout
    end
    layout = List.foldr(segments, [], f)
    {:mem, Map.new(layout)}
  end

  def read({:mem, mem}, i) do
    case Map.get(mem, i) do
      nil -> 0
      val -> val
    end
  end

  def write({:mem, mem}, i, v) do
    {:mem, Map.put(mem, i, v)}
  end

end
