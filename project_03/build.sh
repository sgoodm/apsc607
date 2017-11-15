#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
cp latex/report.pdf sgoodm_apsc607_report.pdf

output="sgoodm_apsc607_project03.zip"
rm $output
zip -r  $output .


