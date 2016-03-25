<?php
/*************************
這題奧數題目，用咗一啲較數學嘅諗法去寫呢段code，
當然不用10^9 嘅looping  XD

有少少奧數經驗嘅人一看題目理應看到以下幾點︰
1) 兩個雙位數相加一定少於200，所以P一定是 1。
2) 因1已用，雙位數又不會0開頭，EF 一定是20－98 之間。
3) EF + GH = 111, 每個EF 只配對唯一一個 GH。
所以，第一階段只需要一個簡單的 20至98 的for loop。
再filter 走 E,F,G,H,P 有重覆的組合，
就進合第二階段。
4) C 不能是0，1 （P=1),
5) D 不能是0，因為咁會令 B=F。都不會是1（P=1)。
6) AB － CD = EF , 所以 AB 最少比EF 大23。 (22的話 C=D)
7) 同3) 每個AB 只配對到唯一一個CD。
所以，第二階段只需一個 EF+23 至 98 的 for loop。
最後filter 走重覆的組合，就可得出結果。
只用兩個for loop 就夠了。
*************************/


//P must be 111
//Find EF
for($EF=20;$EF<99;$EF++){
	$E = floor($EF / 10);
	$F = $EF % 10;
	if($E <> $F && $F <> 1){
		$used = array(1,$E,$F);
		//Find GH
		$GH = 111 - $EF;
		$G = floor($GH/10);
		
		if(!in_array($G, $used)){
			array_push($used,$G);
			$H = $GH % 10;
			if(!in_array($H,$used)){
				array_push($used,$H);
				for($AB = $EF+23;$AB<99;$AB++){
					$A = floor($AB / 10);
					$B = $AB % 10;
					if($A<>$B && !in_array($A,$used) && !in_array($B,$used)){
						$used2 = $used;
						array_push($used2,$A);
						array_push($used2,$B);
						$CD = $AB - $EF;
						$C = floor($CD / 10);
						$D = $CD % 10;
						if($C<>$D && !in_array($C,$used2) && !in_array($D,$used2)){
							echo "AB=".$AB." CD=".$CD." EF=".$EF." GH=".$GH." PPP=111\n"; 
						}
					}	
				}	
			}	
		}
	}
}

?>
