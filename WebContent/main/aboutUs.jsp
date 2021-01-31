<%@ page  contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!--  <link rel="stylesheet" href="aboutUs.css" /> -->
 <style type="text/css">

.about-us{
	display:flex;
	flex-direction: row;
	justify-content: center;
	align-items: flext-start;
	margin: 100px 290px;
	
	}

.capability{
	width :650px;
	margin-right: 50px;
	 color: lightseagreen;
}

.capability>h3{
	margin:0px;
	text-align: center;
	margin-bottom:10px;
	font-size:40px;
	justify-content: left;
    color: lightseagreen;
}

.capability>p{
	font-size: 23px;
	margin-bottom: 30px;
    text-align: center;
	color: graytext;
	
}
@media only screen and (max-width:620px) {
    width:100%;
  } 
  
 </style>
<title>about US</title>
</head>
<body>
      <div class ="about-us" ">
       <img src="./img/capability.png">
       <div class = "capability">
       <h3>about US</h3>
         <p> 어느 사이트보다 빠르고 정확한 일자리 정보하는데
            도움을 주기 위해 회사를 설립하였습니다. 
           빠르게 변화하는 고용시장 변화에 빠르게 대응하여
          많은 일자리를 제공할 수 있도록 다양한 시도를 할 것입니다.
           막막했던 취업 및 이직 준비도 맞춤형으로 도움을 드립니다. </p>
        </div>
      </div>
</body>
</html>