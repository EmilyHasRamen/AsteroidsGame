/* 
To Do:
Outline for the Spaceship 
Arraylist astroids
Have two Asteroids classes, one large and one small. When a large Asteroid is removed from the ArrayList add two small ones with the same x and y 
Bullets
*/

//your variable declarations here
SpaceShip enterprise = new SpaceShip();
//Asteroid farts = new Asteroid();
//Asteroid farts[] = new Asteroid[20];
ArrayList <Asteroid> farts = new ArrayList <Asteroid>();
ArrayList <Bullet> poops = new ArrayList <Bullet>();

//  Bullets poops = new Bullets();

Star stars[]= new Star[35];
Explosion bang;
public final static int SCREENSIZE = 1000;

public void setup() 
{
  //your code here
  size(1000,1000);
  for (int n=0; n<stars.length; n++)
  {
    stars[n] = new Star();
  }
  /*
  for (int n=0; n<farts.length; n++)
  {
    farts[n] = new Asteroid();
  }
  */
  bang = new Explosion();

  for (int n = 0; n<20; n++)
    {
    farts.add(new Asteroid());
    }
    
  enterprise.setX(500);
  enterprise.setY(500);
  enterprise.setDirectionX(0);
  enterprise.setDirectionY(0);
  enterprise.setPointDirection(0);

/*
      System.out.println(1/(double)2*3);
      int[] array1 = {0,1,2,3,4,5};
      int[] array2; array2 = new int[6];
      for (int n=0; n<6; n++) {array2[n] = n;}
      int[] array3 = new int[6];
      ArrayList <Integer> theList = new ArrayList <Integer>();
      for (int nI =1; nI < 20; nI=nI*2)
      {
        theList.add(nI);
      }
      System.out.println(theList);
      theList.add(2, new Integer(100));
      System.out.println(theList);
      String[] colors = {"red", "green", "black"};
      //System.out.println(colors.get(1));
      //int nI = 4;
      //nI--;
      Boolean boo = true;
      boo = (1<3) || (3/0<1);
      System.out.println( boo );
      boo = (1<3) && (3/0<1);
      System.out.println( boo );
*/


}

public void draw() 
{
  //your code here
  background(0);

  // draw stars
  for (int n=0; n<stars.length; n++)
  {
    stars[n].show();
  }

  // draw spaceship
  enterprise.show();
  enterprise.move();

  // draw bullets
  for (int n=poops.size()-1; n>=0; n--)
  {
    /*System.out.println("("+poops.get(n).getX()+","+poops.get(n).getY()+") width =" + width +", height =" + height);
    if(poops.get(n).getX() >= width)
    {     
    System.out.println("("+poops.get(n).getX()+","+poops.get(n).getY()+") width =" + width +", height =" + height);
      poops.remove(n);  
      break;
    }    
    else if (poops.get(n).getX()<0)
    {     
    System.out.println("("+poops.get(n).getX()+","+poops.get(n).getY()+") width =" + width +", height =" + height);
      poops.remove(n);  
      break;
    }    
    if(poops.get(n).getY() >=height)
    {    
    System.out.println("("+poops.get(n).getX()+","+poops.get(n).getY()+") width =" + width +", height =" + height);
      poops.remove(n);  
      break;
    }   
    else if (poops.get(n).getY() < 0)
    {     
    System.out.println("("+poops.get(n).getX()+","+poops.get(n).getY()+") width =" + width +", height =" + height);
      poops.remove(n);  
      break;

    } 
    */  
    poops.get(n).show();
    poops.get(n).move();
  }

  // draw asteroids
  double collisionDistance = 0;
  for (int n=farts.size()-1; n>=0; n--)
  {
    farts.get(n).show();
    farts.get(n).move();
    switch(farts.get(n).getSize()) {
      case 2:   // large
        collisionDistance = 40;
        break;
      case 1:   // medium
        collisionDistance = 30;
        break;
      default:  // small
        collisionDistance = 20;
        break;
    }
    if (dist(farts.get(n).getX(), farts.get(n).getY(), enterprise.getX(), enterprise.getY()) <= collisionDistance) 
      {
        //System.out.println("collision alert: asteroid " + n);
        // add explosion at asteroid location
        bang.explode(farts.get(n).getX(), farts.get(n).getY());
        // remove asteroid
        farts.remove(n);
        enterprise.setHealth(enterprise.getHealth()-1);
        //System.out.println("HealthPoints ="+ enterprise.getHealth());
        break;

      }
    for(int i=poops.size()-1; i>=0; i--){
      if(dist(farts.get(n).getX(), farts.get(n).getY(), poops.get(i).getX(), poops.get(i).getY()) <= collisionDistance){
      bang.explode(farts.get(n).getX(), farts.get(n).getY());
      // remove asteroid
              switch(farts.get(n).getSize())
        {
        case 2:   // large
          farts.add(new Asteroid(0,farts.get(n).getX(),farts.get(n).getY()));
          farts.add(new Asteroid(0,farts.get(n).getX(),farts.get(n).getY()));
          //System.out.println("Farts size:"+farts.size());
          farts.remove(n);
          poops.remove(i);
          break;
        case 1:   // medium
          farts.remove(n);
          poops.remove(i);
          break;
        default:  // small
          farts.remove(n);
          poops.remove(i);
          break;
        }

      //farts.remove(n);
      
      break;
      }
    }
  }

  // draw explosion
  if (bang.isStarted()) {
    bang.show();
  }
}

