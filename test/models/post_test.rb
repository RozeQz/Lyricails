require "test_helper"

class PostTest < ActiveSupport::TestCase
  fixtures :users

  setup do 
    @title = Faker::Music.band + " " + Faker::Music::RockBand.song
    @lyrics = Faker::Quote.famous_last_words
    @user_id = User.last.id 
    puts @title
    puts @lyrics
    puts @user_id
    puts User.find_by(id: @user_id).username
  end

  test 'check that empty input cannot be saved' do
    post = Post.new
    refute post.save
  end

  test 'check that post with no attachment cannot be saved' do
    post = Post.new( title: @title, lyrics: @lyrics, user_id: @user_id)
    refute post.save
  end

  test 'check that post with audio attachment should be saved' do
    post = Post.new( title: @title, lyrics: @lyrics, user_id: @user_id)
    post.music.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'audio', 'GunsNRoses-ThisILove.mp3'
        )
      ),
      filename: 'GunsNRoses-ThisILove.mp3',
      content_type: 'audio/mp3'
    )
    assert post.save
    assert Post.find_by(title: @title)
  end

  test 'check that post with audio attachment but without lyrics should be saved' do
    post = Post.new( title: @title, user_id: @user_id)
    post.music.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'audio', 'GunsNRoses-ThisILove.mp3'
        )
      ),
      filename: 'GunsNRoses-ThisILove.mp3',
      content_type: 'audio/mp3'
    )
    assert post.save
    assert Post.find_by(title: @title)
  end
end

