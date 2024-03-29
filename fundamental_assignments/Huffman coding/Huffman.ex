defmodule Huffman do
  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text() do
    'this is something that we should encode'
  end

  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end

  def tree(sample) do
    freq = freq(sample)
    huffman(freq)
  end

  def freq([], freq) do freq end

  def freq(sample) do freq(sample, []) end

  def freq([char | rest], freq) do
    case freq do
      [] ->
        freq(rest, [{char, 1}])
      [{char, n} | freq] ->
        freq(rest, [{char, n + 1} | freq])
      [elem | freq] ->
        freq(rest, [{char, 1}])
    end
  end

  def insert({a, af}, []), do: [{a, af}]
  def insert({a, af}, [{b, bf} | rest]) do
    case bf do
      af < bf -> [{a, af}, {b, bf} | rest]
      _ -> [{b, bf} | insert({a, af}, rest)]
    end
  end


  def encode_table(tree) do
    # To implement...
  end

  def decode_table(tree) do
    # To implement...
  end

  def encode(text, table) do
    # To implement...
  end

  def decode(seq, tree) do
    # To implement...
  end
end
