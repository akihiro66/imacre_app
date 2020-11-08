require 'csv'

CSV.generate do |csv|
  # 1行目にラベルを追加
  csv_column_labels = %w(名前 説明 作った人 作り方参照用URL\
                         コツ・ポイント 制作時間[時間] 人気度 材料費[円] 最初に作った日時\
                         材料1の名前 材料1の数量 材料2の名前 材料2の数量\
                         材料3の名前 材料3の数量 材料4の名前 材料4の数量\
                         材料5の名前 材料5の数量 材料6の名前 材料6の数量\
                         材料7の名前 材料7の数量 材料8の名前 材料8の数量\
                         材料9の名前 材料9の数量 材料10の名前 材料10の数量)
  csv << csv_column_labels
  # 各昨銀のカラム値を追加
  current_user.feed.each do |production|
    # まず材料以外のカラムを追加
    csv_column_values = [
      production.name,
      production.description,
      production.user.name,
      production.reference,
      production.tips,
      production.required_time,
      production.popularity,
      production.material,
      production.created_at.strftime("%Y/%m/%d(%a)")
    ]
    # 材料の数(number_of_materials)を特定
    # 初期値を9にしておき、nameが空の材料が見つかったらその配列番号に置き換える
    number_of_materials = 9
    production.materials.each_with_index do |ing, index|
      if ing.name.empty?
        number_of_materials = index
        break
      end
    end
    # 材料の数だけカラムを追加する
    i = 0
    while i <= number_of_materials
      csv_column_values.push(production.materials[i].name, production.materials[i].amount)
      i += 1
    end
    # 最終的なcsv_column_valuesをcsvのセルに追加
    csv << csv_column_values
  end
end
