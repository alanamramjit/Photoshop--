Photoshop--
===========

### A drawing and animation language for aspiring programmers

Get Started
-----------
Check out [our final paper](http://www.cs.columbia.edu/~sedwards/classes/2014/w4115-fall/index.html) for documentation and tutorials.

Animate Shapes with Ease
-----------------------
Draw shapes and animate with ease.
`drawloop` runs 60 times per second. After each, the canvas repaints the shapes.
```
ellipse mySecondCircle = 0, 0, 100, 100, blue;

drawloop {
	mySecondCircle.x = mySecondCircle.x + 1;
}
```

Move a ball from left to right with edge detection.
```
ellipse mySecondCircle = 0, 0, 100, 100, blue;
int velocityX = 1;

drawloop {
	if (mySecondCircle.x < 0) {
		velocityX = 1;
	} else if (mySecondCircle.x + mySecondCircle.width > 700) {
		velocityX = -1;
	}

	mySecondCircle.x = mySecondCircle.x + velocityX;
}
```

Inspiration
-----
One of the most troublesome aspects of learning to program is the lack of visualization. After “hello world,” programs quickly become more complex, adding steps in the production of each output. Photoshop-- poses a solution to the widening gap between number of lines of code and the amount of feedback given for each.

Graphical user interfaces can provide immediate responses to changes in data, but are not within the scope of what new developers are capable. Nonetheless, the visual feedback from developing code that produces an animation is a rewarding introduction to programming. Photoshop-- is a graphics and animation programming language that focuses on rapid learning and ease of use. Developers create shape objects that are automatically displayed on the canvas at runtime. 

A shape-manipulation block is automatically run sixty times per second. After each update, the canvas is redrawn. This approach is simple, yet powerful, enabling the most basic of static images to complex physically realistic animations.

