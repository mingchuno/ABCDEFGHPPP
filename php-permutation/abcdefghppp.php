<?php
function test($a, $b, $c, $d, $e, $f, $g, $h, $p){
  return (
    ($a*10 + $b) - ($c*10 + $d) == ($e * 10 + $f) &&
    ($e*10 + $f) + ($g*10 + $h) == $p * 100 + $p * 10 + $p
  );
}

//brute force use unique permutations
//http://stackoverflow.com/questions/18935813/efficiently-calculating-unique-permutations-in-a-set
function permuteUnique($items, $perms = [], &$return = []) {
  if (empty($items)) {
    $return[] = $perms;
  } else {
    sort($items);
    $prev = false;
    for ($i = count($items) - 1; $i >= 0; --$i) {
      $newitems = $items;
      $tmp = array_splice($newitems, $i, 1)[0];
      if ($tmp != $prev) {
        $prev = $tmp;
        $newperms = $perms;
        array_unshift($newperms, $tmp);
        permuteUnique($newitems, $newperms, $return);
      }
    }
    return $return;
  }
}

function brute_force(){
  //p = 1
  $permutations = permuteUnique([2,3,4,5,6,7,8,9]);
  foreach($permutations as $pm){
    if(test($pm[0],$pm[1],$pm[2],$pm[3],$pm[4],$pm[5],$pm[6],$pm[7], 1)){
      echo 'a=' . $pm[0] . ',b=' . $pm[1] . ',c=' . $pm[2] . ',d=' . $pm[3] . ',e=' . $pm[4] . ',f=' . $pm[5] . ',g=' . $pm[6] . ',h=' . $pm[7] . ',p=' . 1 . '<br>';
    }
  }
}

brute_force();
/*
a=8,b=6,c=5,d=4,e=3,f=2,g=7,h=9,p=1
a=9,b=5,c=2,d=7,e=6,f=8,g=4,h=3,p=1
a=8,b=5,c=4,d=6,e=3,f=9,g=7,h=2,p=1
*/