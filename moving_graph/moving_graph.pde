import java.util.Random;
import java.util.Arrays;

float res = 600; // The screen resolution
int N = 7; // Number of points
float vel_multi = 3.0;
Boolean[][] adj = new Boolean[N][N]; // Adjacency matrix
float[][] pos = new float[N][2]; // Position matrix
float[][] vel = new float[N][2]; // Velocity matrix
float prob = 0.5; //Probability of a connection between points
Random rand = new Random(); // instance the random class

// We represent points as a 4 vector, with the first 2 indices being position
// and the last 2 being velocity

void setup() {  // setup() runs once
  size(600,600);
  frameRate(30);
  background(0);
  
  // generate the adjacency matrix
  for(int i = 0; i < N; i++){
    for(int j = 0; j < N; j++){
     
        // The self connections are marked false   
        if(i==j){
          adj[i][j] = false;
          
      }else{
        // Determine if we generate a connection
        adj[i][j] = rand.nextFloat() < prob;    
      }
    }
    
   // generate the position and velocity matrix
   for(int point = 0; point < N; point ++){
     pos[point][0] = rand.nextFloat()*res; // x position
     pos[point][1] = rand.nextFloat()*res; // y position
     
     vel[point][0] = (rand.nextFloat() - 0.5)*vel_multi; // x velocity
     vel[point][1] = (rand.nextFloat() - 0.5)*vel_multi; // y velocity
   }
  }
}

// given a vector representing the coords of a line, draws the line
void draw_vec(float[] vec){
  stroke(255);
  line(vec[0],vec[1],vec[2],vec[3]);  
}

void draw_point(float[] vec){
  stroke(255);
  circle(vec[0],vec[1],5);
}

// given 2 vectors, creates the line vector between them
public float[] create_line(float[] p1, float[] p2){
  
  float[] line = {p1[0],p1[1],p2[0],p2[1]};
  return line;
  
}

void draw(){
  
  background(0); //clear all prev shapes
  
  // Draw the points
  for(int i = 0; i < N; i ++){
    draw_point(pos[i]);
  }
  
  // Draw the lines by looping through adj matrix
  for (int i = 0; i < N; i ++){
    for (int j = i + 1; j < N; j ++){
      
      // If there is a connection draw it
      if (adj[i][j]){
        draw_vec(create_line(pos[i],pos[j]));
      }
    }
  }
  
  // Update the position
  for(int i = 0; i < N; i ++){
    
    pos[i][0] += vel[i][0];
    pos[i][1] += vel[i][1];
    
    // Check boundary
    if (pos[i][0] > res){
      vel[i][0] = vel[i][0] * -1;
    }else if(pos[i][0] < 0){
      vel[i][0] = vel[i][0] * -1;
    }
    if (pos[i][1] > res){
      vel[i][1] = vel[i][1] * -1;
    }else if(pos[i][1] < 0){
      vel[i][1] = vel[i][1] * -1;
    } 
  }
}
