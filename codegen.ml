open Printf

let file_name = "PSMMAnimator"
let window_size = 700     

let translate =
        let oc = open_out (file_name ^ ".java") in 
               fprintf oc              
"
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Rectangle2D;
import java.util.ArrayList;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;


public class " ^ file_name ^ " {
	
	public static void main(String[] args) {
		SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				createAndDisplayGUI();
			}
		});
	}
	
	public static void createAndDisplayGUI() {
		JFrame frame = new JFrame(\"My Animation Coded in Photoshop--\");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		PSMMAnimatedPanel panel = new PSMMAnimatedPanel();
		frame.add(panel);
		frame.pack();
		frame.setVisible(true);
		
		Thread t = new Thread(panel);
		t.start();
	}
}

class PSMMAnimatedPanel extends JPanel implements Runnable {
	private static final long serialVersionUID = 1L;
	public ArrayList<Shape> shapes;
	
	public PSMMAnimatedPanel() {
		shapes = new ArrayList<Shape>();
		
		// Create and add shapes
		//Shape s1 = new Shape(new Rectangle(50, 100, 300, 250), new Color(200, 100, 10), Shape.Type.RECTANGLE);
		//Shape s2 = new Shape(new Rectangle(550, 500, 100, 150), new Color(119, 37, 231), Shape.Type.ELLIPSE);
		//shapes.add(s1);
		//shapes.add(s2); " ^

(* Create and add shapes *)

		^ "
	}
	
	@Override
	public void run() {
		while (true) {
			recalculateShapes();
			repaint();

			try {
				Thread.sleep(1000 / 60);
			} catch (InterruptedException e) {
				
			}
		}	
	}
	
	private void recalculateShapes() {
		// Do stuff to shapes
		
		//for (Shape shape : shapes) {
			//shape.frame.x++;
		//} " ^

(* Perform shape operations *)

		^ "
	}
	
	public Dimension getPreferredSize() {
		return new Dimension(" ^ window_size ^ ", " ^ window_size ^ ");
	}
	
	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		Graphics2D g2 = (Graphics2D) g;
		
		System.out.println(shapes.size());
		
		for (Shape shape : shapes) {
			g2.setColor(shape.color);
			
			Rectangle frame = shape.frame;
			
			if (shape.type == Shape.Type.ELLIPSE) {
				g2.draw(new Ellipse2D.Double(frame.x, frame.y, frame.width, frame.height));
			} else if (shape.type == Shape.Type.RECTANGLE) {
				g2.draw(new Rectangle2D.Double(frame.x, frame.y, frame.width, frame.height));
			}
		}
	}
}

class Shape {
	public enum Type {
		RECTANGLE, ELLIPSE
	}
	
	public Rectangle frame;
	public Color color;
	public Type type;
	
	public Shape(Rectangle frame, Color color, Type type) {
		this.frame = frame;
		this.color = color;
		this.type = type;
	}
}
";
                 close_out oc;


