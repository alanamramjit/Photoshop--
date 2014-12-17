open Printf

let file_name = "PSMMAnimator"
let window_size = 700

(* Returns the complete Java string given tuple of strings (shape_decls, add_stmts, func_decls)  *)
let java_code (s_decls, add, funs) =
	"import java.awt.Color;\n" ^
	"import java.awt.Dimension;\n" ^
	"import java.awt.Graphics;\n" ^
	"import java.awt.Graphics2D;\n" ^
	"import java.awt.Rectangle;\n" ^
	"import java.awt.geom.Ellipse2D;\n" ^
	"import java.awt.geom.Rectangle2D;\n" ^
	"import java.util.ArrayList;\n" ^

	"import javax.swing.JFrame;\n" ^
	"import javax.swing.JPanel;\n" ^
	"import javax.swing.SwingUtilities;\n" ^


	"public class " ^ file_name ^ " {\n" ^
		
	"	public static void main(String[] args) {\n" ^
	"		SwingUtilities.invokeLater(new Runnable() {\n" ^
	"			public void run() {\n" ^
	"				createAndDisplayGUI();\n" ^
	"			}\n" ^
	"		});\n" ^
	"	}\n" ^
		
	"	public static void createAndDisplayGUI() {\n" ^
	"		JFrame frame = new JFrame(\"My Animation Coded in Photoshop--\");\n" ^
	"		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);\n" ^
			
	"		PSMMAnimatedPanel panel = new PSMMAnimatedPanel();\n" ^
	"		frame.add(panel);\n" ^
	"		frame.pack();\n" ^
	"		frame.setVisible(true);\n" ^
			
	"		Thread t = new Thread(panel);\n" ^
	"		t.start();\n" ^
	"	}\n" ^
	"}\n" ^

	"class PSMMAnimatedPanel extends JPanel implements Runnable {\n" ^
	"	private static final long serialVersionUID = 1L;\n" ^
	"	public ArrayList<Shape> shapes;\n" ^

	s_decls ^
		
	"	public PSMMAnimatedPanel() {\n" ^
	"		shapes = new ArrayList<Shape>();\n" ^
			
	"		// Create and add shapes\n" ^
	add ^
	(* Create and add shapes *)


	"	}\n" ^

	funs ^

	"	@Override\n" ^
	"	public void run() {\n" ^
	"		while (true) {\n" ^
	"			recalculateShapes();\n" ^
	"			repaint();\n" ^

	"			try {\n" ^
	"				Thread.sleep(1000 / 60);\n" ^
	"			} catch (InterruptedException e) {\n" ^
					
	"			}\n" ^
	"		}\n" ^	
	"	}\n" ^
		
	"	private void recalculateShapes() {\n" ^
	"		// Do stuff to shapes\n" ^
	"		drawloop();\n" ^
	"	}\n" ^
		
	"	public Dimension getPreferredSize() {\n" ^
	"		return new Dimension(" ^ string_of_int window_size ^ ", " ^ string_of_int window_size ^ ");\n" ^
	"	}\n" ^
		
	"	@Override\n" ^
	"	public void paintComponent(Graphics g) {\n" ^
	"		super.paintComponent(g);\n" ^
	"		Graphics2D g2 = (Graphics2D) g;\n" ^
			
	"		for (Shape shape : shapes) {\n" ^
	"			g2.setPaint(shape.color);\n" ^
				
	"			Rectangle frame = shape.frame;\n" ^
				
	"			if (shape.type == Shape.Type.ELLIPSE) {\n" ^
	"				g2.fill(new Ellipse2D.Double(frame.x, frame.y, frame.width, frame.height));\n" ^
	"			} else if (shape.type == Shape.Type.RECTANGLE) {\n" ^
	"				g2.fill(new Rectangle2D.Double(frame.x, frame.y, frame.width, frame.height));\n" ^
	"			}\n" ^
	"		}\n" ^
	"	}\n" ^
	"}\n" ^

	"class Shape {\n" ^
	"	public enum Type {\n" ^
	"		RECTANGLE, ELLIPSE\n" ^
	"	}\n" ^
		
	"	public Rectangle frame;\n" ^
	"	public Color color;\n" ^
	"	public Type type;\n" ^
		
	"	public Shape(Rectangle frame, Color color, Type type) {\n" ^
	"		this.frame = frame;\n" ^
	"		this.color = color;\n" ^
	"		this.type = type;\n" ^
	"	}\n" ^
	"}\n"  

(* Generates the Java code and prints it to a file *)
let generate_code fnv =
        let oc = open_out (file_name ^ ".java") in 
               fprintf oc "%s" (java_code fnv);
                 close_out oc;
