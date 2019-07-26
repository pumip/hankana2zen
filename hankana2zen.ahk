
; 半角カナを全角カナに置換する関数
hankana2zen(str, replace_kigou:=false)
{

	Ifnotexist, %A_scriptdir%\lib\hankana_list.csv
		throw "半角カナ一覧ファイルhankana_list.csvを" . A_scriptdir . "\lib\フォルダに配置してください"
		
	arr_list_kana	:=[]
	arr_list_kigou	:=[]
	loop, read, %A_scriptdir%\lib\hankana_list.csv
	{
		arr_row		:=strsplit(A_LoopReadLine, ",")
		if (arr_row[3] = "kigou") {
			arr_list_kigou.push({"pattern": arr_row[1], "replace": arr_row[2]})
		} else {
			arr_list_kana.push({"pattern": arr_row[1], "replace": arr_row[2]})
		}
	}
	
	For, key, val in arr_list_kana {
		str	:=Regexreplace(str, "" . val.pattern . "", "" . chr(val.replace) . "")
	}
	if (replace_kigou) {
		For, key, val in arr_list_kigou {
			str	:=Regexreplace(str, "" . val.pattern . "", "" . chr(val.replace) . "")
		}
	}
	return str
}
return
