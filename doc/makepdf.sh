#!/bin/bash

cd $(dirname $0)

echo "Making ELK document ..."
cd ELK_document
pandoc -s -o ELK_document.tex chapter*.md
pandoc -s -o ../ELK_document.pdf chapter*.md

