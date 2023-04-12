List<Map<String, dynamic>> cards = [
  //カウンター
  {"name": "秘儀の否定 / Arcane Denial", "category": "カウンター", "quantity": 2},
  {
    "name": "計算された放逐 / Calculated Dismissal",
    "category": "カウンター",
    "quantity": 2
  },
  {"name": "徴用 / Commandeer", "category": "カウンター", "quantity": 0},
  {"name": "卑下 / Condescend", "category": "カウンター", "quantity": 2},
  {"name": "対抗呪文 / Counterspell", "category": "カウンター", "quantity": 0},
  {"name": "謎めいた命令 / Cryptic Command", "category": "カウンター", "quantity": 2},
  {"name": "まごつき / Discombobulate", "category": "カウンター", "quantity": 2},
  {"name": "解消 / Dissolve", "category": "カウンター", "quantity": 2},
  {"name": "夢の破れ目 / Dream Fracture", "category": "カウンター", "quantity": 2},
  {"name": "撃退 / Foil", "category": "カウンター", "quantity": 1},
  {"name": "邪魔 / Hinder", "category": "カウンター", "quantity": 2},
  {"name": "腹黒い意志 / Insidious Will", "category": "カウンター", "quantity": 2},
  {"name": "記憶の欠落 / Memory Lapse", "category": "カウンター", "quantity": 2},
  {"name": "精神的つまづき / Mental Misstep", "category": "カウンター", "quantity": 1},
  {"name": "誤算 / Miscalculation", "category": "カウンター", "quantity": 1},
  {"name": "交錯の混乱 / Muddle the Mixture", "category": "カウンター", "quantity": 0},
  {"name": "呪文変容 / Spell Shift", "category": "カウンター", "quantity": 2},
  {"name": "阻まれた希望 / Stymied Hopes", "category": "カウンター", "quantity": 2},
  //サーチ/濾過
  {"name": "遥かなる記憶 / Distant Memories", "category": "サーチ/濾過", "quantity": 2},
  {"name": "長期計画 / Long-Term Plans", "category": "サーチ/濾過", "quantity": 2},
  {"name": "商人の巻物 / Merchant Scroll", "category": "サーチ/濾過", "quantity": 0},
  {"name": "神秘の教示者 / Mystical Tutor", "category": "サーチ/濾過", "quantity": 2},
  {"name": "深遠の覗き見 / Peer Through Depths", "category": "サーチ/濾過", "quantity": 2},
  {"name": "シルンディの幻視 / Silundi Vision", "category": "サーチ/濾過", "quantity": 2},
  //ライブラリ操作
  {"name": "だまし / Bamboozle", "category": "ライブラリ操作", "quantity": 2},
  {"name": "渦巻く知識 / Brainstorm", "category": "ライブラリ操作", "quantity": 2},
  {"name": "有事対策 / Contingency Plan", "category": "ライブラリ操作", "quantity": 2},
  {"name": "夢での貯え / Dream Cache", "category": "ライブラリ操作", "quantity": 2},
  {"name": "索引 / Index", "category": "ライブラリ操作", "quantity": 2},
  {"name": "留意 / Mental Note", "category": "ライブラリ操作", "quantity": 2},
  {"name": "思案 / Ponder", "category": "ライブラリ操作", "quantity": 2},
  {"name": "先触れ / Portent", "category": "ライブラリ操作", "quantity": 2},
  {"name": "定業 / Preordain", "category": "ライブラリ操作", "quantity": 2},
  {"name": "狼藉 / Ransack", "category": "ライブラリ操作", "quantity": 2},
  {"name": "深遠の研究 / Research the Deep", "category": "ライブラリ操作", "quantity": 2},
  {"name": "血清の幻視 / Serum Visions", "category": "ライブラリ操作", "quantity": 2},
  {"name": "テイガムの策謀 / Taigam’s Scheming", "category": "ライブラリ操作", "quantity": 2},
  {"name": "時間の把握 / Telling Time", "category": "ライブラリ操作", "quantity": 4},
  {"name": "思考掃き / Thought Scour", "category": "ライブラリ操作", "quantity": 2},
  {"name": "計略の魔除け / Trickery Charm", "category": "ライブラリ操作", "quantity": 0},
  //ドロー
  {"name": "蓄積した知識 / Accumulated Knowledge", "category": "ドロー", "quantity": 4},
  {"name": "祖先の幻視 / Ancestral Vision", "category": "ドロー", "quantity": 1},
  {"name": "クルフィックスの指図 / Dictate of Kruphix", "category": "ドロー", "quantity": 2},
  {"name": "予感 / Foresee", "category": "ドロー", "quantity": 2},
  {"name": "偏った幸運 / Fortune's Favor", "category": "ドロー", "quantity": 2},
  {"name": "大慌ての棚卸し / Frantic Inventory", "category": "ドロー", "quantity": 0},
  {"name": "錯覚の伏兵 / Illusory Ambusher", "category": "ドロー", "quantity": 2},
  {"name": "瞑想 / Meditate", "category": "ドロー", "quantity": 1},
  {"name": "Mise / Mise", "category": "ドロー", "quantity": 3},
  {"name": "識者の誓い / Oath of Scholars", "category": "ドロー", "quantity": 2},
  {"name": "予報 / Predict", "category": "ドロー", "quantity": 2},
  {"name": "棚卸し / Take Inventory", "category": "ドロー", "quantity": 0},
  {"name": "テフェリーの細工箱 / Teferi's Puzzle Box", "category": "ドロー", "quantity": 1},
  {"name": "真実か詐話か / Truth or Tale", "category": "ドロー", "quantity": 2},
  {"name": "彼方の映像 / Visions of Beyond", "category": "ドロー", "quantity": 2},
  {"name": "意外な授かり物 / Windfall", "category": "ドロー", "quantity": 1},
  //バウンス
  {"name": "霊気渦竜巻 / Aetherspouts", "category": "バウンス", "quantity": 2},
  {"name": "霊気への抑留 / Anchor to the Aether", "category": "バウンス", "quantity": 2},
  {"name": "ブーメラン / Boomerang", "category": "バウンス", "quantity": 2},
  {"name": "時間づまり / Chronostutter", "category": "バウンス", "quantity": 2},
  {"name": "引き剥がし / Force Away", "category": "バウンス", "quantity": 2},
  {"name": "ゴーマゾア / Gomazoa", "category": "バウンス", "quantity": 2},
  {"name": "行方不明 / Gone Missing", "category": "バウンス", "quantity": 2},
  {"name": "変態 / Metamorphose", "category": "バウンス", "quantity": 2},
  {"name": "ナーセットの逆転 / Narset's Reversal", "category": "バウンス", "quantity": 2},
  {"name": "差し戻し / Remand", "category": "バウンス", "quantity": 2},
  {"name": "追い返し / Repel", "category": "バウンス", "quantity": 2},
  {"name": "排撃 / Repulse", "category": "バウンス", "quantity": 2},
  {"name": "撤回 / Rescind", "category": "バウンス", "quantity": 2},
  {"name": "神話送り / Spin into Myth", "category": "バウンス", "quantity": 2},
  {"name": "掃き飛ばし / Sweep Away", "category": "バウンス", "quantity": 2},
  {"name": "非実体化 / Unsubstantiate", "category": "バウンス", "quantity": 2},
  {"name": "航海の終わり / Voyage's End", "category": "バウンス", "quantity": 2},
  {"name": "渦巻沈め / Whirlpool Whelm", "category": "バウンス", "quantity": 2},
  {"name": "払いのけ / Whisk Away", "category": "バウンス", "quantity": 2},
  //クリーチャー操作/能力付与/スタッツ補正
  {
    "name": "目潰しのしぶき / Blinding Spray",
    "category": "クリーチャー操作/能力付与/スタッツ補正",
    "quantity": 2
  },
  {
    "name": "悪寒 / Crippling Chill",
    "category": "クリーチャー操作/能力付与/スタッツ補正",
    "quantity": 2
  },
  {
    "name": "空智の踊り / Dance of the Skywise",
    "category": "クリーチャー操作/能力付与/スタッツ補正",
    "quantity": 1
  },
  {
    "name": "凍氷砕 / Icy Blast",
    "category": "クリーチャー操作/能力付与/スタッツ補正",
    "quantity": 1
  },
  {
    "name": "理性のゲーム / Mind Games",
    "category": "クリーチャー操作/能力付与/スタッツ補正",
    "quantity": 2
  },
  {
    "name": "命令の光 / Ray of Command",
    "category": "クリーチャー操作/能力付与/スタッツ補正",
    "quantity": 2
  },
  {
    "name": "川の叱責 / River's Rebuke",
    "category": "クリーチャー操作/能力付与/スタッツ補正",
    "quantity": 2
  },
  {
    "name": "サファイアの魔除け / Sapphire Charm",
    "category": "クリーチャー操作/能力付与/スタッツ補正",
    "quantity": 2
  },
  //コピー
  {"name": "あまたの舞い / Dance of Many", "category": "コピー", "quantity": 2},
  {"name": "宿命的心酔 / Fated Infatuation", "category": "コピー", "quantity": 2},
  {"name": "複写作成 / Mimeofacture", "category": "コピー", "quantity": 2},
  {"name": "奪取の形態 / Supplant Form", "category": "コピー", "quantity": 1},
  {"name": "双つ術 / Twincast", "category": "コピー", "quantity": 2},
  //対象変更/奪取
  {"name": "霊気奪い / Aethersnatch", "category": "対象変更/奪取", "quantity": 2},
  {"name": "心盗み / Psychic Theft", "category": "対象変更/奪取", "quantity": 2},
  {"name": "移し変え / Redirect", "category": "対象変更/奪取", "quantity": 2},
  //全体除去
  {"name": "幻視の魔除け / Vision Charm", "category": "全体除去", "quantity": 2},
  //単体除去
  {"name": "水晶のしぶき / Crystal Spray", "category": "単体除去", "quantity": 2},
  {"name": "魔法改竄 / Magical hack", "category": "単体除去", "quantity": 4},
  {"name": "幻覚 / Mind Bend", "category": "単体除去", "quantity": 1},
  //手札墓地リセット
  {
    "name": "先細りの収益 / Diminishing Returns",
    "category": "手札墓地リセット",
    "quantity": 2
  },
  {"name": "永劫のこだま / Echo of Eons", "category": "手札墓地リセット", "quantity": 0},
  {"name": "時間の滝 / Temporal Cascade", "category": "手札墓地リセット", "quantity": 2},
  {"name": "時のらせん / Time Spiral", "category": "手札墓地リセット", "quantity": 0},
  {"name": "Timetwister / Timetwister", "category": "手札墓地リセット", "quantity": 0},
  //墓地回収
  {"name": "神秘の回復 / Mystic Retrieval", "category": "墓地回収", "quantity": 2},
  {"name": "復習 / Relearn", "category": "墓地回収", "quantity": 0},
  //ダンダーン(固定)
  {"name": "ダンダーン / Dandan", "category": "ダンダーン(固定)", "quantity": 10},
  //記憶の欠落(固定)
  {"name": "記憶の欠落 / Memory Lapse", "category": "記憶の欠落(固定)", "quantity": 8},
  //島(固定)
  {"name": "島 / Island", "category": "基本土地(固定)", "quantity": 32},
];

