#!/bin/bash

# 使用说明
# 1. export ROCBLAS_LAYER=3
# 2. cat *.log | grep rocblas-bench | sort -n | uniq > gemm_size.log
# 3. ./extract_gemm.sh gemm_size.log 
# 4. 将NN,NT,TN,TT的log中size放入对应的训练yaml中

cat $1 | grep  gemm_ex \
 | grep "transposeA N --transposeB N" \
 | awk -F ' -m ' '{print $2}' \
 | awk -F ' -n ' 'OFS="," {print $1,$2}' \
 | awk -F ' -k ' 'OFS="," {print $1,$2,$3}' \
 | awk '{$2=null;print $1}' \
 | awk -F, '{$3="1,"$3; print}' \
 | awk '{OFS=","} {print $1,$2,$3}' \
 | sed 's/$/]/g' | sed 's/^/- Exact: [/g' > NN.log

cat $1 | grep  gemm_ex \
 | grep "transposeA N --transposeB T" \
 | awk -F ' -m ' '{print $2}' \
 | awk -F ' -n ' 'OFS="," {print $1,$2}' \
 | awk -F ' -k ' 'OFS="," {print $1,$2,$3}' \
 | awk '{$2=null;print $1}' \
 | awk -F, '{$3="1,"$3; print}' \
 | awk '{OFS=","} {print $1,$2,$3}' \
 | sed 's/$/]/g' | sed 's/^/- Exact: [/g' > NT.log

cat $1 | grep  gemm_ex \
 | grep "transposeA T --transposeB N" \
 | awk -F ' -m ' '{print $2}' \
 | awk -F ' -n ' 'OFS="," {print $1,$2}' \
 | awk -F ' -k ' 'OFS="," {print $1,$2,$3}' \
 | awk '{$2=null;print $1}' \
 | awk -F, '{$3="1,"$3; print}' \
 | awk '{OFS=","} {print $1,$2,$3}' \
 | sed 's/$/]/g' | sed 's/^/- Exact: [/g' > TN.log

cat $1 | grep  gemm_ex \
 | grep "transposeA T --transposeB T" \
 | awk -F ' -m ' '{print $2}' \
 | awk -F ' -n ' 'OFS="," {print $1,$2}' \
 | awk -F ' -k ' 'OFS="," {print $1,$2,$3}' \
 | awk '{$2=null;print $1}' \
 | awk -F, '{$3="1,"$3; print}' \
 | awk '{OFS=","} {print $1,$2,$3}' \
 | sed 's/$/]/g' | sed 's/^/- Exact: [/g' > TT.log



cat $1 | grep  gemm_strided_batched  \
 | grep "transposeA N --transposeB N" \
 | awk -F ' --batch_count ' 'OFS="," {print $2}' \
 | awk '{print $1}' > batchcount.log
cat $1 | grep  gemm_strided_batched \
 | grep "transposeA N --transposeB N" \
 | awk -F ' -m ' '{print $2}' \
 | awk -F ' -n ' 'OFS="," {print $1,$2}' \
 | awk -F ' -k ' 'OFS="," {print $1,$2,$3}' \
 | awk '{OFS=" "} {print $1}' \
 | sed 's/$/,/g' > tmp1.log
paste -d "" tmp1.log batchcount.log > tmp2.log
cat tmp2.log \
 | awk -F ',' 'OFS="," {print $1,$2,$4,$3}' \
 | sed 's/$/]/g' | sed 's/^/- Exact: [/g' >> NN.log
 
cat $1 | grep  gemm_strided_batched  \
 | grep "transposeA N --transposeB T" \
 | awk -F ' --batch_count ' 'OFS="," {print $2}' \
 | awk '{print $1}' > batchcount.log
cat $1 | grep  gemm_strided_batched \
 | grep "transposeA N --transposeB T" \
 | awk -F ' -m ' '{print $2}' \
 | awk -F ' -n ' 'OFS="," {print $1,$2}' \
 | awk -F ' -k ' 'OFS="," {print $1,$2,$3}' \
 | awk '{OFS=" "} {print $1}' \
 | sed 's/$/,/g' > tmp1.log
paste -d "" tmp1.log batchcount.log > tmp2.log
cat tmp2.log \
 | awk -F ',' 'OFS="," {print $1,$2,$4,$3}' \
 | sed 's/$/]/g' | sed 's/^/- Exact: [/g' >> NT.log

cat $1 | grep  gemm_strided_batched  \
 | grep "transposeA T --transposeB N" \
 | awk -F ' --batch_count ' 'OFS="," {print $2}' \
 | awk '{print $1}' > batchcount.log
cat $1 | grep  gemm_strided_batched \
 | grep "transposeA T --transposeB N" \
 | awk -F ' -m ' '{print $2}' \
 | awk -F ' -n ' 'OFS="," {print $1,$2}' \
 | awk -F ' -k ' 'OFS="," {print $1,$2,$3}' \
 | awk '{OFS=" "} {print $1}' \
 | sed 's/$/,/g' > tmp1.log
paste -d "" tmp1.log batchcount.log > tmp2.log
cat tmp2.log \
 | awk -F ',' 'OFS="," {print $1,$2,$4,$3}' \
 | sed 's/$/]/g' | sed 's/^/- Exact: [/g' >> TN.log

cat $1 | grep  gemm_strided_batched  \
 | grep "transposeA T --transposeB T" \
 | awk -F ' --batch_count ' 'OFS="," {print $2}' \
 | awk '{print $1}' > batchcount.log
cat $1 | grep  gemm_strided_batched \
 | grep "transposeA T --transposeB T" \
 | awk -F ' -m ' '{print $2}' \
 | awk -F ' -n ' 'OFS="," {print $1,$2}' \
 | awk -F ' -k ' 'OFS="," {print $1,$2,$3}' \
 | awk '{OFS=" "} {print $1}' \
 | sed 's/$/,/g' > tmp1.log
paste -d "" tmp1.log batchcount.log > tmp2.log
cat tmp2.log \
 | awk -F ',' 'OFS="," {print $1,$2,$4,$3}' \
 | sed 's/$/]/g' | sed 's/^/- Exact: [/g' >> TT.log

rm -rf batchcount.log tmp1.log tmp2.log
