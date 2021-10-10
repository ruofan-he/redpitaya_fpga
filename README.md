# redpitaya_fpga
## command
### create vivado project
```
vivado -mode batch -source red_pitaya_vivado_project_Z10.tcl
```

### build fpga project
```
vivado -mode batch -source red_pitaya_vivado_Z10.tcl
```

## environment
下記推奨
```
vivado 2020.1
(ip/systemZ10.tc. systemブロックデザイン生成スクリプトの生成)
```

## ブロックデザイン追加
ブロックデザインをtcl出力し(例`users_bd.tcl`など)、適当なところにおく。それと同時にuser_bd.tclに該当tclの実行文を追加する。
```
source users_bd.tcl
generate_target all [get_files    users_bd.bd]
```