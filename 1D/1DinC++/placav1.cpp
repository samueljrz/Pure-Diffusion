#include <bits/stdc++.h>
using namespace std;

#define basevalue 10e-5
#define negative -1000000


void startboard(vector< vector<float> > &m, int x, int y, int u, int d, int r, int l) {
	for(int i=0; i<=y; i++) {
		for(int j=0; j<=x; j++) {
			if(i == 0) {
				m[i][j] = u;
			}else if(i == y) {
				m[i][j] = d;
			}else if(j == 0) {
				m[i][j] = l;
			}else if(j == x) {
				m[i][j] = r;
			}else {
				m[i][j] = 0;
			}
		}
	}
	m[0][0] = m[y][0] = m[0][x] = m[y][x] = -1;
}

float previousvalue(vector< vector<float> > &m, int start, int x, int y) {
	float aux = negative;
	for(int i=start; i<y; i++) {
		for(int j=start; j<x; j++) {
			aux = max(aux, fabs(m[i][j]));
		}
	}
	return aux;
}

bool thermalequilibrium(vector< vector<float> > &m, int start, int x, int y) {
	int z=0;
	float actualaux=0, previousaux=0;
	while(z != 20000) {
		for(int i=start; i<y; i++) {
			for(int j=start; j<x; j++) {
				m[i][j] = (m[i+1][j] + m[i-1][j] + m[i][j+1] + m[i][j-1])/4;
				actualaux = max(fabs(actualaux), fabs(m[i][j]));
			}
		}
		z++;
		//if((actualaux - previousaux) < basevalue) break;
		//previousaux = previousvalue(m, start, x, y);
	}
	return true;
}

int main() {
	ios_base::sync_with_stdio(false); 
	cin.tie(NULL);
	vector< vector<float> > board(1010, vector<float>(1010));
	int x, y;
	float left, right, up, down;
	FILE *pFileIn, *pFileOut;
	pFileIn = fopen("in.txt", "r");
	if(pFileIn != NULL) {
		fscanf(pFileIn, "%d %d %f %f %f %f", &x, &y, &up, &down, &right, &left);
		x++; 
		y++;
		fclose(pFileIn);
	}else {
		cout << "ERROR, Input == NULL" << endl;
		return 0;
	}
	startboard(board, x, y, up, down, right, left);
	if(thermalequilibrium(board, 1, x, y)) {
		pFileOut = fopen("out.txt", "w");
		for(int i=1; i<y; i++) {
			for(int j=1; j<x; j++) {
				fprintf(pFileOut, "%f\t", board[i][j]);
			}
			if(i != y) {
				fprintf(pFileOut, "\n");
			}
		}
		fclose(pFileOut);
	}
	return 0;
}