public void keyPressed() {
  
//System.out.println("key=" + KeyEvent.getKeyCode());
  if (key=='w' || key=='W'){enterprise.accelerate(0.5);}    // up
  if (key=='s' || key=='S'){enterprise.accelerate(-0.5);}   // down
  if (key=='a' || key=='A'){enterprise.rotate(-30);}      // left
  if (key=='d' || key=='D'){enterprise.rotate(30);}       // right
  if (key=='h' || key=='H'){enterprise.hyperSpace();}     // hyperspace
  if (key==' '){poops.add(new Bullet(enterprise));}       // fire bullet
}

class Star
{
  private int posX;
  private int posY;
  private int starColor;
  private int starSize;
  public Star()
  {
    posX = (int)(Math.random()*SCREENSIZE);
    posY = (int)(Math.random()*SCREENSIZE);
    starColor = (int)(Math.random()*255);
    starSize = (int)(Math.random()*10)+1;
  } 
  public void show()
  {
//    fill(starColor);   
//    stroke(starColor);    
    fill(255);   
    stroke(255);    
    ellipse(posX, posY, starSize, starSize);
  }
}

class Explosion
{
  protected boolean started;
  protected double myCenterX, myCenterY; //holds center coordinates   
//  ArrayList <Spark> sparksList;
  ArrayList <NormalParticle> sparksList;
////  ArrayList <Particle> sparksList;
  public Explosion()
  {
    started = false;
    myCenterX = 0;
    myCenterY = 0;
//System.out.println("Explosion(N): x=" + myCenterX + ", y=" + myCenterY);
  }
  public Explosion(int x, int y)
  {
    explode(x,y);
  }
  public boolean isStarted() {return started;}
  public void show()
  {
    for (int n=0; n<sparksList.size(); n++) {
      sparksList.get(n).move();
      sparksList.get(n).show();
    }
  }
  public void explode(int x, int y)
  {
    started = true;
    myCenterX = (double)x;
    myCenterY = (double)y;
//System.out.println("Explosion(Y): x=" + myCenterX + ", y=" + myCenterY);
//    sparkList = new ArrayList <Spark>();
    sparksList = new ArrayList <NormalParticle>();
    for (int n=0; n<20; n++) {
//      Spark sparkle = new Spark(x,y);
      NormalParticle sparkle = new NormalParticle(x,y);
/*
      sparkle.setDirectionX();
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 
  public void accelerate (double dAmount) //Accelerates the floater in the direction it is pointing (myPointDirection)   
*/
      sparksList.add(sparkle);
    }
//System.out.println("Explosion(Y): sparksList size=" + sparksList.size());
  }
  /*
  private boolean isExploding;
  private int posX, posY;
  private int sparksX[12];
  private int sparksY[12];
  private int sparksDir[12];
  private int sparksDelay[12];
  private int timer;
  public Explosion(int myX, int myY);
  {
    isExploding = FALSE;
    posX = myX;
    posY = myY;
  }
  protected start();
    isExploding = TRUE;
    timer = 20;
    for (n=0; n<12; n++) {
      sparksX[n] = posX;
      sparksY[n] = posY;
      (int)(Math.random()*)
    }
  */
}

class NormalParticle implements Particle
{
  protected double dSpeed, dX, dY, dTheta;
    public NormalParticle()
    {
      dX = SCREENSIZE/2;
      dY = SCREENSIZE/2;
      setParticle();
    }
    NormalParticle(double x, double y)
    {
      dX = x;
      dY = y;
      setParticle();
    }
    public void setParticle()
    {
      dSpeed = (Math.random()*10)+2;
      dTheta = Math.PI*2*Math.random();
    }

    public void move()
    {
      dX = dX+(Math.cos(dTheta)*dSpeed);
      dY = dY+(Math.sin(dTheta)*dSpeed);
//      if ( screenX<dX || screenY<dY || dY<0 || dX<0 ) {
////        NormalParticle();
//        setParticle();
//      }
    }
    public void show()
    {
      fill(255);
      stroke(255);    
      ellipse((float)dX, (float)dY, 1, 1);
    }
    
    public void hide()
    {
      fill(0);
      stroke(0);    
      ellipse((float)dX, (float)dY, 1, 1);
    }

}
interface Particle
{
  //your code here
  public void move();
  public void show();
  public void hide();
}

