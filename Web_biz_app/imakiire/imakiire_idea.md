# web_en
- 検索機能の実装案, Userの検索の例. 他のモデルでも応用可. 

### モデル側
- searchメソッドとしてUser.rbに定義

```ruby:user.rb
def self.search(keyword, region, etc..)
  #入力がある場合とない場合で分ける
  if keyword
    #入力文字列を空白で区切ってand検索
    patterns = word.split(/[ , ]/)
    sql_body = ''
    
    #SQL文を作成する, 【column】のところには検索対象のカラムを入れる
    patterns.each do |pattern|
      sql_body += ' and ' unless sql_body.blank
      sqlbody += "【column】 like '%#{pattern}%' "
    end    
    sql = "select * from users where #{sql_body} order by id desc"
    
    #SQL文で条件を満たすユーザーを取得
    users = User.find_by_sql(sql)
  else
    #入力がない場合（検索を使ってない場合）
    User.all
  end
  #同様の処理を残りの引数に関しても行う。省略。
 end
 ```

### ビュー側
- indexページ以外でもいい. erbです.
- コントローラに :keyword, :region （仮）などの、検索対象のカラムに対応したパラメータを渡す
- 下の例はキーワード検索のみ

```ruby:index.html.erb
<%= form_tag users_path, method: "get" do %>
   <%= search_field_tag :keyword, nil %>
   <%= submit_tag("submit") %>
 <% end %>
```

### コントローラー側

```ruby:index.html.erb
def index
  @videos = Video.search(params[:keyword])
end
```

