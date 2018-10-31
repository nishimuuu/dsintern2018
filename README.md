# ml-templates

夏インターンで説明したコードたちです

## Features

- オレオレDockerイメージを作る
- SageMakerでオレオレDockerイメージを使う
  - SageMakerのAPIデプロイ
- AWS BatchでオレオレDockerイメージを使って処理を定期的にする

## Requirement

- docker
- terraform
- direnv
- homebrew
- homebrew cask
- pip

## つかいかた

### 依存を解決する

`scripts/bootstrap`

### Docker

#### イメージのビルド

`scripts/build`

#### 既存イメージのプル

`scripts/pull-image`

#### イメージのプッシュ

`scripts/push-image`

### ローカルでJupyter labを起動

`scripts/jupyter`

### SageMaker

#### インスタンスを作成

`scripts/create-notebook-instance`

#### インスタンスを起動

`scripts/start-notebook-instance`


#### インスタンスを停止

`scripts/stop-notebook-instance`

#### インスタンスを削除

`scripts/delete-notebook-instance`

#### Jupyter notebookへアクセス

`scripts/open-notebook`

## Author

[@nishimuuuuuu](https://twitter.com/nishimuuuuuu)

## License

[MIT](http://b4b4r07.mit-license.org)

