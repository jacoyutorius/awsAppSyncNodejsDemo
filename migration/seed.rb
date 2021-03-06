require 'aws-record'
require_relative './backbar.rb'
Aws.config.update(endpoint: ENV['DYNAMODB_ENDPOINT']) if ENV.has_key?('DYNAMODB_ENDPOINT')

data = [
	{
		name: 'キューバ・リブレ',
		keywords: 'コーラ/ラム/ロング/キューバリバー/ラムコーク',
		material: 'ラム45ml、ライム・ジュース10ml、コーラ ＝ 95ml、カットしたライムの実1個',
		recepe: '氷を入れたグラスに、ラムとライム・ジュースを注ぐ。コーラを注ぎ、軽くステアする。カットライムをグラス飾る。'
	},
	{
		name: 'ゴッド・ファーザー',
		keywords: 'ウイスキー/甘め/強い',
		material: 'ウイスキー 45ml、アマレット 15ml',
		recepe: 'ウイスキー、アマレットを、氷を入れたオールド・ファッションド・グラスに入れステアする。'
	},
	{
		name: 'ニューヨーク',
		keywords: 'ウィスキー/バーボン',
		material: 'ライ・ウイスキー或いはバーボン・ウイスキー 45ml、ライム・ジュース 15ml、グレナデン・シロップ - 1/2tsp、砂糖 1tsp、オレンジ・ピール',
		recepe: '材料を全てシェイカーに入れシェイクする。カクテル・グラスに注ぎ、オレンジ・ピールを絞る。',
		tips: 'アメリカ合衆国の都市・ニューヨークに由来。'
	},
	{
		name: 'マンハッタン',
		keywords: 'マリリン・モンロー/マンハッタン/ウィスキー/バーボン/ベルモット',
		material: 'ライ・ウイスキー、バーボン・ウイスキーまたはカナディアン・ウイスキー2、スイート・ベルモット 1、アンゴスチュラ・ビターズ 数滴',
		recepe: '材料をミキシング・グラスに入れてステアする。カクテル・グラスに注いでマラスキーノ・チェリーを飾る。',
		tips: 'マンハッタンに落ちる夕日をイメージしたカクテルです。',
	},
	{
		name: 'アラウンド・ザ・ワールド',
		keywords: 'ジン/パイナップル/ミント',
		material: 'ドライ・ジン 40ml、パイナップルジュース、15ml、ペパーミント - 5ml',
		recepe: '',
		tips: '行機の世界一周路線の運航開始の際に行われた創作カクテルコンクールの優勝作品',
	},
	{
		name: 'ヴェスパー・マティーニ',
		keywords: '007/カジノ・ロワイヤル/イアン・フレミング/マティーニ/ジェームズ・ボンド/ヴェスパー・リンド/ボンド・ガール',
		material: 'ドライ・ジン 90ml、ウォッカ 30ml、キナ・リレ 15ml、レモンの果皮',
		recepe: 'キナ・リレの代わりにリレ・ブランを用いてシェイクし、深めのシャンパン・グラスに注ぎ、ラセン状に剥いたレモンの皮を入れる。',
		tips: '小説『007 カジノ・ロワイヤル』でイアン・フレミングが考案',
	},
	{
		name: 'シンガポール・スリング',
		keywords: 'シンガポール/ラッフルズ・ホテル/ジン/ブランデー/レモン',
		material: 'ドライジン 45 ml、チェリー・ブランデー 15 ml、レモン・ジュース 20 ml、砂糖 1 tsp、ソーダ水、マラスキーノ・チェリー',
		recepe: 'ソーダ水以外の材料をシェークし、氷を入れたタンブラーに注ぐ。ソーダ水を満たし、チェリーを飾る。また、チェリーブランデーはシェークせず、最後にグラスに沈める作りかたもある。',
		tips: 'シンガポール生まれの名カクテル。1915年、シンガポールのラッフルズ・ホテルのロングバーのバーテンダーであった、Ngiam Tong Boonが最初に作ったのが始まりである。',
	},
	{
		name: 'ジン・ライム',
		keywords: 'ジン/ライム',
		material: 'ドライ・ジン 全量の3/4、ライム・ジュース 全量の1/4',
		recepe: '材料はシェイクせずオン・ザ・ロックのスタイルにする。すなわち、氷を入れたオールド・ファッションド・グラスに、まずドライ・ジンを、次にライム・ジュース注ぎ、ステアすることで完成となる。',
		tips: 'シェイクするとギムレットという別のカクテルとなる。',
	},
	{
		name: 'トム・コリンズ',
		keywords: 'ジン/レモン/ジョン・コリンズ',
		material: 'オールド・トム・ジン 60 ml、レモンジュース - 15〜20 ml、砂糖 2tsp、炭酸水適量、レモン・スライス、マラスキーノ・チェリー',
		recepe: 'シェイカーにジン、レモンジュース、砂糖と氷を入れ、シェイクする。上記を氷を入れたコリンズ・グラス（通常のロングドリンクに使われるのは8オンスタンブラーだが、10オンス〜14オンス入る、より背が高く細長いグラス）に注ぎ、炭酸水を加え、軽くステアする。カクテルピックに刺したレモン・スライスとマラスキーノ・チェリーを飾る。',
		tips: '19世紀終わり頃、イギリスでジョン・コリンズという人物が最初に作ったと言われている',
	},
	{
		name: 'マティーニ',
		keywords: 'ジン/ベルモット',
		material: 'ドライ・ジン 45ml、ドライ・ベルモット 15ml',
		recepe: '上記材料をミキシング・グラスに入れてステアする。カクテル・グラスに注ぎ、オリーブを飾る。',
		tips: '好みで上記材料にオレンジ・ビターズ数滴を加えたり、供する前にレモンの果皮を絞り加えることもある。',
	},
	{
		name: 'テキーラ・サンライズ',
		keywords: 'テキーラ/オレンジ/ローリング・ストーンズ/ミック・ジャガー',
		material: 'テキーラ 45ml、オレンジ・ジュース 適量、グレナディン・シロップ 2tsp',
		recepe: '',
		tips: 'ローリング・ストーンズのボーカリスト、ミック・ジャガーが1972年のメキシコ公演で絶賛、メキシコ滞在中にかなりの量を飲んだ事によって知られるようになった。',
	},
	{
		name: 'オリンピック',
		keywords: 'ブランデー/オレンジ/キュラソー/フランス',
		material: 'ブランデー ： オレンジ・キュラソー ： オレンジ・ジュース ＝ 1：1：1',
		recepe: 'ブランデーとオレンジキュラソーとオレンジジュースをシェークして、カクテル・グラスに注げば完成である。オレンジジュースは、その場でオレンジを絞ったものを使用するのがベストであるが、市販のジュースを用いても良い。',
		tips: 'フランス産まれのカクテルで、「ホテル・リッツ・パリ」で作られたとされている。1900年にパリで開催された第2回オリンピックを記念して作られた。',
	},
	{
		name: 'サイドカー',
		keywords: 'ブランデー/レモン/ホワイトキュラソー',
		material: 'ブランデー 30ml、ホワイト・キュラソー 15ml、レモン・ジュース 15ml',
		recepe: 'シェイカーに材料を全て入れる。シェイクし、カクテル・グラスに注ぐ。',
		tips: '第一次世界大戦の最中、サイドカーに乗って退却するフランス軍将校が、レモンをかじりながらキュラソー・ブランデーを飲み続け、追手からの恐怖を紛らわせた故事により生まれた。',
	},
	{
		name: 'X・Y・Z',
		keywords: 'ラム/コアントロー/レモン',
		material: 'ラム：コアントロー：レモン・ジュース = 2：1：1',
		recepe: 'ラム、コアントロー、レモンジュースをシェークし、カクテル・グラス（容量75〜90ml程度）に注げば完成である。なお、レモン・ジュースは、その場でレモンを絞ったものを使用するのがベストであるが、市販のジュースを用いても良い。',
		tips: '「これ以上のものは作れない究極のカクテル」という意味合いが込められている',
	},
	{
		name: 'ピニャ・コラーダ',
		keywords: '村上春樹/ラム/ココナッツ/パイナップル/ダンス・ダンス・ダンス/甘め',
		material: 'ライト・ラム 30ml、ココナッツ・ミルク 45ml、パイナップル・ジュース 80ml',
		recepe: '材料を氷とシェイカーに入れ、シェイクしたら、クラッシュド・アイスを入れたグラスに注ぐ。なお、グラスの縁にはパイナップルを飾る。',
		tips: '村上春樹の『ダンス・ダンス・ダンス』にて、ハワイで主人公が飲むのがこのカクテル',
	},
	{
		name: 'ニコラシカ',
		keywords: 'ニコラシカ',
		material: 'ブランデー 適量、レモン・スライス 1枚、砂糖 適量',
		recepe: 'まず、リキュール・グラス（容量30ml程度）に、ブランデーを8〜9分目ほど注ぐ。レモンを輪切りにする。この時、レモンは、砂糖を乗せるために、その重みに耐えられるよう、やや厚めにスライスする[。グラスに蓋をするようにレモンの輪切りを置き、その上に砂糖を乗せる。砂糖は、山型に適量乗せれば良いが、上白糖のように固まりやすい砂糖を使用するのであれば、山型に整形するのが一般的。',
		tips: ''
	}
]

data.each do |row|
	row[:updated_at] = Time.now
	p Backbar.update(row)
end

# query = Backbar.query(
#   key_condition_expression: "#H = :h AND #R > :r",
#   filter_expression: "contains(#KEYWORDS, :keywords)",
#   expression_attribute_names: {
#     "#KEYWORDS" => "keywords"
#   },
#   expression_attribute_values: {
#     # ":h" => "123456789uuid987654321",
#     # ":r" => 100,
#     ":b" => "some substring"
#   }
# )
#
# # You can enumerate over your results.
# query.each do |r|
#   puts "UUID: #{r.uuid}\nID: #{r.id}\nBODY: #{r.body}\n"
# end

scan = Backbar.scan(
  filter_expression: "contains(#K, :k)",
  expression_attribute_names: {
    '#K' => 'keywords'
  },
  expression_attribute_values: {
    ':k' => '村上'
  }
)

scan.each do |r|
	p "#{r.name} - #{r.material} - #{r.recepe} - #{r.keywords}"
end
