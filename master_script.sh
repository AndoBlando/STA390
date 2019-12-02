#!/bin/bash
declare -i numproc=25 # number of parallel processes to run
declare -i numiter=50000 # total number of iterations 
for (( count=1; count<=$numproc; count++ )) # first batch of parallel processing with matlab script gen_obs.m
do nohup matlab -singleCompThread -nojvm -r "gen_obs($1,$count,$numproc,$numiter); exit;" >gen_results"${count}".txt 2>&1 &
done
wait # must wait for all processes to finish before next batch of parallel processing
for (( count=1; count<=$numproc; count++ )) # second batch of parallel processing, now with bootstrap.m
do nohup matlab -singleCompThread -nojvm -r "bootstrap($1,$count,$numproc,$numiter); exit;" >boot_results"${count}".txt 2>&1 &
done
wait # again must wait for all to finish
matlab -r "combine_results($1,$numproc,$numiter); exit;" >results.txt 2>&1 # combine results of previous scripts into final answer
echo "done." | mail -s "case $1 done." ablandino@ucdavis.edu # send an email to me once it's done
wait
# rm -f clt_stat*  # the scripts above write results to file, so we can remove them after using rm 
# rm -f bootmat*
# rm -f pop_stat*
# rm -f QuEST_error*
# rm -f khat_vec*
# rm -f lambdamat*
# rm -f oraclemat*
# rm -f testmat*
# rm -f bias_hat*
# rm -f gen_results*
# rm -f boot_results*
