#include <stdio.h>
#include <string.h>

int read(){
  int d;
  scanf("%d", &d);
  return d;
}

int main(){
  int T = read();
  int Case;
  for(Case = 1; Case <= T; Case++){
    int N = read();
    int K = read();
    char buf[1024];
    gets(buf);

    //fprintf(stderr, "N: %d\n", N);
    //fprintf(stderr, "K: %d\n", K);

    struct { char left, top, right; } _values[N+1], *values = _values;
    memset(values, 0, sizeof(_values));
    struct { char left, top, right; } _lastvalues[N+1], *lastvalues = _lastvalues;
    memset(lastvalues, 0, sizeof(_lastvalues));

    int blue = 0, red = 0;

    char _lastrow[N+2], *lastrow = _lastrow;
    memset(lastrow, 0, sizeof(_lastrow));
    char _row[N+2], *row = _row;
    memset(row, 0, sizeof(_row));
    int i;
    for(i = 0; i < N; i++){
      gets(row+1);

      //fprintf(stderr, "Row: %s\n", row+1);

      

      if(!red || !blue){

        int j;
        int m = N;
        for(j = N; j != 0; j--){
          if(row[j] != '.'){
            if(m != j){
              row[m] = row[j];
              row[j] = '.';
            }
            m--;
          }
        }

        //fprintf(stderr, "New: %s\n", row+1);

        char last = '.';
        char lastcount = 0;
        for(j = 1; j <= N; j++){
          if(row[j] == last)
            lastcount ++;
          else
            lastcount = 1;

          if(row[j] != '.'){
            if(lastrow[j+1] == row[j]){
              values[j].right = lastvalues[j+1].right + 1;
            }else{
              values[j].right = 1;
            }
            if(lastrow[j] == row[j]){
              values[j].top = lastvalues[j].top + 1;
            }else{
              values[j].top = 1;
            }
            if(lastrow[j-1] == row[j]){
              values[j].left = lastvalues[j-1].left + 1;
            }else{
              values[j].left = 1;
            }
          }else{
            values[j].left = values[j].right = values[j].top = 0;
          }

          
          if(row[j] != '.' && (lastcount == K || values[j].left == K || values[j].top == K || values[j].right == K)){
            if(row[j] == 'R')
              red = 1;
            else
              blue = 1;
          }

          last = row[j];
        }

        int t;
        for(t = 1; t <= N; t++){
          //fprintf(stderr, "(%d%d%d)",values[t].left, values[t].top, values[t].right);
        }
        //fputs("\n", stderr);

      }
      char * _tmp = lastrow;
      lastrow = row;
      row = _tmp;

      void * _v = lastvalues;
      lastvalues = values;
      values = _v;
    }
    printf("Case #%d: %s\n", Case, red ? (blue ? "Both" : "Red" ) : (blue ? "Blue" : "Neither" ));
  }
}
