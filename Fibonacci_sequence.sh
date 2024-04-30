#!/bin/bash
result=0
func(){
  if [[ $1 == 1 || $1 == 2 ]];then
    result=1
  else
    result=$((   $(func $(($1-1))) + $(func $(($1-2)))   ))
  fi
echo ${result}
}
func $1 
