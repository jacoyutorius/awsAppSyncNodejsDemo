# awsAppSyncNodejsDemo

Node.js(lambda)から AppSync で GraphQL を実行するサンプル。

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

## result

```bash
$ node index.js
results of query:  { data:
   { queryBackbarsByGsiKeywords: { items: [Array], __typename: 'BackbarConnection' } },
  loading: false,
  networkStatus: 7,
  stale: false }
[ { name: 'トム・コリンズ',
    material:
     'オールド・トム・ジン 60 ml、レモンジュース - 15〜20 ml、砂糖 2tsp、炭酸水適量、レモン・スライス、マラスキーノ・チェリー',
    tips: '19世紀終わり頃、イギリスでジョン・コリンズという人物が最初に作ったと言われている',
    updated_at: '2019-02-05',
    __typename: 'Backbar' },
  { name: 'サイドカー',
    material: 'ブランデー 30ml、ホワイト・キュラソー 15ml、レモン・ジュース 15ml',
    tips:
     '第一次世界大戦の最中、サイドカーに乗って退却するフランス軍将校が、レモンをかじりながらキュラソー・ブランデーを飲み続け、追手からの恐怖を紛らわせた故事により生まれた。',
    updated_at: '2019-02-05',
    __typename: 'Backbar' },
  { name: 'シンガポール・スリング',
    material:
     'ドライジン 45 ml、チェリー・ブランデー 15 ml、レモン・ジュース 20 ml、砂糖 1 tsp、ソーダ水、マラスキーノ・チェリー',
    tips:
     'シンガポール生まれの名カクテル。1915年、シンガポールのラッフルズ・ホテルのロングバーのバーテンダーであった、Ngiam Tong Boonが最初に作ったのが始まりである。',
    updated_at: '2019-02-05',
    __typename: 'Backbar' },
  { name: 'X・Y・Z',
    material: 'ラム：コアントロー：レモン・ジュース = 2：1：1',
    tips: '「これ以上のものは作れない究極のカクテル」という意味合いが込められている',
    updated_at: '2019-02-05',
    __typename: 'Backbar' } ]

```
