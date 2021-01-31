$(document).ready(function(){

	var deg=0;
	var	auto=true;    //자동재생
	var opacity=0.5;  //멀리 있는 이미지 불투명 정도(숫자가 작을수록 더 선명해집니다.)
	var yy=25;       //y축 3D(0이면 평면)
	var xx=300;       //x축 가로 폭 

	var images	= $('#stage img').removeClass('default').addClass('animationReady');
	var dim		= { width:images.width(),height:images.height()};
	var cnt = images.length;
	var centerX = $('#stage').width()/2;
	var centerY = $('#stage').height()/2 - dim.height/2;

	function rotate(step,total){
		deg+=step;
		var eSin,eCos,newWidth,newHeight,q;
		
		for(var i=0;i<cnt;i++){
			q = ((360/cnt)*i+deg)*Math.PI/180;
			eSin		= Math.sin(q);
			eCos		= Math.cos(q);
			q = (0.6+eSin*0.4);
			newWidth	= q*dim.width;
			newHeight	= q*dim.height;
			
			images.eq(i).css({
				top			: centerY+yy*eSin,
				left		: centerX+200*eCos,
				opacity		: 0.8+eSin*opacity,
				marginLeft	: -newWidth/2,
				zIndex		: Math.round(80+eSin*20)
			}).width(newWidth).height(newHeight);
		}

		total-=Math.abs(step);
		if(total<=0) return false;
		
		setTimeout(function(){rotate(step,total)},40);
	}
	
	rotate(-10,360/cnt);

	var turnLeft = function(){
		if(auto) autoStop();
		rotate(-10,360/cnt);
		if(auto) autoPlay();
	};
	var turnRight = function(){
		if(auto) autoStop();
		rotate(10,360/cnt);
		if(auto) autoPlay();
	};

//마우스 휠
	$('#imgCarousel').bind('mousewheel',this,function(step, delta) {					 
		if(auto) autoStop();
		rotate(delta*10,360/cnt);
		if(auto) autoPlay();
		return false;
	 });

//좌,우버튼 설정
	$('#imgCarousel .previous').click( turnRight );
	$('#imgCarousel .next').click( turnLeft );

//자동 롤링	
	var autoPlay = function(){
	  _itv = window.setInterval(turnLeft, 2000);  //롤링 시간 설정 3000=3초
	};
//롤링 스탑
	var autoStop = function(){
		window.clearInterval(_itv);
	};

//자동시작
	if(auto) autoPlay();
});

/*마우스 휠*/
(function($) {

var types = ['DOMMouseScroll', 'mousewheel'];

$.event.special.mousewheel = {
	setup: function() {
		if ( this.addEventListener )
			for ( var i=types.length; i; )
				this.addEventListener( types[--i], handler, false );
		else
			this.onmousewheel = handler;
	},
	
	teardown: function() {
		if ( this.removeEventListener )
			for ( var i=types.length; i; )
				this.removeEventListener( types[--i], handler, false );
		else
			this.onmousewheel = null;
	}
};

$.fn.extend({
	mousewheel: function(fn) {
		return fn ? this.bind("mousewheel", fn) : this.trigger("mousewheel");
	},
	
	unmousewheel: function(fn) {
		return this.unbind("mousewheel", fn);
	}
});


function handler(event) {
	var args = [].slice.call( arguments, 1 ), delta = 0, returnValue = true;
	
	event = $.event.fix(event || window.event);
	event.type = "mousewheel";
	
	if ( event.wheelDelta ) delta = event.wheelDelta/120;
	if ( event.detail     ) delta = -event.detail/3;
	
	// Add events and delta to the front of the arguments
	args.unshift(event, delta);

	return $.event.handle.apply(this, args);
}

})(jQuery);