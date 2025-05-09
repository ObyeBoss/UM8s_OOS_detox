#!/system/bin/sh

mf() {
  local src_dir="$1"
  local target_dir="$2"
  [ ! -d "$src_dir" ] && return
  find "$src_dir" -type f | while read -r file; do
    rel_path="${file#$src_dir}"; target_file="$target_dir$rel_path"; mount -o ro,bind "$file" "$target_file"
  done
}

for partition in /my_product /my_region /my_stock /data; do
  partition_name="${partition#/}"; src_dir="$MODDIR/$partition_name"; target_dir="/$partition_name"; mf "$src_dir" "$target_dir"
done