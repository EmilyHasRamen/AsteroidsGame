class Bullet extends Floater
{





	public Bullet(SpaceShip shipface)
	{

//		super.myColor = 255;
		super.myColor = color(255,0,0);		// red
    	super.myCenterX = shipface.getX();
    	super.myCenterY = shipface.getY();
    	super.myPointDirection = shipface.getPointDirection();
    	double dRadians =super.myPointDirection*(Math.PI/180);
    	super.myDirectionX = 5 * Math.cos(dRadians) + shipface.getDirectionX();
    	super.myDirectionY = 5 * Math.sin(dRadians) + shipface.getDirectionY();

	}
  
 	public void setX(int x){myCenterX=x;}  
	public int getX(){return (int) myCenterX;}   
	public void setY(int y){myCenterY=y;}   
	public int getY(){return (int) myCenterY;}   
	public void setDirectionX(double x){myDirectionX=x;}   
	public double getDirectionX(){return myDirectionX;}   
	public void setDirectionY(double y){myDirectionY=y;}   
	public double getDirectionY(){return myDirectionY;}   
	public void setPointDirection(int degrees){myPointDirection=degrees;}   
	public double getPointDirection(){return myPointDirection;} 

	public void show ()  //Draws the floater at the current position  
	{             
	  fill(myColor);   
	  stroke(myColor);    
      ellipse((float)myCenterX, (float)myCenterY, 5, 5);
/*
	  //convert degrees to radians for sin and cos         
	  double dRadians = myPointDirection*(Math.PI/180);                 
	  int xRotatedTranslated, yRotatedTranslated;    
	  beginShape();         
	  for(int nI = 0; nI < corners; nI++)    
	  {     
	    //rotate and translate the coordinates of the floater using current direction 
	    xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
	    yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
	    vertex(xRotatedTranslated,yRotatedTranslated);    
	  }   
	  endShape(CLOSE);  
*/
	}   

}

	