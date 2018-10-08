module Infosimples::Data
  class SymmetricEncryption
    attr_accessor :key
    def initialize(key)
      fail("INVALID KEY SIZE: #{key}") if key.size < 32
      self.key = key[0,32]
    end

    def encrypt(data, to_base64=true)
      aes = OpenSSL::Cipher.new('AES-256-CBC')
      aes.encrypt
      aes.key = Digest::SHA256.digest(key)
      encrypted_data = aes.update(data) + aes.final
      to_base64 ? Base64.encode64(encrypted_data) : encrypted_data
    end

    def decrypt(data, from_base64=true)
      data = Base64.decode64(data) if from_base64
      aes = OpenSSL::Cipher.new('AES-256-CBC')
      aes.decrypt
      aes.key = Digest::SHA256.digest(key)
      aes.update(data) + aes.final
    end
  end
end
