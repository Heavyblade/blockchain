require 'digest'
require 'pp'

blockchain = []

class Block
  attr_reader :data
  attr_reader :hash
  attr_reader :nonce
  attr_reader :prev
  attr_reader :time

  def initialize(data, prev="")
      @data = data
      @prev = prev
      @hash, @nonce = compute_hash_with_proof_or_work
  end

  def compute_hash_with_proof_or_work(difficulty = '00')
      nonce = 0
      time = Time.now.to_i
      loop do
        hash = Digest::SHA256.hexdigest("#{nonce}#{time}#{difficulty}#{prev}#{data}")
        if hash.start_with?(difficulty)
          return nonce, hash
        end
        nonce += 1
      end
  end
end

block1 = Block.new("Hola mundo")
block2 = Block.new("Hola2", block1.hash)

blockchain.push(block1)
blockchain.push(block2)

pp blockchain
