#!/usr/bin/env perl -lp
# $l=y///c/2;s!.{$l}!$'=~/[$&]/;$&!e;$\-=(ord>96?96:38)-ord}{
# s!.{${\(y///c/2)}}!$'=~/[$&]/;$&!e;$\-=(ord>96?96:38)-ord}{
# s!.{${\(y///c/2)}}!$'=~/[$&]/;$&!e;$\-=(32&ord?96:38)-ord}{
# $\+=($_=ord s!.{${\(y///c/2)}}!$'=~/[$&]/;$&!re)-(32&$_?96:38)}{
# s!.{${\(y///c/2)}}!$'=~/[$&]/;$&!e;$\-=38+(32&ord&&58)-ord}{
  $l=y///c/2;s!.{$l}!$'=~/[$&]/;$&!e;$\-=(32&ord?96:38)-ord}{
