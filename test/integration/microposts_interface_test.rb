require "test_helper"

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)  
  end
  
  test "Micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    #invalid submission
    assert_no_difference 'Micropost.count' do
      post micropost_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'
    #valid submission
    content = "This micropost really ties the room together"
    assert_difference 'Micropost.count', 1 do
      post micropost_path, params: { micropost: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    #delete post
    assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    #visit difference user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', { text: 'delete', count: 0 }
  end
end
