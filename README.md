### 出来ること
- users_data.json内の各ユーザデータをGoogleSpreadSheetに書き込んでいく

### 参考資料
- [OAuth ウェブ クライアント ID を作成する](https://support.google.com/workspacemigrate/answer/9222992?hl=ja)

### 追加ファイルする必要のあるファイル
```
// config.json
{                                                                                                                                                                                                       
 "client_id": "~~~~~~.apps.googleusercontent.com",
 "client_secret": "~~~~"
}
```

### 追加するGem
```
gem install google_drive
```

### 実行コマンド
```
ruby spread_csv.rb スプレッドシートのURL スプレッドシートのタブ名
// ex: ruby spread_csv.rb https://docs.google.com/spreadsheets~~~~~~=0 sheet1
```

### コマンド実行後
![image](https://user-images.githubusercontent.com/57279856/113518201-cc12ac00-95bf-11eb-90c2-e4666acb21ad.png)
