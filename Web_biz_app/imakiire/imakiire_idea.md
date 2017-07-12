# web_en
- 検索機能の実装案, Userの検索の例. 他のモデルでも応用可. 

# 実装中のDBに対応したバージョン, 前のは色々おかしかったので削除

### モデル側

```ruby:user.rb
class User < ApplicationRecord
  def self.search(name, profile)
    user_ids = [] # 検索でヒットしたユーザーのidを格納する配列
    
    #入力がある場合とない場合で分ける
    if name.presence
    #入力文字列を空白で区切ってリストに格納
      patterns = name.split(/[ , ]/)
      sql_body = ''
    
      #SQL文を作成する
      patterns.each do |pattern|
        sql_body += ' and ' unless sql_body.blank?
        sql_body += "name like '%#{pattern}%' "
      end
      sql = "select * from users where #{sql_body} order by id desc"
    
    #find_by_sqlで条件を満たすユーザーを取得し、それらのidを取得する
      user_ids << User.find_by_sql(sql).map(&:id)
    end
  
  # profileについても同様の処理を行う
  
    if profile.presence
      #入力文字列を空白で区切ってリストに格納
      patterns = profile.split(/[ , ]/)
      sql_body = ''
  
      #SQL文を作成する
      patterns.each do |pattern|
        sql_body += ' and ' unless sql_body.blank?
        sql_body += "profile like '%#{pattern}%' "
      end
      sql = "select * from users where #{sql_body} order by id desc"
  
      # find_by_sqlで条件を満たすユーザーを取得し、それらのidをusers_idsに追加する
      user_ids << User.find_by_sql(sql).map(&:id)
    end

    # 入力がなかった場合と検索対象がゼロだった場合は全てのユーザーを返す, それ以外の場合はヒットしたユーザーを返す
    if name.presence or profile.presence
      user_ids.flatten!
      where(:id => user_ids)
    else
      User.all
    end
  end  
end

 ```


### ビュー側
```ruby:index.html.erb
<%= form_tag users_path, method: "get" do %>
  <%= search_field_tag :username %>
  <%= search_field_tag :profile %>
  <%= submit_tag("submit") %>
<% end %
```

### コントローラー側
```ruby:index.html.erb
def index
  @users = User.search(params[:username], params[:profile])
end
```


# Twitterのフォロワー取得関数, エラー処理無し

```ruby:twitter-follower-getter.rb
require "nokogiri"
require "open-uri"

def follower_getter(id)
  url = "https://twitter.com/#{id}"
  doc = Nokogiri::HTML(open(url))
  follower = doc.xpath("//li[@class='ProfileNav-item ProfileNav-item--followers']/a/span[@class='ProfileNav-value']").attribute("data-count").value
  return follower
end
```
