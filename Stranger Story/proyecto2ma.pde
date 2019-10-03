// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Basic example of controlling an object with the mouse (by attaching a spring)

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList boundaries;
ArrayList <Mal> mals;
ArrayList<Gor> gors;
ArrayList<Bus> bus;


int estado = 0;
int value = 0;
PImage FondoLaboratorio;
PImage Bosque;
PImage Logo;
PImage Calle;
PImage Pasillo;
PImage Final;
PImage Bicicletas;
PImage Regreso;
PImage Demogorgon;
PImage demogorgonmono;
PImage guardia;
PImage Elevenfinal;
PImage Camioneta;

Box box;


// The Spring that will attach to the box from the mouse
Spring spring;

void setup() {
  size(640,360);
  smooth();
  //cargar las imágenes;
  FondoLaboratorio = loadImage("FondoLaboratorio.jpg");
  FondoLaboratorio.resize(640,360);
  Bosque = loadImage("Bosque.png");
  Bosque.resize(640,360);
  Logo = loadImage("Logo.png");
  Logo.resize(640,360);
  Calle = loadImage("Calle.jpg");
  Calle.resize(640,360);
  Pasillo = loadImage("Pasillo.jpg");
  Pasillo.resize(640,360);
  Final = loadImage("Final.jpg");
  Final.resize(640,360);
  Bicicletas = loadImage("Bicicletas.jpg");
  Bicicletas.resize(640,360);
  Regreso = loadImage("Regreso.jpg");
  Regreso.resize(640,360);
  Demogorgon = loadImage("Demogorgon.jpg");
  Demogorgon.resize(640,360);
  demogorgonmono =loadImage("demogorgonmono.png");
  guardia = loadImage("guardia.png");
  Elevenfinal = loadImage("Elevenfinal.png");
  Camioneta = loadImage("Camioneta.png");
  
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();

  // Make the box
  box = new Box(50,230);
  
  gors = new ArrayList<Gor>();
  mals = new ArrayList<Mal>();
  bus = new ArrayList<Bus>();

 
  // Make the spring (it doesn't really get initialized until the mouse is clicked)
  spring = new Spring();

  // Add a bunch of fixed boundaries
  boundaries = new ArrayList();
  boundaries.add(new Boundary(width/2,height-5,width,10,0));
  boundaries.add(new Boundary(width/2,5,width,10,0));
  boundaries.add(new Boundary(width-5,height/2,10,height,0));
  boundaries.add(new Boundary(5,height/2,10,height,0));
}

// When the mouse is released we're done with the spring
void mouseReleased() {
  spring.destroy();
}

// When the mouse is pressed we. . .
void mousePressed() {
  // Check to see if the mouse was clicked on the box
  if (box.contains(mouseX, mouseY)) {
    // And if so, bind the mouse location to the box with a spring
    spring.bind(mouseX,mouseY,box);
  }
}

