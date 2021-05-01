PShader[] sh;
PShape roshar, clouds;
PImage img, cloudsTex, alphaTex;
float textureRotation = 0, cloudsRotation = 0;
int cx, cy, mode; 

void setup(){
  size(1420,1000, P3D);
  cx = width/2;
  cy = height/2;
  mode = 1; 
  
  img = loadImage("Media/roshar.jpg");//https://botanicaxu.tumblr.com/post/144396158639/edit-map-of-roshar-without-locations
  
  cloudsTex = loadImage("Media/earthcloudmap.jpg");
  alphaTex = loadImage("Media/earthcloudmaptrans.jpg");
  
  fill(200);
  roshar = createShape(SPHERE, 250);
  roshar.setTexture(img);
  roshar.setStroke(false);
  
  clouds = createShape(SPHERE, 252);
  clouds.setStroke(false);
  
  sh = new PShader[4]; 
  sh[0] = loadShader("Shaders/frag1.glsl", "Shaders/vert1.glsl");
  sh[1] = loadShader("Shaders/frag2.glsl", "Shaders/vert1.glsl");
  sh[2] = loadShader("Shaders/frag1.glsl", "Shaders/vert2.glsl");
  sh[3] = loadShader("Shaders/frag3.glsl", "Shaders/vert3.glsl");
  sh[3].set("texMap", cloudsTex);
  sh[3].set("alphaMap", alphaTex);
  
}


void draw(){ 
  background(20); 
  switch(mode){
    case 1:
    shader(sh[0]);
    displayRoshar(textureRotation);
    break;
    case 2:
    shader(sh[1]);
    displayRoshar(textureRotation);
    break;
    case 3:
    shader(sh[1]); 
    displayRoshar(textureRotation);
        
    shader(sh[3]);
    displayClouds(-(textureRotation+cloudsRotation));
    break;
    case 4:
    shader(sh[2]);
    displayRoshar(textureRotation);
    break;
    case 5:
    shader(sh[2]);
    displayRoshar(textureRotation);
    
    shader(sh[3]);
    displayClouds(textureRotation+cloudsRotation);
    break;
    case 6:
    shader(sh[2]);
    displayRoshar(textureRotation);
    
    shader(sh[3]);
    displayClouds(-(textureRotation+cloudsRotation));
    
    break;
  }  
  

  resetShader();
  printText();
  
  textureRotation+=0.1;
  if(textureRotation>360) textureRotation = 0;
  cloudsRotation+=0.01;
  if(cloudsRotation>360) cloudsRotation = 0;
}


void displayRoshar(float rt){
    pushMatrix();
    translate(cx,cy);
    rotateY(radians(rt));
    shape(roshar);
    popMatrix();
}

void displayClouds(float rt){
    pushMatrix();
    translate(cx,cy);
    rotateY(radians(rt));
    shape(clouds);
    popMatrix(); 
}

void mousePressed(){
  if(mouseButton == LEFT){
    mode++;
    if(mode > 6) mode = 1;
  
  } else if(mouseButton == RIGHT){
    mode--;
    if(mode < 1) mode = 6;
  }
}


void printText(){
  text("Click izquiero para avanzar al siguiente modo",10,30);
  text("Click derecho para retroceder al anterior modo",10,60);
  text("Modo actual: "+mode,10,90);
  
}
