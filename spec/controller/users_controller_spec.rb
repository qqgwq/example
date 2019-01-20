require 'rails_helper'
require 'pry'

RSpec.describe UsersController, type: :controller do
  before(:each) do 
    @user = User.create!(:name => 'gwq', :email => 'gxz@qq.com', :password => 'gwq1995')
  end
  context 'create user' do
    it 'should create success' do
      post :create, :params => {:user => {:name => 'gy', :email => 'gy@qq.com', :password => 'gwq1995'}}
      expect(response).to be_success
    end
  end
  it "update user" do
    sign_in @user
    put :update, :params => {:id => @user.id, :user => {:name => 'gb', :email => 'gb@qq.com', :password => 'gwq1995'}}
    expect(response.status).to eq(302)
  end

  it 'delete user' do
    sign_in @user
    delete :destroy, :params => {:id => @user.id}
    expect(response).to redirect_to(root_path)
  end

  it "like user" do
    sign_in @user
    post :like, :params => {:id => @user.id }, xhr: true
    @user.reload
    expect(@user.like.count).to eq(1)
  end

  it "dislike user" do
    sign_in @user
    post :dislike, :params => {:id => @user.id }, xhr: true
    @user.reload
    expect(@user.like.count).to eq(0)
  end
end