/*
class Spark extends Floater
{
/ * // Floater members
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 
  public void accelerate (double dAmount) //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void rotate (int nDegreesOfRotation)  //rotates the floater by a given number of degrees
  public void move ()   //move the floater in the current direction of travel
  public void show ()  //Draws the floater at the current position  
* /
  public Spark()
  {
    myCenterX = 0;
    myCenterY = 0;
  }
  public Spark(int x, int y)
  {
    myCenterX = x;
    myCenterY = y;
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
}
*/

class Asteroid extends Floater
{
  private int rotSpeed;
  private int nSize; // 0=small, 1=medium, 2=large;

  public void newAsteroid(int nSize)
  { 
    rotSpeed = (int)(Math.random()*11)-5;


    int xRadius, yRadius;
    //nSize = (int)(Math.random()*3);         // 0=small, 1=medium, 2=large;
    if (nSize == 0) {
      xRadius = (int)(Math.random()*6)+10;  // 10 to 15
      yRadius = (int)(Math.random()*6)+10;  // 10 to 15
//    corners = 6;
    } else if (nSize == 1) {
      xRadius = (int)(Math.random()*6)+20;  // 20 to 25
      yRadius = (int)(Math.random()*6)+20;  // 20 to 25
//    corners = 12;
    } else {
      xRadius = (int)(Math.random()*11)+30;  // 30 to 40
      yRadius = (int)(Math.random()*11)+30;  // 30 to 40
//    corners = 24;
    }
//    corners = (int)(Math.random()*10)+6;  // 6 to 15 corners
      corners = (nSize+1)*6;
      xCorners = new int[corners];
      yCorners = new int[corners];
      for(int nI = 0; nI < corners; nI++) {
//        xCorners[nI] = (int)( (float) ((0.25+(Math.random()/0.75))*xRadius)*Math.cos((nI+1)*(2*Math.PI/corners)) );
//        yCorners[nI] = (int)( (float) ((0.25+(Math.random()/0.75))*yRadius)*Math.sin((nI+1)*(2*Math.PI/corners)) );
//        xCorners[nI] = (int)( (float) ((0.5+(Math.random()/0.5))*xRadius)*Math.cos((nI+1)*(2*Math.PI/corners)) );
//        yCorners[nI] = (int)( (float) ((0.5+(Math.random()/0.5))*yRadius)*Math.sin((nI+1)*(2*Math.PI/corners)) );
//        xCorners[nI] = (int)( (float) ((0.75+(Math.random()/0.25))*xRadius)*Math.cos((nI+1)*(2*Math.PI/corners)) );
//        yCorners[nI] = (int)( (float) ((0.75+(Math.random()/0.25))*yRadius)*Math.sin((nI+1)*(2*Math.PI/corners)) );
        xCorners[nI] = (int)( (float)( (1-(Math.random()*0.30))*xRadius) * Math.cos((nI+1)*(2*Math.PI/corners) ) );
        yCorners[nI] = (int)( (float)( (1-(Math.random()*0.30))*yRadius) * Math.sin((nI+1)*(2*Math.PI/corners) ) );
      }

      super.myColor = 255;
      super.myCenterX = (int)(Math.random()*SCREENSIZE);
      super.myCenterY = (int)(Math.random()*SCREENSIZE);
      super.myDirectionX = (int)(Math.random()*11)-5;
      super.myDirectionY = (int)(Math.random()*11)-5;
      super.myPointDirection = 0;
  }

  public Asteroid()
  { 
    nSize = (int)(Math.random()*3);         // 0=small, 1=medium, 2=large;
    newAsteroid(nSize);
  }
  
  public Asteroid(int mySize, double myCenterX, double myCenterY)
  { 
    nSize = mySize;

    newAsteroid(nSize);
    super.myCenterX = myCenterX;
    super.myCenterY = myCenterY;
  }

  public void move()
  {
    rotate(rotSpeed);
    super.move();
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

  public int getSize(){return nSize;}   
}

class SpaceShip extends Floater  
{   
    //your code here
   private int myHealthPoints = 8; 
   public SpaceShip() {
// NO VOID IN CONSTRUCTOR  public void SpaceShip() {
    corners = 4;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -8;
    yCorners[0] = -8;
    xCorners[1] = 16;
    yCorners[1] = 0;
    xCorners[2] = -8;
    yCorners[2] = 8;
    xCorners[3] = -2;
    yCorners[3] = 0;
    myColor = color(0, 255, 0);
  }
  public void setHealth(int healthPoints)
  {
    myHealthPoints = healthPoints;
  }

  public int getHealth()
  {
    return myHealthPoints;
  }
  public void hyperSpace() 
  {
    setDirectionY(0);
    setDirectionX(0);
    setPointDirection((int)(Math.random()*360));
    setX((int)(Math.random()*SCREENSIZE));
    setY((int)(Math.random()*SCREENSIZE));
  }
//   public int getCorners() {return corners;}
//   public int getColor() {return myColor;}

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
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 


  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     


    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
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
  }   
} 