void draw() {
  
  switch(estado){
    case 0:
    background(0);
    image(Logo,0,0);
    pushMatrix();
    textSize(54);
    text("STRANGER STORY",85,330);
    fill(253, 254, 254);
    textSize(15);
    text("Presiona alguna tecla para leer instrucciones",300,15);
    popMatrix();
    
    break;
    case 1:
    background(0);
     
     textSize(20);
     String s ="Instrucciones: Este juego consiste en contar un resumen de la historia de Eleven en la primera temporada de Stranger Things, para avanzar y conocer la historia tendras que manipular a Eleven haciendo click con tu Mouse, la ayudaras a pasar los obstaculos para que de esta forma pueda avanzar hasta el final de la historia.";
     text(s, 15,12,600,400);
     textSize(15);
     text("Presiona alguna tecla para comenzar",360,350);
     fill(253, 254, 254);
     
    textSize(20);
    String s2 ="Eleven quiere escapar del laboratorio Nacional de Hawkins,";
    text(s2,20,280);
    String s3 ="ayudala a esquivar a los policias y cientificos,";
    text(s3,20,300);
    String s4 ="haz click sobre el personaje de Eleven.";
    text(s4,20,320);
    fill(255);
    textSize(15);
    
     
    
    break;
    case 2:
    background(0);
  //dibujar la imagen
  image(FondoLaboratorio,0,0);
  
  pushMatrix();
  textSize(15);
     text("Presiona alguna tecla para pasar al siguiente nivel",20,15);
     fill(255);
  popMatrix();

  // We must always step through time!
  box2d.step();
  box.display();
  
    if(estado==2){
  
      if (random(20) < 0.1) {
      Mal p = new Mal(random(width),10);
      mals.add(p);
    }
  
      for(Mal b: mals){
      b.display();
      }
    }
  
  
    // Always alert the spring to the new mouse location
  spring.update(mouseX,mouseY);

  // Draw the boundaries
  for (int i = 0; i < boundaries.size(); i++) {
    Boundary wall = (Boundary) boundaries.get(i);
    wall.display();
  }

  // Draw the box
  
  // Draw the spring (it only appears when active)
  spring.display();
    
    break;
    case 3: 
    background(0);
    mals.clear();
    
    image(Bosque,0,0);
   pushMatrix();
    textSize(19);
    text("Eleven pudo huir del laboratorio, y ahora se encuentra escondida en",10,25);
    text("el inmenso bosque de Hawkins, aqui se encuentra con mike y sus",10,45);
    text("amigos, ellos estan buscando a su amigo Will que esta",10,65);
    text("desaparecido, deciden llevarla a la casa de Mike para ayudarle",10,85);
    fill( 0, 255, 0 );
    textSize(15);
     text("Presiona alguna tecla para continuar",360,350);
    popMatrix();
    break;
    
    case 4:
  
    background(0);
    //dibujar la imagen
    image(Bicicletas,0,0);
    pushMatrix();
    textSize(19);
    text("En el camino a casa de Mike una camioneta los persigue",5,25);
    text("Con los poderes de Eleven ayuda quitar a la camioneta de su camino",5,45);
    text("Selecciona la camioneta con tu Mouse y muevela sin dañar",5,65);
    text("a eleven, mike y sus amigos",5,85);
    fill( 253, 254, 254);
    textSize(15);
     text("Presiona alguna tecla para comenzar",360,350);
     fill( 253, 254, 254);
     popMatrix();
    break;
    
      case 5:
    background(0);
    image(Calle,0,0);
    //dibujar la imagen
     
     if(estado==5){
  
      if (random(10) < 0.1) {
      Bus p = new Bus(200,300);
      bus.add(p);
    }
  
      for(Bus b: bus){
      b.display();
      }
    }
  
 // boxes2.add(new Box2(500,230));
  box2d.step();
  box.display();

  /*for(Box2 b: boxes2){
    b.display();
  }*/
    // Always alert the spring to the new mouse location
  spring.update(mouseX,mouseY);

  // Draw the boundaries
  for (int i = 0; i < boundaries.size(); i++) {
    Boundary wall = (Boundary) boundaries.get(i);
    wall.display();
  }

  // Draw the box
  
  // Draw the spring (it only appears when active)
  spring.display();
  
    
    pushMatrix();
    textSize(15);
    text("Con tu Mouse manipula la camioneta",5,15);
    text("Presiona alguna tecla para pasar al siguiente nivel",250,26);
    fill( 204, 255, 204 );
    popMatrix();
    break;
    
     case 6:
    bus.clear();
    background(0);
    
    //dibujar la imagen
    image(Regreso,0,0);
    pushMatrix();
    textSize(19);
    text("Mike y sus amigos deciden llevar a Eleven a su Escuela",5,25);
    text("ya que los cientificos se encuentran en casa de Mike",5,45);
    text("para atrapar a Eleven",5,65);
    text("Presiona alguna tecla para continuar",300,350);
    fill( 204, 255, 204 );
    popMatrix();
    break;
    
    case 7:
    background(0);
    //dibujar la imagen
    image(Demogorgon,0,0);
    pushMatrix();
    textSize(19);
    text("Al escapar del laboratorio, Eleven abrio el portal",5,150);
    text("que separa al mundo real con Upside Down (un mundo",5,170);
    text("paralelo al nuestro en donde habitan criaturas",5,190);
    text("peligrosas). El demogorgon ha escapado y se encuentra",5,210);
    text("en la escuela de Hawkins, asi que Eleven tendra que",5,230);
    text("huir de él, ayudala a atravesar el pasillo, evitando",5,250);
    text("que el Demogorgon la atrape.",5,270);
    text("Presiona alguna tecla para pasar al ultimo nivel",180,350);
    fill( 255, 255, 153);
    popMatrix();
    break;
    
    case 8:
    background(0); 
    //dibujar la imagen
    image(Pasillo,0,0);
      // We must always step through time!
  box2d.step();
  box.display();
   for (Gor b: gors) {
    b.display();
  }
    // Always alert the spring to the new mouse location
  spring.update(mouseX,mouseY);
  
    if (random(10) < 0.1) {
    Gor p = new Gor(random(width),10);
    gors.add(p);
  }

  // Draw the boundaries
  for (int i = 0; i < boundaries.size(); i++) {
    Boundary wall = (Boundary) boundaries.get(i);
    wall.display();
  }

  // Draw the box
  
  // Draw the spring (it only appears when active)
  spring.display();
    break;
    
     case 9:
    background(0);
    //dibujar la imagen
    image(Final,0,0);
    break;
  }
 
  println("x",mouseX,"y",mouseY);
}

void keyPressed(){
  if (value <255) {
    estado+=1;
  }
}

void beginContact(Contact cp){
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData(); 
  Object o2 = b2.getUserData();
  
  if (o1==null || o2==null)
  return;
  
   if(o1.getClass() ==Box.class) {
     Mal p = (Mal) o2;
     mals.clear();
     
      }
}
  
void endContact(Contact cp){

}
