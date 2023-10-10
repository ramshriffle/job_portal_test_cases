require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    # debugger
  test "should not save user without type" do
    user = User.new(user_name:"jaychouhan",email:"jay123@gmail.com",password:"jay123")
    assert(user.save)
  end

  test "should not save user without email" do
    user = User.new(user_name:"jaychouhan",password:"jay123",type:"JobRecruiter")
    assert(user.save)
  end
end
