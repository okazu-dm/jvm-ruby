# jvm-ruby
Ruby実装のJVM

現在、sampleに置かれている `helloworld.java` をjavacにかけて得られるクラスファイルをparseできる程度の完成度。

# 動作確認
```sh
cd sample
./do_javap.sh
```

でHelloWorld classの情報が `sample.txt` に吐かれる。

あとはこれと以下のコマンドの結果を見比べてみる
```sh
ruby main.rb ./sample/HelloWorld.class   
```

まだparseしかできないのでclassファイルの実行はできない