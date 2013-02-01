require 'spec_helper'

module Mongoid
  describe EncryptedField do

    before(:all) do
      Mongoid::EncryptedFields.cipher = GibberishCipher.new('my test password')
    end

    it "should encrypt and decrypt a string" do
      plaintext = "this is a test!"
      encrypted = Mongoid::EncryptedString.encrypt(plaintext)
      unencrypted = Mongoid::EncryptedString.decrypt(encrypted)

      unencrypted.should eq(plaintext)
    end

    it "should be able to identify an encrypted string" do
      plaintext = "this is a test!"
      Mongoid::EncryptedString.is_encrypted?(plaintext).should be_false

      encrypted = Mongoid::EncryptedString.encrypt(plaintext)
      Mongoid::EncryptedString.is_encrypted?(encrypted).should be_true

      unencrypted = Mongoid::EncryptedString.decrypt(encrypted)
      Mongoid::EncryptedString.is_encrypted?(unencrypted).should be_false
    end

  end
end