# assignment2-OMTRI
# assignment2
# HOMAKESAVADURGAPRASAD OMTRI
###### Bora-Bora Island 
**Bora-Bora Island** is my favourite vacation place located South Pacific island, northwest of Tahiti in French Polynesia. It is Surrounded by sand-fringed motus (islets) and a turquoise lagoon protected by a coral reef, it’s known for its **scuba diving**.

***
###### Directions to Mozingo Lake from maryville 
1. Take cab Maryville.
   1. the charge of the ride will be around 15$.
2. take Highway 136 east 3 miles.
   1. one the busiest road. 
   2. takes time around 30mins
3. take Liberty Road north off Highway 136
4. travel past golf course entrance
5. take 245th Street west of park entrance at Park/Lake access.

***
###### Things i enjoy at Mozingo lake are 
* Fishing 
* Boating 
* Hiking 
* Group Camp 
* Hunting 
* Golf 

***
###### Link presenting about Aboutme.
[AboutMe](https://github.com/Hkdp-Omtri/assignment2-OMTRI/blob/61ab65c42bc3ca05652fb5014d1378314ea6b4df/AboutMe.md)


***
###### Tables reagrding the Food Items
Below table shows the list of food items to be tried in the city of maryville(MO).

| Food/drink            |    Location   | Price  |
|-----------------------|:-------------:|:------:|
| Crispy Chicken Burgers|  Mcdonalds    | $1.59  |
| French Fries          |    KFC        |  $12   |
| Strawberry Slushie    | Mcdonalds     |  $10   |
| Cheese Pizza          | Pizzahut      |  $10   |

***
# Pithy Quotes

> Tell me and I forget. Teach me and I remember. Involve me and I learn. *-Benjamin Franklin*

>Don't judge each day by the harvest you reap but by the seeds that you plant. *-Robert Louis Stevenson*

***
# Code Fencing Implementation:

>Push-Relabel approach is the more efficient than Ford-Fulkerson algorithm. Quick link to the Push Relabel Algorithm (https://www.geeksforgeeks.org/push-relabel-algorithm-set-1-introduction-and-illustration/)


>Quick Link for code source:(https://cp-algorithms.com/graph/push-relabel.html)


```
const int inf = 1000000000;

int n;
vector<vector<int>> capacity, flow;
vector<int> height, excess, seen;
queue<int> excess_vertices;

void push(int u, int v)
{
    int d = min(excess[u], capacity[u][v] - flow[u][v]);
    flow[u][v] += d;
    flow[v][u] -= d;
    excess[u] -= d;
    excess[v] += d;
    if (d && excess[v] == d)
        excess_vertices.push(v);
}

void relabel(int u)
{
    int d = inf;
    for (int i = 0; i < n; i++) {
        if (capacity[u][i] - flow[u][i] > 0)
            d = min(d, height[i]);
    }
    if (d < inf)
        height[u] = d + 1;
}

void discharge(int u)
{
    while (excess[u] > 0) {
        if (seen[u] < n) {
            int v = seen[u];
            if (capacity[u][v] - flow[u][v] > 0 && height[u] > height[v])
                push(u, v);
            else 
                seen[u]++;
        } else {
            relabel(u);
            seen[u] = 0;
        }
    }
}

int max_flow(int s, int t)
{
    height.assign(n, 0);
    height[s] = n;
    flow.assign(n, vector<int>(n, 0));
    excess.assign(n, 0);
    excess[s] = inf;
    for (int i = 0; i < n; i++) {
        if (i != s)
            push(s, i);
    }
    seen.assign(n, 0);

    while (!excess_vertices.empty()) {
        int u = excess_vertices.front();
        excess_vertices.pop();
        if (u != s && u != t)
            discharge(u);
    }

    int max_flow = 0;
    for (int i = 0; i < n; i++)
        max_flow += flow[i][t];
    return max_flow;
}
```

