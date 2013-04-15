#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define min(a,b) ((a) < (b) ? (a) : (b))
#define max(a,b) ((a) > (b) ? (a) : (b))

int read(){
  int d;
  scanf("%d", &d);
  return d;
}

int main(){
  int T = read();
  int Case;
  for(Case = 1; Case <= T; Case++){
    int D = read();
    int I= read();
    int M = read();
    int N = read();

    fprintf(stderr, "D %d I %d M %d N %d\n",D,I,M,N);

    int _v[256], *v=_v;
    int _oldv[256], *oldv=_oldv;
    memset(v,0,sizeof(_v));
    memset(oldv,0,sizeof(_oldv));

    int i;
    for( i = 0; i < N; i++){
      int pixel = read();

      //fprintf(stderr, "Pixel: %d\n", pixel);

      int new;
      for(new = 0; new < 256; new++){
        
        v[new] = oldv[new] + D;
        
        int d_pixel_new = labs(pixel - new);

        int old;
        if(d_pixel_new <= M)
        for(old = 0; old < 256; old++){

          // go from old to new using pixel
          
          int oldcost = oldv[old];
          
          int d_old_new = labs(old - new);
          
          int usecost =
            oldcost
            + (I * (M == 0 ? (new == old ? 0 : 1) : (max(d_old_new - 1, 0) / M)))       // insert needed intermediaries
            + d_pixel_new;      // smooth

          //fprintf(stderr, "usecost %d -> %d: %d (%d)\n", old, new, usecost, d_old_new);
          if(v[new] > usecost){

            v[new] = usecost;
          }
        }
      }

      int *_tmp = v;
      v = oldv;
      oldv = _tmp;
    }
    
    int minv = oldv[0];
    int fd = 0;
    for(i = 1; i < 256; i++){
      if(minv > oldv[i]){
        minv = oldv[i];
        fd = i;
      }
    }
    
    printf("Case #%d: %d\n", Case, minv);
  }
}
