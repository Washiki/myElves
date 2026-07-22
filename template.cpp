#include <bits/stdc++.h>
using namespace std;

#define ll long long
#define pb push_back
#define pf push_front
#define pfront pop_front
#define pback pop_back

#define si set<int>
#define sc set<char>
#define vi vector<int>
#define vll vector<long long>
#define mii map<int, int>
#define pi pair<int,int>
#define umii unordered_map<int,int>
#define umll unordered_map<long long, long long>
#define di deque<int>
#define dll deque<long long>

const long long bmod = 1e9 + 7;
const int INF = 1e9;

const double eps = 1e-9;
bool isInt(double d){
	return fabs(round(d) - d) < eps;	
}

void vecInput(int n, vi& arr){
	int temp;
	for(int i = 0; i < n;i++){
		cin >> temp;
		arr.pb(temp);
	}
}

void stringToVector(const string &s, vi& result){
	for(char c : s){
		if(isdigit(c)) result.pb(c - '0');
	}
}

void firstsort(vector<pair<int,int>>& arr){
		sort(arr.begin(),arr.end(),[](const pair<int,int>& a, const pair<int,int> &b){return a.first < b.first;});
}
//[](){} <- lambda func

void secondsort(vector<pair<int,int>>& arr){
		sort(arr.begin(),arr.end(),[](const pair<int,int>& a, const pair<int,int> &b){return a.second < b.second;});
}

template <typename Iterable>
void print(const Iterable& container) {
   // std::cout << "{ ";
    for (const auto& elem : container) {
        std::cout << elem << " ";
    }
    std::cout << "\n";
}



void solve(){

}


int main(int, char**){
	ios::sync_with_stdio(0);	
	cin.tie(0);
	int testcases;
	cin >> testcases; 
	for(int test = 0; test < testcases; test++){
		solve(); 
	}
}
