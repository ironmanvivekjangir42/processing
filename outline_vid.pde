import processing.video.*;//import the library to use videos or cam

//declae necessary  variables
Capture video;
int col,gx,gy,val;

void setup() {
  size(640,480); //size of the output window
  video =new Capture(this,640,480);//create a capture object to capture video
  video.start();//start capturing
}

void draw() {
  if(video.available()){//this is used to delay lag
    video.read();
  }
  loadPixels();//load all the pixels
  video.loadPixels();//load pixels of the video object
  
  //itterate over all pixels except first row and column, last row and column
  for(int x=1;x<width-1; x++){
    for(int y=1; y<height-1;y++){
      int loc =x+y*width;//get location of the pixel since images are a 1D array in processing
      
      //apply the sobel transformation matrix
      //vertical edges
      gx=(-1*getcol(loc-1-width))+(-2*getcol(loc-1))+(-1*getcol(loc-1+width))+(0*getcol(loc-width))+(0*getcol(loc))+(0*getcol(loc+width))+(1*getcol(loc+1-width))+(2*getcol(loc+1))+(1*getcol(loc+1+width));
      //horizontal edges
      gy=(1*getcol(loc-1-width))+(0*getcol(loc-1))+(-1*getcol(loc-1+width))+(2*getcol(loc-width))+(0*getcol(loc))+(-2*getcol(loc+width))+(1*getcol(loc+1-width))+(0*getcol(loc+1))+(-1*getcol(loc+1+width));
      //combine both vertical and horizontal edges
      col=int(sqrt((gx*gx)+(gy*gy)));
      pixels[loc]=color(gx*2,gx*2,0);//display the new pixel we created
    }
  }
  updatePixels();
}

int getcol(int a)//function to return the grayscale value of the color of a pixel in the image
{
   float r =red(video.pixels[a]);
   float g =green(video.pixels[a]);
   float b =blue(video.pixels[a]);
   val=int((r+g+b)/3);
   return val;
}
