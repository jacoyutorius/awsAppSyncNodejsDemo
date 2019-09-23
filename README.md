# awsAppSyncNodejsDemo

Node.js から AppSync で GraphQL を実行するサンプル。

```bash
$ aws appsync get-graphql-api --api-id #{API_ID}
{
    "graphqlApi": {
        "apiId": "#{API_ID}",
        "arn": "arn:aws:appsync:ap-northeast-1:************:apis/#{API_ID}",
        "name": "BackBarAPI",
        "authenticationType": "API_KEY",
        "uris": {
            "GRAPHQL": "https://**************************.appsync-api.ap-northeast-1.amazonaws.com/graphql"
        }
    }
}
```

## dev in local

```
export DYNAMODB_ENDPOINT=http://localhost:8002
docker-compose up
bundle install
bundle exec ruby migration/create_backbar.rb
bundle exec ruby migration/seed.rb
```

|                |                             |
| :------------- | :-------------------------- |
| DynamoDB local | http://localhost:8002/shell |
| DynamoDB Admin | http://localhost:8000/      |

## result

```bash
$ node index.js
results of query:  { data:
   { queryBackbarsByGsiKeywords: { items: [Array], __typename: 'BackbarConnection' } },
  loading: false,
  networkStatus: 7,
  stale: false }
```

## ref

https://docs.aws.amazon.com/ja_jp/appsync/latest/devguide/building-a-client-app-node.html
