import processing.video.*;

//PImage img;
Capture video;
int col,gx,gy,val;

void setup() {
  //img = loadImage("test.jpg");
  
  size(640,480); 
  video =new Capture(this,640,480);
  video.start();
}

void draw() {
  if(video.available()){
    video.read();
  }
  loadPixels();
  video.loadPixels();
  for(int x=1;x<width-1; x++){
    for(int y=1; y<height-1;y++){
      int loc =x+y*width;
      gx=(-1*getcol(loc-1-width))+(-2*getcol(loc-1))+(-1*getcol(loc-1+width))+(0*getcol(loc-width))+(0*getcol(loc))+(0*getcol(loc+width))+(1*getcol(loc+1-width))+(2*getcol(loc+1))+(1*getcol(loc+1+width));
      gy=(1*getcol(loc-1-width))+(0*getcol(loc-1))+(-1*getcol(loc-1+width))+(2*getcol(loc-width))+(0*getcol(loc))+(-2*getcol(loc+width))+(1*getcol(loc+1-width))+(0*getcol(loc+1))+(-1*getcol(loc+1+width));
      //float r =red(img.pixels[loc]);
      //float g =green(img.pixels[loc]);
      //float b =blue(img.pixels[loc]);
      col=int(sqrt((gx*gx)+(gy*gy)));
      pixels[loc]=color(gx*2,gx*2,0);
    }
  }
  updatePixels();
}

int getcol(int a)
{
   float r =red(video.pixels[a]);
   float g =green(video.pixels[a]);
   float b =blue(video.pixels[a]);
   val=int((r+g+b)/3);
   return val;
}