List<String> categories =
    {for (var card in cards) card["category"] as String}.toList();

const List<int> quantities = [0, 1, 2, 3, 4];

List<List<int>> cardAmountTemplates = [
  [3, 2, 1, 0, 8, 0, 6, 2, 2, 0, 4, 2, 14, 10, 8, 18],
  [5, 0, 1, 0, 10, 1, 4, 2, 1, 1, 3, 2, 14, 10, 8, 18],
  [1, 2, 2, 3, 8, 6, 4, 2, 0, 1, 0, 1, 14, 10, 8, 18],
];

// "カウンター",
// "クリーチャー操作/能力付与/スタッツ補正",
// "コピー",
// "サーチ/濾過",
// "ドロー",
// "バウンス",
// "ライブラリ操作",
// "手札墓地リセット",
// "全体除去",
// "対象変更/奪取",
// "単体除去",
// "墓地回収",
// "基本でない土地",
//ダンダーン(固定)
//記憶の欠落(固定)
//基本土地(固定)

List<String> stepTitles = [
  "STEP1 : 所持カード登録 ",
  "STEP2 : デッキ構成",
  "STEP3 : デッキ生成",
];

List<String> stepDescriptions = [
  "所持カードを登録してください。\n・Forgetful Fishに適したカードは初期セットされています。枚数のみ調整してください。\n・カテゴリは変更可能です。納得いかない場合は変更してください（ex.<思案/Ponder>のカテゴリを<ライブラリ操作> → <ドロー>）\n・初期リストにないカードを使いたい場合は＋ボタンから追加してください。",
  "デッキが80枚になるように、カテゴリごとに投入枚数を決定してください。\n・戦型に応じたテンプレートを用意しているのでご利用ください。\n・ダンダーン10枚、土地(基本土地＋基本でない土地)32枚で固定です。\n・記憶の欠落は、チェックボックスから8枚投入することも可能です。",
  "生成されたデッキ構成に従って、デッキを作ってください。さぁダンダーンバトルの始まりです。\n・デッキ構成が気に入らない場合は、再生成ボタンからやり直しが可能です。 ",
];
