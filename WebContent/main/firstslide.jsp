<!doctype html>
<html>
<head>
	<meta charset='utf-8'>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>first slide</title>

	<style>
	* {margin:0;padding:0;}
	.section input[id*="slide"] {display:none;}
	.section .slidewrap {max-width:800px;margin:0 auto;}
	.section .slidelist {white-space:nowrap;font-size:0;overflow:hidden;position:relative;}
	.section .slidelist > li {display:inline-block;vertical-align:middle;width:100%;transition:all .5s;}
	.section .slidelist > li > a {display:block;position:relative;}
	.section .slidelist > li > a img {width:100%;}
	.section .slidelist label {position:absolute;z-index:5;top:50%;transform:translateY(-50%);padding:15px;cursor:pointer;}

	/* input에 체크되면 슬라이드 효과 */
	.section input[id="slide01"]:checked ~ .slidewrap .slidelist > li {transform:translateX(0%);}
	.section input[id="slide02"]:checked ~ .slidewrap .slidelist > li {transform:translateX(-100%);}
	.section input[id="slide03"]:checked ~ .slidewrap .slidelist > li {transform:translateX(-200%);}
	.section input[id="slide04"]:checked ~ .slidewrap .slidelist > li {transform:translateX(-300%);}


	/* input에 체크되면 텍스트 효과 */
	.section input[id="slide01"]:checked ~ .slidewrap li:nth-child(1) .textbox h3 {opacity:1;transform:translateY(0);transition-delay:.2s;}
	.section input[id="slide01"]:checked ~ .slidewrap li:nth-child(1) .textbox p {opacity:1;transform:translateY(0);transition-delay:.4s;}
	.section input[id="slide02"]:checked ~ .slidewrap li:nth-child(2) .textbox h3 {opacity:1;transform:translateY(0);transition-delay:.2s;}
	.section input[id="slide02"]:checked ~ .slidewrap li:nth-child(2) .textbox p {opacity:1;transform:translateY(0);transition-delay:.4s;}
	.section input[id="slide03"]:checked ~ .slidewrap li:nth-child(3) .textbox h3 {opacity:1;transform:translateY(0);transition-delay:.2s;}
	.section input[id="slide03"]:checked ~ .slidewrap li:nth-child(3) .textbox p {opacity:1;transform:translateY(0);transition-delay:.4s;}
	.section input[id="slide04"]:checked ~ .slidewrap li:nth-child(4) .textbox h3 {opacity:1;transform:translateY(0);transition-delay:.2s;}
	.section input[id="slide04"]:checked ~ .slidewrap li:nth-child(4) .textbox p {opacity:1;transform:translateY(0);transition-delay:.4s;}

	/* 좌,우 슬라이드 버튼 */
	.slide-control > div {display:none;}
	.section .left {left:2px;background:url('./img/left.png') center center / 100% no-repeat;}
	.section .right {right:2px;background:url('./img/right.png') center center / 100% no-repeat;}
	.section input[id="slide01"]:checked ~ .slidewrap .slide-control > div:nth-child(1) {display:block;}
	.section input[id="slide02"]:checked ~ .slidewrap .slide-control > div:nth-child(2) {display:block;}
	.section input[id="slide03"]:checked ~ .slidewrap .slide-control > div:nth-child(3) {display:block;}
	.section input[id="slide04"]:checked ~ .slidewrap .slide-control > div:nth-child(4) {display:block;}


	/* 페이징 */
	.slide-pagelist {text-align:center;padding:20px;}
	.slide-pagelist > li {display:inline-block;vertical-align:middle;}
	.slide-pagelist > li > label {display:block;padding:8px 30px;border-radius:30px;background:#ccc;margin:20px 10px;cursor:pointer;}
	.section input[id="slide01"]:checked ~ .slidewrap .slide-pagelist > li:nth-child(1) > label {background:#999;}
	.section input[id="slide02"]:checked ~ .slidewrap .slide-pagelist > li:nth-child(2) > label {background:#999;}
	.section input[id="slide03"]:checked ~ .slidewrap .slide-pagelist > li:nth-child(3) > label {background:#999;}
	.section input[id="slide04"]:checked ~ .slidewrap .slide-pagelist > li:nth-child(4) > label {background:#999;}

	</style>
</head>
<body>

<div class="section">
	<input type="radio" name="slide" id="slide01" checked>
	<input type="radio" name="slide" id="slide02">
	<input type="radio" name="slide" id="slide03">
	<input type="radio" name="slide" id="slide04">

	<div class="slidewrap">
		
		<ul class="slidelist">
			<!-- 슬라이드 영역 -->
			<li class="slideitem">
				<a>
					<div class="textbox"></div>
					<img src="./img/1.png">
				</a>
			</li>
			<li class="slideitem">
				<a>
					<div class="textbox"></div>
					<img src="./img/2.png">
				</a>
			</li>
			<li class="slideitem">
				<a>
					<div class="textbox"></div>
					<img src="./img/3.png">
				</a>
				</li>
				<li class="slideitem">
					<a>
						<div class="textbox"></div>
						<img src="./img/4.png">
					</a>
				</li class="slideitem">

			

			<!-- 좌,우 슬라이드 버튼 -->
			<div class="slide-control">
				<div>
					<label for="slide04" class="left"></label>
					<label for="slide02" class="right"></label>
				</div>
				<div>
					<label for="slide01" class="left"></label>
					<label for="slide03" class="right"></label>
				</div>
				<div>
					<label for="slide02" class="left"></label>
					<label for="slide04" class="right"></label>
				</div>
				<div>
					<label for="slide03" class="left"></label>
					<label for="slide01" class="right"></label>
				</div>
			</div>

		</ul>
		<!-- 페이징 -->
		<ul class="slide-pagelist">
			<li><label for="slide01"></label></li>
			<li><label for="slide02"></label></li>
			<li><label for="slide03"></label></li>
			<li><label for="slide04"></label></li>

		</ul>
	</div>
</div>
</body>
</html>
