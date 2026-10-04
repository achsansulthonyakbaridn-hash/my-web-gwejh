#!/usr/bin/env bash
# Isi graph 1 tahun ke belakang. Jalanin SEKALI di Git Bash / WSL / Linux / Mac(brew coreutils: gdate).
# Pemakaian: ./backfill.sh 365
set -e
DAYS=${1:-365}
for i in $(seq "$DAYS" -1 0); do
  d=$(date -u -d "-$i day" +"%Y-%m-%dT12:00:00+0000")
  n=$(( RANDOM % 8 + 1 ))          # 1-8 commit/hari => warna hijau beda-beda
  for j in $(seq "$n"); do
    echo "$d #$j" >> activity.log
    git add activity.log
    GIT_AUTHOR_DATE="$d" GIT_COMMITTER_DATE="$d" git commit -qm "update $d #$j"
  done
done
echo "Selesai. Sekarang: git push -u origin main"
