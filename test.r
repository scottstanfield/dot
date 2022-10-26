#!/usr/bin/env Rscript
library(data.table)
library(dot)


dt <- fread(dot('mapping.csv'))
print(dt)


print(dot('../iris.csv'))
print(dot('mapping.csv'))
print(dot('/home/scott/.zshrc'))
print(dot('~scott/.zshrc'))
print(dot('foo.csv'))
normalizePath(dot('../lib/utils.r'))

print("Trying three good source paths\n")
dot.source('../lib/utils.r')
dot.source('/home/scott/e9/radium/lib/utils.r')
dot.source('~scott/e9/radium/lib/utils.r')

printf("Trying three different file paths\n")
print(dot('../iris.csv'))
print(dot('mapping.csv'))
print(dot('./mapping.csv'))
print(dot('doesnothappen'))

dt <- fread(dot('../iris.csv'))
print(dt)

