import java.text.DateFormat;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import org.gicentre.utils.stat.*;
import processing.core.PVector;
import org.gicentre.utils.move.*;

Table table;
Date dater;

ZoomPan zoomer;

PVector dataScreenLocation;
PVector dataPoint;

float[] s = {};
float[] p = {};
String[] t = {};
//Date [] d = {};

XYChart scatterplot;

void setup() {
  
  size(1200,700);   
  textFont(createFont("Arial",11),11);
  scatterplot = new XYChart(this);
  zoomer = new ZoomPan(this);  // Initialise the zoomer.
  zoomer.setMouseMask(SHIFT);
  dataScreenLocation = null;
  
  table = loadTable("texts.csv", "header, csv");

  println(table.getRowCount() + " total rows in table"); 

  for (TableRow row : table.rows()) {
    
    String time = row.getString("Date");
    String text = row.getString("Text");
    float polarity = row.getFloat("Polarity");
    float subjectivity = row.getFloat("Subjectivity");
    
    // Transform the dates from a string to a DateFormat
    String expectedPattern = "yyyy-MM-dd HH:mm:ss";
    SimpleDateFormat formatter = new SimpleDateFormat(expectedPattern);
    try {
      dater = formatter.parse(time);
    } catch (ParseException e) {
      e.printStackTrace();
    }
   
    t = append(t,text);
    p = append(p,polarity);
    s = append(s,subjectivity);
    //Date d = append(d,dater);
    
    println(dater + " | " + text);
  }
    // Sentiment analysis of the text
    scatterplot.setData(p,s);
    
    // Axis formatting and labels.
    scatterplot.showXAxis(false); 
    scatterplot.showYAxis(false);
    scatterplot.setXFormat("###,###");
    scatterplot.setXAxisLabel("\nNegative/Positive");
    scatterplot.setYAxisLabel("Passive/Active\n");
    
    //
    scatterplot.setMinX(-1);
    scatterplot.setMaxX(1);
    scatterplot.setMinY(0);
    scatterplot.setMaxY(1);
   
    // Symbol styles
    
    //map(value, start1, stop1, start2, stop2)
    
    scatterplot.setPointColour(color(251, 193, 253, 100));
    scatterplot.setPointSize(6);
  
}

void draw() {
  zoomer.transform();
  background(0);
  scatterplot.draw(20,20,width-50,height-50);
  noLoop();
}

void mousePressed() {
  dataPoint = scatterplot.getScreenToData(new PVector(mouseX,mouseY));
  if (dataPoint == null) {
    System.out.println("Outside the data area.");
  } else {
    System.out.println("Screen point of "+mouseX+","+mouseY+" gives XY data point of "+(int)dataPoint.x+","+dataPoint.y);
    // if a data point actually exists, find the corresponding text.
    for (int i=0; i<s.length; i++) {
      if ((dataPoint.x == p[i]) && (dataPoint.y == s[i])) {
      println(t[i]);
      }
    }
    //dataScreenLocation = scatterplot.getDataToScreen(dataPoint);
    //System.out.println(" // which gives screen point of "+ Math.round(dataScreenLocation.x)+","+Math.round(dataScreenLocation.y));
  }
  loop();
}