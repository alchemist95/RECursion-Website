#include <bits/stdc++.h>
using namespace std;

#define LL long long
#define myLoop(x) for(int i=0;i<x;i++)
#define rangeLoop(x,y) for(int i=x;i<y;i++)
#define myNestedLoop(x) for(int j=0;j<x;j++)
#define MOD 1000000009
#define speedUp ios::sync_with_stdio(false)


inline  int sscan(){
	register  int n=0,c=getchar();
	while(c<'0'||c>'9')
		c=getchar();
		while(c<='9'&&c>='0'){
			n=n*10+c-'0';
			c=getchar();
	    }
	return n;
}

struct Trie{
	int data;
	struct Trie* children[2];
};

Trie *root;
